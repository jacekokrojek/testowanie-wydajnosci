# Jak analizować wyniki testów wydajnościowych
Zatem, przeprowadziłeś testy wydajności i co teraz? Siedzisz przed nic Ci nie mówiącymi tabelkami i wykresami, które przypominają Ci trasy z weekendowego wypadu w góry. Zastanawiasz się co z nich wynika. Nie martw się, pokażę Ci co zrobić żeby dane te zaczęły mówić Twoim językiem. Zaczniemy od przypomnienia podstawowych miar statystycznych. Poznamy typowe zachowanie systemu w odpowiedzi na obciżenie, a na koniec poznasz proces "skrót", który sprawdzi się w każdej naliziw danych 

## Powtórka ze statystyki
W statystyce, i w życiu codziennym, często wykorzystywaną miarą do oceny cech w polulacji jest [średnia arytmetyczna](https://pl.wikipedia.org/wiki/%C5%9Arednia_arytmetyczna). Znasz ją pewnie ze szkoły. Czasem dostawałeś piątki, czasem czwórki, może czasem było gorzej ale podkoniec roku nauczyciel sumował Twoje oceny, dzielił sumę na liczbę ocen i miał jedną wartością opisującą Twoje osiągnięcia. Przyzwyczajenia zostały i spotkasz się z tą miarą w czasie testów wydajnościowych. Wykorzystujemy ją do opisu interesujących cech systemu: czasu odpowiedzi, przepustowości oraz obciążenia poszczególnych zasobów.

Pewnie często nie zgadzałeś się z oceną bazującą na średniej i było w tym sporo racji. Średnia sprawdza się bardzo dobrze do opisu cech o rozkładzie normalnym, czyli takich, które proporcjonalnie oscylują wokół jej wartości średniej. Zatem jeśli miałeś trójkę, czwórkę i piątkę to średnia ocena 4 wydaje się być sprawiednika. Średnia jest jednak wrażliwa na wartości skrajne. Jeśli miałeś jedną jedynkę i dwie czwórki dają średnią o wartości 3. Czy to sprawiedliwa ocena jeśli miałeś w większości czwórki? Podobnie będzie jeśli wśród naszych czasów pojawi się kilka nieproporcjonalnie dłużuch wartości. Średnia będzie wysoka mimo, że większość zapytań będzie realizowana szybko. 

Rozkład, w którym wartości nie oscylują proporcjonalnie wokół średniej nazywamy asymetrycznym lub skośnym (ang. skewness). Czasy odpowiedzi mają zwykle taką charakterystykę. Wynika to z tego, że większość zadań system wykonuje  szybko ale niewielka ich część narażona jest na opóźnienia. Na wykresie wykresie obrazuje to tzw. długi ogon (ang. long tail).   

TBD wykres

Inny problem problemem w opisywanym przykładzie była nieduża liczba wartości. Średnia ma sens gdy próbek jest dużo. Na potrzeby testów wydajnościowych dobrze aby było ich przynajmniej 30 a idealnie więcej niż 100.

Średnie często pojawiają się w wymaganiach więc jesteśmy zobligowani aby go raportować. Pamiętajmy jednak aby sprawdzić czy dobrze opisują testowany system. Wykorzystamy do tego takie miary jak [mediana](https://pl.wikipedia.org/wiki/Mediana] oraz [percentyle](https://pl.wikipedia.org/wiki/Percentyl). Mediana to wartość środkowa. Oznaczo to, że 50% próbek ma od niej wartości mniejsze i tyle samo większe. Mediana jest przy tym 50 percentylem. Pewnie domyślasz się zatem, że 95 percentyl jest wartością, od której 95% próbej jest mniejszych a 5% większych. 

Idealnie aby mediana była wartością bliską średniej arytmetycznej. Oznacza to, że nie ma wartości bardzo odstających od średniej. Zawykle 95 percentyl również będzie niski. Dla użytkowników oznacza to, że będą obserwować zbliżone czasy realizowania zadań przez aplikację. Duże różnice pomiędzy średnią a medianą a także wyskoki 95 percenty świadczą o częstych opóźnieniach i powinny być dokładniej przeanalizowane.

Warto wesprzeć się w analizie histogramem, czyli wykresem, który pokazuje dystrybujce wartości. Może zobrazować na nim takie anomalie jak np. wartości oscylujące wokół dwu centrów (co pewnie może mieć miejsce gdy dwa serwery są różnie skonfigurowane). Trudno jest to odczytać z samych miar stytsycznych

Kończąc omawianie średniej dodam, że często jest ona wykorzystywane również przy generowaniu wykresów. Część narzędzi nie prezentuje na nich każdej wartości a średnią z krótkiego okresu (np. 1 minuty). Dzięki temu zabiegowi wykres jest czytelniejszy ale "wypłaszczony". Może to ukryć okresowe skoki czasów obciążenia. Sprawdź zatem czy okres dla jakiego wyliczana jest średnia nie jest zbyt długi w stosunku do długości naszego testu. Powinniśmy dobrać go tak by mieć przynajmniej 30 punktów na wykresie.

# Uff jak gorąco
Pracę serwera można porównać do pracy kuchnii w restauracji. Jeśli zamówienia pojawiają się sporadycznie, kucharz może poświęcić całą swoją uwagę i wszystkie dostępne zasoby na jedno danie. Czas przygotowania dania jest najkrótszy z możliwych. Jeśli jednak zamówień będzie więcej, kucharz zacznie pracować równocześnie nad kilkoma zamówieniami, wykorzystując czas w jakim pewne procesy nie wymagają jego uwagi. Czas realizacji każdego dania nieznacznie wzrośnie ponieważ kucharz będzie musiał dzielić swój czas na kilka zadań. Ogólnie jednak czas realizacji dań będzie krótszy niż gdybyśmy relizowali je kolejno. 

Wraz ze wzrostem liczby zamówień czas realizacji pojedynczego dania będzie rósł. Wykonywanie wielu dań równocześnie nie pozwala na idealną synchronizację. Częściowo przygotowane dania czekają coraz dłużej na ponowną uwagę kucharze. Mimo to, do pewnego momentu przepustowość kuchni będzie jednak rozła. Niestety nie będzie tak bez końca. Gdy jeden z zasobów będzie wykorzystywany w 100% przepustowośc osiągnie swój limit. Jeśli liczba zamówień będzie wciąż wzrastała zamówienia będą się kolejkować, obciążenie będzie przenosić się na kolejne elementy co zwiększy jeszcze bardzej czas realizacji dania i negatywnie wpływając też na przepustowość. Mogą pojawić się też błędy w realizacji zamówień. Coś się przypali, coś się rozleje aż w końcu kucharz powie, że ma dość i pójdzie na papierosa.

W pracy serwera kucharzem jest procesor. Do wykonania pracy wykorzystuje takie zasoby jak pamięć, dysk ale często również potrzebuje danych z innych systemów (np. baza danych). Podobnie jak kucharz, procesor, czekając na dane może przełączyć się na wykonanie zadania, dla którego dane są już dostępne. Podobnie jak w przypadku pracy kuchni, wzrost ilości równoległych zadań najbardziej będzie coraz bardziej obciążał procesora lub zasoby serwera. Gdy będą one przeciążone a czas oczekiwania na dane przekroczy limity pojawią się timeout'y a z nimi błędami w realizacji zadań.

Typowe zachowanie systemu i relacje pomiędzy liczbą użytkowników równolegle korzystających z systemu a czasem odpowiedzi, przepustowością, obciążeniem zasobów i liczbą błędów przedstawia poniższy rysunek. 

![Przeputowość, czas odpowiedzi i współczynnik błędów](img/analysis-1.png)

Właściwie zwymiarowany i skonfigurowany system powinien mieć charakterystykę podobą do widocznej na rysunku. Zatem naszym pierwszym zadaniem jest sprawdzenie czy tak jest. Jeśli zachowanie systemu jest inne powinno wzbudzić to przynajmniej Twoją ciekawość. Jeśli mimo wolnych zasobów widzisz błędne odpowiedzi zwykle oznacza to błąd w konfiguracji lub wąskie gardłow w samej aplikacji. Częstymi są to zbyt niska liczba równoległych połączeń (http lub do bazy danych) lub zbyt mała liczba plików możliwych do równoczesnego otworzenia. 
Jeśli nie możesz osiągnąć 100% wykorzystania procesora wąskim gardłem jest inny zasób. Często aplikacja loguje zbyt dużo informacji a zapis tych danych na dysk znacząco spowalnia jej pracę. Wąskim gardłem może też być przepustowość sieci albo celowe ograniczenie liczby obsługiwanych zapytań (ang. rate limit).

Jeśli system zachowuje się podobnie do przedstawionej charakterystyki, analizując wykorzystanie zasobów powinieneś móc określić jaki zasób jest wąskim gardłem. Jeśli wydajność systemu nie jest wystarczająca należy zwiększyć jego możliwości.

Musimy pamiętać, że w praktyce wykresy nie są tak płaskie jak nasz przykład referencyjny. Mogą zdarzać się odchylenia od przedstawionych wartości ale ciągle widać na nich okres zrostu, stabilizacji i spadku przepustowości  systemu.

## Analiza wyników krok po kroku
Narzędzia do przeprowadzania testów podają nam zwykle statystyki oraz wykresy dla wszystkich zapytań łącznie oraz dla każdego z zapytań oddzielnie. Dane zagregowane ze wszystkich zapytań służą do ogólnej oceny możliwości systemu. Bardzo często takie statystyki wykorzystujemy w trakcie wykonywania testów aby szybko zauważyć niepokojące zachowanie i przerwać test. Te statystyki są szczególnie przydatne gdy test generuje tak wiele zapytań, że trudno przedstawić je w czytelny sposób. 

Znacznie dokładnieszych informacji o działaniu systemu dostarczają statystyki dla poszczególnych zapytań. Analizujemy je zwykle już po wykonaniu testów, gdy mamy więcej czasu.

W każdym przypadku należy wykonać poniższe kroki:

1. Sprawdź liczbę błędów oraz ich rodzaj, przeanalizuj czy ich przyczyną może być błąd w skrypcie, danych testowych czy też problem w testowanym systemie. Znajdź odpowidające im wpisy o błędach w logach aplikacji.
2. Sprawdź średni czas odpowiedzi, porównaj go z medianą i 95 percentylem oraz wartością maksymalną
3. Sprawdź czasy odpowiedzi na wykresie, jeśli pojawiają się okresy ze zwiąkszonym lub zmniejszonymi czasami odpowiedzi przeanalizuj możliwe przyczyny, podobnie dla skoków wartości. Twoją uwagę powiennien zwrócić również stopniowy wzrost czasów odpowiedzi.
4. Sprawdź obciążenie CPU, wykorzystanie pamięci oraz zasobów io, skorelowanie ich z czasami odpowiedzi na wykresie powinno podpowiedzieć Ci jakie są przyczyny 
5. Przejrzyj logi testowanej aplikacji oraz generatora obciążenia, część problemów może być na tyle subtelna, że nie będzie powodować widocznych błędów, ale zgodnie z prawem Murphy'ego, doprowadzi do niech w najgorzym możliwym momencie.











Równolegle z analizą średnich czasów odpowiedzi powinniśmy przyjrzeć się więc centylom i różnicy pomiędzy od średniej a mediany a być może i odchyleniu standardowemu.   

https://docs.oracle.com/cd/E19957-01/819-0078-10/plan.html
https://blog.nelhage.com/post/systems-at-capacity/


Gdzie szukać informacji o błędach w działaniu aplikacji


<!-- Po wykonaniu testów wydajnościowych dysponujemy danymi o czasie wykonania odpowiedzi przy różnym obciążeniu systemu oraz błędach zaoberwowanych w odpowiedziach. Narzędzia dostarczają nam również miary statystyczne takie jak średnia, mediana czy centyle a także grafy pokazujące wyniki na osi czasu lub w formie histogramów. Pocztkujący tester może poczyć się przytłoczony taką ilością tych informacji. Od czego więc zacząć?

Pierwszym  -->
Możemy zatem powiedzieć, że przepustowość systemu (liczba dań realizowanych w danym czasie) wzrośnie.  
