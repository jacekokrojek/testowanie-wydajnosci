# Wydajność od strony użytkownika 
Narzędzia takie jak JMeter koncentrują się na mierzeniu czasu odpowiedzi serwera. Informacje te są bardzo ważne ale nie mierzą odczuć związanych z wyświetlaniem i stabilnością elementów strony oraz możliwości interakcji użytkownika z witryną. Różnice pomiędzy czasami raportowanymi w JMeter a tym co widzi użytkownik są duże z powodu rewolucji jaka zaszła w architekturze aplikacji web. Według danych z 2023 roku witryny web wykonują średnio 71 zapytań pobierając przy tym 2.3 Mb danych. Czas wyświetlenia strony zależy jednak nie tylko od czasu pobranie tych danych ale również od czasu wykonania kodu JavaScript przez przeglądarkę.

Od czasów wydania książki "High Performance Websites" prowadzono wiele prac mających na celu pomiar szybkości działania aplikacji web i związanych z nią doświadczeń użytkowników. Przeglądatki wyposażono w wiele funkcji i API pozwalających precyzyjnie poznać proces wyświetlania treści. Powstały nowe narzędzia, zdefiniowano wiele metryk i prowadzono badania na temat ich wpływu na odczucia użytkowników. 
![Chrome Performance Insights](./img/chrome-performance.png)

## Core Web Vitals
Metryki Core Web Vitals stanowią ewolucję wcześniejszych prac. To zestaw trzech metryk, które pozwalają w łatwy sposób zrozumieć, jak dobrze witryna radzi sobie z szybkością, reaktywnością i stabilnością, a w konsekwencji, jak pozytywne jest doświadczenie użytkownika podczas przeglądania strony. 

Pierwszą z metryk jest Largest Contentful Paint (LCP), która mierzy czas potrzebny na załadowanie największego elementu widocznego w oknie przeglądarki. Mierzenie czasu do największego elementu na stronie jest kluczowe, ponieważ to właśnie ten element ma największy wpływ na postrzeganą szybkość ładowania strony przez użytkownika. Największy element zwykle zawiera najważniejsze informacje, takie jak główny obraz lub nagłówek, które są istotne dla zrozumienia zawartości strony. Im szybciej ten element jest widoczny, tym szybciej użytkownik uzyskuje dostęp do istotnych informacji, co zwiększa zadowolenie z korzystania ze strony. Elementem tym może być obraz, wideo lub duży blok tekstu. Aby zapewnić pozytywne doświadczenie użytkownika, LCP powinien wynosić poniżej 2,5 sekundy.

Dane dotyczące użycia przeglądarki Chrome pokazują, że 90% czasu spędzanego przez użytkownika na stronie przypada po jej załadowaniu. Dlatego dokładny pomiar responsywności przez cały cykl życia strony jest ważny. Właśnie to mierzy metryka Interaction to Next Paint (INP). Dokładniej INP mierzy czas, jaki upływa od momentu interakcji użytkownika z witryną (np. kliknięcia, dotknięcia ekranu) do momentu, w którym przeglądarka jest w stanie zareagować i wyświetlić następną kluczową klatkę wizualną. Pomiary dokonywane są w czasie całego pobytu użytkownika na stronie a wynik to czas najdłuższej interakcji. Dla zapewnienia pozytywnego doświadczenia użytkownika, INP powinien być jak najkrótszy, najlepiej poniżej 200 ms.

Ostatnią metryką jest Cumulative Layout Shift (CLS), która mierzy, jak często użytkownicy doświadczają niespodziewanych przesunięć elementów wizualnych na stronie. Przykładem takich przesunięć mogą być reklamy, które pojawiają się nagle i zmieniają układ strony, lub obrazy, które ładują się bez odpowiednich wymiarów. Aby zapewnić stabilność wizualną, CLS powinien wynosić poniżej 0,1.

![Core Veb Vitals](./img/cwv-google.png)

Statystyki pokazują, że strony z lepszymi wynikami Core Web Vitals mają niższy współczynnik odrzuceń i wyższy współczynnik konwersji. Badania Google wykazały, że strony osiągające docelowe wartości LCP, FID i CLS mają o 24% niższy współczynnik odrzuceń w porównaniu do stron, które nie spełniają tych kryteriów. Poprawa Core Web Vitals może więc bezpośrednio wpływać na sukces biznesowy witryny. 

Core Web Vitals stały się również jednym z kluczowych czynników rankingowych. Google wyraźnie zaznacza, że strony oferujące lepsze doświadczenie użytkownika poprzez wysokie wyniki CWV będą miały przewagę w wynikach wyszukiwania, co czyni te metryki nieodzownym elementem strategii SEO. 

Dla testerów Core Web Vitals powinny być dodatkowym elementem weryfikowanym w czasie testów, szczególnie gdy badamy wpływ obciążenia na szybkość i stabilność działania aplikacji web.

