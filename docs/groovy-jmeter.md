# Groovy w JMeter
Groovy to dynamiczny język programowania oparty na JVM. W JMeterze Groovy jest szeroko stosowany ze względu na swoją prostotę, integrację z Javą oraz możliwość oraz dużą wydajność. Korzystanie z Groovy pozwala na rozszerzanie możliwości narzędzia wszędzie tam gdzie napotkamy na ograniczenia jego standardowych elementów.

Z języka Groovy w JMeter możemy korzystać na dwa sposoby:
- pisząc skrypt w elementach
  - JSR232 Sampler
  - JSR232 PrePorocessor
  - JSR232 PostPorocessor
  - JSR232 Assertion
- korzystając z funkcji __groovy()

Elementy wspierające standard JSR232 zachowują się podobnie jak inne elementy z danej grupy dając dodatkowo możliwość napisania skryptu wykonującego niedostępne w JMeter operacje. Funkcję __groovy() wykorzystujemy dla  "jednolinijkowców", zwykle w warunkach elementów sterujących. 

##  Pobieranie i wyświetlanie wartości zmiennej JMeter
Poznawanie Groovy rozpoczniemy od typowego pokazania w jaki sposób pobrać i wyświetlić wartość zmiennej JMeter

```groovy
def user = vars.get("USER")
log.info("JMeter property USER: " + user)
```
Powyższy skrypt pobiera wartość parametru (ang. property) o nazwie USER i zapisuje ją do zmiennej user, a następnie loguje tę wartość do logu JMeter.
Jeśli chcesz zobaczyć jak działa, stwórz prosty plan testu, dodaj JSR232 Sampler i wpisz w nim powyższy skrypt. Uruchom test oraz wyświetl log klikając na znak "różne niebazpieczeństwa" w prawym górnym rogu aplikacji.

Kolejny skrypt pokazuje jak wygenerować nietypowe dane testowe aby wykorzystać je w kolejnych krokach. Generujemy numer faktury bazując na aktualnej dacie i czasie i zapisujemy go w parametrze.

```groovy
import java.text.SimpleDateFormat
import java.util.Date

def dateFormat = new SimpleDateFormat("yyyyMMddHHmmss")
def invoiceNumber = "INV-" + dateFormat.format(new Date())
vars.put("invoiceNumber", invoiceNumber)
log.info("Wygenerowany numer faktury: " + invoiceNumber)
```
Zwróć uwagę, że tak jak w Java musieliśmy tu zaimportować wykorzystywane klasy.

## Sprawdzenie kodu odpowiedzi i zalogowanie odpowiedzi
Kolejne przykłady pokażą jak w różny sposób sprawdzić odpowiedź na wysłane zapytanie. Dzięki temu możesz zalogować dane tylko w wybranych przypadkach. Najczęściej wykorzystuję do tego element JSR232 PostPorcesor lub JSR232 Assertion. Dodaje taki element tak aby działał dla wszystkich zapytań. Jest to często wykorzystywana przeze mnie możliwość przy analizowaniu przyczyn błędów.

Dane ostatniego zapytania HTTP są dostępna dzięki obiektowi `prev`. Jest to obiekt typu [SamplerResult](https://jmeter.apache.org/api/org/apache/jmeter/samplers/SampleResult.html). Przykład poniżej pokazuje ja sprawdzić kod odpowiedzi i zalogować jej treść w przypadku błędu:

```groovy
def responseCode = prev.getResponseCode()
if (responseCode != "200") {
    log.info("Odpowiedź: " + prev.getResponseDataAsString())
} 
```
Rozszerzeniem przykładu powyżej jest sprawdzenia, czy treść odpowiedzi zawiera określony tekst, i ustawić asercję na fail, jeśli tekst nie zostanie znaleziony:

```groovy
def response = prev.getResponseDataAsString()
def searchText = "error"

if (!response.contains(searchText)) {
    AssertionResult.setFailure(true)
    AssertionResult.setFailureMessage("Odpowiedź nie zawiera oczekiwanego tekstu: " + searchText)
}
```

## Parsowanie i przetwarzanie odpowiedzi JSON
Groovy umożliwia łatwe parsowanie i przetwarzanie odpowiedzi JSON:

```groovy
import groovy.json.JsonSlurper

def response = prev.getResponseDataAsString()
def json = new JsonSlurper().parseText(response)

def userId = json.user.id
vars.put("userId", userId)
log.info("User ID: " + userId)
```
Powyższy skrypt parsuje odpowiedź JSON, wyodrębnia wartość user.id i zapisuje ją w zmiennej userId.

Ostatni skrypt w naszej kolekcji pokazuje jak w bardziej złożony sposób przetwarzać odpowiedź i na jej podstawie sterować przebiegiem testu. Wyszukuje on w odpowiedzi danych spełniające złożone kryteria a przypadku takich braku danych rozpoczyna kolejną iterację pętli w Loop Controller.  

```groovy
import groovy.json.JsonSlurper;

def response = prev.getResponseDataAsString()
def json = new JsonSlurper().parseText(response)

final int LESSON_CREATED = 1
def targetDay = json.children.find { day ->
    data = day.children.find { lesson ->
        lesson.ObjectData.LessonStatus != LESSON_CREATED && lesson.ObjectData.LessonId < 15
    }
}

if (targetDay != null){
	vars.put("Id", targetDay.ObjectData.LessonId as String)
	vars.put("Day", targetDay.ObjectData.Date as String)
} else {
	log.info "Brak lekcji do utworzenia!"
	ctx.setTestLogicalAction(org.apache.jmeter.threads.JMeterContext.TestLogicalAction.START_NEXT_ITERATION_OF_CURRENT_LOOP)
}
```

## Wykorzystanie funkcji __groovy()
Oprócz dedykowanych elementów, które pozwalają na wykonanie skryptów Groovy, Jmeter daje nam możliwość skorzystania z możliwości tego języka w niemal każdym polu tekstowym dowolnego elementu testu. Możemy zrobić to poprzes funckję __groovy(). Funkcja ta jako parametr przyjmuje skrypt groovy a zwraca wynik jego działania tego skryptu. Jej wykorzystanie warto rozważyć gdy chcemy wykonać drobny skrypt.

```groovy
${__groovy(200 + (Math.random() * 1000) as int,)}
```
Przy wykorzystaniu jej trzeba pamiętać o tym, że jeśli wykorzystujemy fukcję, która przyjmuje więcej niż jeden parametr to przecinek należy poprzedzić znakiem backslash.

```groovy
${__groovy(vars.get("myVar").substring(0\, 2))}
```

Wykorzystanie funkcji __groovy jest równiż zalecane w elemencie IF Contoller. Poniższy fragment zwraca wartość true lub false i umieszczony w tym elemencie odpowiednio steruje przebiegiem testu.

```groovy
${__groovy(vars.get("tokenSession") != "NOT_FOUND")}
```
## Podsumowanie
Groovy to potężne narzędzie, które znacząco zwiększa możliwości JMeter. Dzięki niemu możemy dynamicznie generować dane, przetwarzać odpowiedzi, zarządzać zmiennymi i logować istotne informacje. Skrypty Groovy w JMeter pozwalają na bardziej zaawansowane i elastyczne testy wydajnościowe, co jest kluczowe dla zapewnienia wysokiej jakości aplikacji. Korzystając z przedstawionych przykładów, można łatwo rozszerzyć swoje skrypty testowe i lepiej dostosować je do specyficznych potrzeb testowania.
