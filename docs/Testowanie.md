# Wykonanie testów
Mając przygotowane skrypty oraz stabilne środowisko do testów możemy przejść do wykonania testów. O ile nie testujemy złożonego systemu na środowisku produkcyjnym, zadanie to jest stosunkowo proste. 

## Weryfikacja skyptów i działania aplikacji
Często pomiędzy przygotowanie testów a ich wykonaniem mogą zajść zmiany na środowisku testowym. Przed przejściem do właściwych testów warto zatem sprawdzić czy wszystko działa generując nieduże obciążenie. Ponieważ system nie jest rozgrzany w jego działaniu mogą pojawić się błędy więc można ten krok wykonać po rozgrzaniu systemu lub zrezygnować z niego jeśli koszt analizy problemów w czasie właściwego testu jest niski.

## Rozgrzewanie środowiska
Instalując nową wersję testowanego systemu musimy pamiętać o tym, iż na pierwsze kilkanaście odpowiedzi możemy czekać znacznie dłużej. Powodów tego zjawiska jest kilka, a najczęstsze to
* Wirtualne maszyny .NET czy Java przy pierwszym przebiegu przez dany fragment kodu wykonują [kompilację JIT](https://pl.wikipedia.org/wiki/JIT_(informatyka)), który wydłuża wykonanie kodu.
* Systemy wykorzystujące elementy Cache muszą wypełnić je odpowiednimi danymi.
* System operacyjny może zoptymalizować swoje działanie do określonego typu obciążenia. 
Działanie systemu może być na tyle nieoptymalne, że  w pierwszych minutach po instalacji będziemy obserwować błędy. Zjawisko to nazywamy "rozgrzewaniem systemu". Po obsłużeniu początkowych zapytań system zaczyna działać optymalnie i jest gotowy na testy.
W celu zmniejszenia wpływu "rozgrzewania się systemu" na wyniki testu, zaleca się po instalacji oprogramowania lub restarcie obciążyć znacznie system na pewien czas oraz zignorować uzyskane wyniki. W zależności od złożoności systemu okres "rozgrzewania" będzi się różnił ale nie powinien przekraczać kilku minut. Jeśli mamy w scenariuszach długie czasy pomiędzy akcjami użytkowników, warto na potrzeby rozgrzewania systemu maksymalnie je skrócić aby przyspieszyć ten proces.

## Baselie test
Choć nie jest to opisane w cytowanej procedurze, testy warto rozpocząć od uruchomienia testu dla jednego wirtualnego użytkownika. Czasy odpowiedzi jakie otrzymamy będą najniższymi jakie będziemy w stanie uzyskać. Już na tej podstawie będziemy mogli stwiedzić czy system spełnia stawiane mu wymagania. Wyniki będziemy mogli wykorzystać również później do pokazania jak zmieniają się w odpowiedzi na rosnące obciążenie. Warto pamiętać, że wyniczanie miar statystycznych ma sens dla odpowiednio dużej próby. W pracktyce 30 pomiarów jest absolutnym minimum ale zaleca się uzyskanie przynajmniej 100 pomiarów. 

## Określenie maksymalnych możliwości systemu
Chcąc określić maksymalne możliwości systemu będziemy stopniowo zwiększać generowany ruch i monitorować określone charakterystkyki. Zwykle będzie to czas odpowiedzi, przepustowość systemu i poziom błędnych odpowiedzi. W czasie testów warto monitorować również wykorzystanie zasobów serwerów oraz informacje o błędach w ich działaniu. Obciążenie zwiększamy do momentu gdy przekroczymy określone w wymaganiach wartości graniczne.   

Warto zapoznać się z opisem w sekcji "The Tests" na [Techempower - Web Framework Benchmarks](https://www.techempower.com/benchmarks/#section=motivation&hw=ph&test=fortune) aby poznać szczegóły przeprowadzanego od lat porównania wydajności. Opisane podejście jest dobrą bazą. Nie należy się sugerować czasmi testów ani obciążeniem jakie wykorzystują autorzy akrykułu. W zależności od tego czy testujemy pojedynczą usługę czy system realizujący wiele różnych funkcji będziemy musieli odpowiedni dostosować czas każdej iteracji testu oraz obciążenie. Nie powinniśmy zapominać też o tzw. "ramp-up period" czyli czasie w jakim obciążenie wzrasta do docelowych wartości. Znaczenie tego parametru rośnie wraz ze wzrostem liczby wirtualnych użytkowników w naszym teście. Jeśli pominelibyśmy stopniowy wzrast obciążenia i w jednym momencie wygenerowali ruch od kilku dziesięciu tysięcy użytkowników stworzylibyśmy sytuację na jaką system nie jest przygotowane lub powinna być ona weryfikowana w dedykowanym teście.