## Jak mierzyć Core Web Vitals?

Pomiaru metryk Core Web Vitals można dokonać w środowisku testowym jak i zebrać dane od rzeczywistych użytkowników. Na środowisku testowym najprościej do pomiaru manualnego skorzystać z zakładki Performance w Chrome DevTools. Prezentuaje ona metryki dla aktualnie prezentowanej strony. Jeśli chcemy zebrać nieco więcej informacji, zasymulowąć różne warunki wyświetlania strony a także otrzymać wskazówki co do poprawy jej wydajności należy przejść do zakładki Lighthouse i wykonać audyt strony. 

Lighthouse jest dostępny również jako samodzielna biblioteka, którą możemy wykorzystać do automatyzacji pomiarów. Do wykonania audytu z wykorzystaniem tej biblioteki potrzebujemy środowiska NodeJS i wykonanie 2 komend. Lighthouse ma duże możliwości konfiguracji zaczynając od  parametrów przekazanych w linii poleceń po definiowanie scenaruszy testowych w kodzie JavaScript z dokładnym wskazaniem punktów jakie chcemy audytować. Więcej informacji na stronach [Lighthouse](https://github.com/GoogleChrome/lighthouse). Warto wykonać kilku audytów i na podstawie zebranych pomiarów ocenić stabilność naszego środowiska testowego. Informacje o tym jakie czynniki mają wpływ na wyniki a także jak zwiększyć ich powtarzalność znajdziesz na stronie [Score Variablity](https://github.com/GoogleChrome/lighthouse/blob/main/docs/variability.md). Warto również wiedzieć, że dane prezentowane przez Googla w narzędziu PageSpeed Insights to 75 centyl pomiarów dla danej strony. Google tłumaczy swoje podejście koniecznością wykluczenia pomiarów obarczonych dużą ilością szumu i analizą zebranych danych. Bazując na tym podejściu sensowna wydaje się strategia aby dokonać przynajmniej 4 pomiary i podobnie jak google raportować 75 centyl. 

## Inne narzędzia
Pisząc na temat narzędzi mierzących metryki wizualne nie można pominąć dwu narzędzi Open Source. Są to WebPageTest oraz Sitespeed.io.

WebPageTest został stworzony z myślą o dostarczaniu szczegółowych informacji o tym, jak strona zachowuje się w różnych warunkach sieciowych, przy użyciu różnych przeglądarek oraz w różnych lokalizacjach geograficznych. Jest dostępne zarówno jako usługa online, jak i narzędzie do instalacji na własnym serwerze. Wersja online pozwala na szybkie przeprowadzenie testów bez potrzeby instalowania jakiegokolwiek oprogramowania, co czyni ją bardzo wygodną opcją dla początkujących. Jednak dla zaawansowanych użytkowników, instalacja WebPageTest na własnym serwerze pozwala na większą kontrolę nad środowiskiem testowym, a także na możliwość przeprowadzania testów bez ograniczeń, które mogą występować w wersji publicznej.
![WebPageTest](./img/webpagetest.png)

Narzędziem o nieco większych możliwościach ale wymagającym już instalacji jest SiteSpeed.io. Jest to modułowa aplikacji, której najważniejszymi komponentami są:
* Browsertime - kontrolujący wykonanie testów przez przeglądarki
* OnlineTest - zarządzający maszynami, na których wykonywane są testy
* Throttle - symuluje opóźnień w transimisji danych
* Coach - analiza strony i sugestie ulepszeń

Dane z Sitespeed.io w prosty sposób możemy przsyłać do bazy danych takiej jak InfluxDB a następnie prezentować w Grafana. Dzięki temu rozwiązaniu możemy łatwo monitorować zmiany w metrykach naszej aplikacji.

![SiteSpeed.io](./img/sitespeed.png)

Oba omawiane narzędzie pozwalają na wykorzystanie skryptów (np. aby zalogować się) a także integrację z narzędziami CI/CD. Opcje konfiguracji każdego z nich są bardzo bogate

## Podsumowanie
Core Web Vitals są niezbędnym elementem zapewniającym wysoką jakość doświadczeń użytkownika, a ich wpływ na ranking SEO czyni je istotnym elementem każdej strategii optymalizacyjnej. Testerzy powinni regularnie monitorować i raportować wyniki CWV, korzystając z narzędzi takich jak Google Search Console, PageSpeed Insights, oraz Lighthouse, aby zapewnić maksymalną jakość i wydajność witryn internetowych.

* [Google Web Vitals Documentation](https://web.dev/articles/vitals)
* [Lighthouse](https://https://github.com/GoogleChrome/lighthouse)
* [HTTP archive reports](https://httparchive.org/reports/state-of-the-web)

