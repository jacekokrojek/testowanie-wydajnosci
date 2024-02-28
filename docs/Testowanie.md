# Wykonanie testów
Po przygotowaniu skryptów testowych i zapewnieniu stabilności środowiska testowego, możemy przystąpić do przeprowadzania testów. Każdy test powinieneś rozpocząć od rozgrzania systemu a często również z weryfikacji działania środowiska. Następnie w zależności od typu i wariantu testu przejdź do wybranej procedury.

## Weryfikacja skyptów i działania aplikacji
Często pomiędzy przygotowanie testów a ich wykonaniem mogą zajść zmiany na środowisku testowym. Przed przejściem do właściwych testów warto sprawdzić czy wszystko działa generując nieduże obciążenie i sprawdzając czy każda z testowanych akcji poprawnie się wykonuje. Ponieważ system nie jest rozgrzany w jego działaniu mogą pojawić się błędy więc można ten krok wykonać po rozgrzaniu systemu, ewentualnie zrezygnować z niego jeśli koszt analizy problemów w czasie właściwego testu jest niski.

## Rozgrzewanie środowiska
Instalując nową wersję testowanego systemu musimy pamiętać o tym, iż na pierwsze kilkanaście odpowiedzi możemy czekać znacznie dłużej. Powodów tego zjawiska jest kilka, najczęstsze to:
* Wirtualne maszyny .NET czy Java przy pierwszym przebiegu przez dany fragment kodu wykonują [kompilację JIT](https://pl.wikipedia.org/wiki/JIT_(informatyka)), który wydłuża wykonanie kodu.
* Systemy wykorzystują różnego typu (pamięci podręczne cache)[https://pl.wikipedia.org/wiki/Pami%C4%99%C4%87_podr%C4%99czna] i muszą wypełnić je odpowiednimi danymi.
* Działanie pewnych elementów systemu jest optymalizowane w odpowiedzi na określone obciążenie. 

Działanie systemu może być na tyle nieoptymalne, że po instalacji będziemy obserwować błędy. Po obsłużeniu początkowych zapytań system zaczyna działać efektywnie i jest gotowy na testy. Zjawisko to nazywamy "rozgrzewaniem systemu".

W celu zmniejszenia wpływu "rozgrzewania systemu" na wyniki testu, zaleca się po instalacji oprogramowania lub restarcie znacznie obciążyć system na pewien czas oraz zignorować uzyskane wyniki. W zależności od złożoności systemu okres "rozgrzewania" będzi się różnił ale nie powinien przekraczać kilku minut. Jeśli mamy w scenariuszach długie czasy pomiędzy akcjami użytkowników, warto na potrzeby rozgrzewania systemu maksymalnie je skrócić aby przyspieszyć ten proces.

## Baselie test
Choć nie jest to opisane w cytowanej procedurze, testy warto rozpocząć od uruchomienia testu dla jednego wirtualnego użytkownika. Czasy odpowiedzi jakie otrzymamy będą najniższymi jakie będziemy w stanie uzyskać. Już na tej podstawie będziemy mogli stwiedzić czy system spełnia stawiane mu wymagania. Wyniki będziemy mogli wykorzystać również później do pokazania jak zmieniają się w odpowiedzi na rosnące obciążenie. Warto pamiętać, że wyniczanie miar statystycznych ma sens dla odpowiednio dużej próby. W pracktyce 30 pomiarów jest absolutnym minimum ale zaleca się uzyskanie przynajmniej 100 pomiarów. 

## Określenie maksymalnych możliwości systemu
Chcąc określić maksymalne możliwości systemu będziemy stopniowo zwiększać generowany ruch i monitorować takie charakterystyki jak czas odpowiedzi na zapytania, przepustowość systemu i poziom błędnych odpowiedzi. Warto monitorować również wykorzystanie zasobów, czyli obciążenie procesora, wykorzystanie pamięci oraz sieci. 

Nie znając możliwości systemu trudno określić jaki powinien być krok o jaki zwiększamy obciążenie w każdej itereacji oraz ile iteracji powinniśmy wykonać. Jeśli mamy zdefiniowane wymagania dla systemu to na pewno pomoże to w zaplanowaniu testów. W innym wypadku pozostaje określenie parametrów eksperymentalnie. Zwykle będziemy chcieli ograniczyć czas testów a wieć również liczbę iteracji. Maksymalne obciążenie powinniśmy osiągnąć po 5-7 iteracjach. Do tego należy dodać 2-3 iteracje więcej aby pokazać jak zachowa się przeciążony system.  

Opis w sekcji "The Tests" na [Techempower - Web Framework Benchmarks](https://www.techempower.com/benchmarks/#section=motivation&hw=ph&test=fortune) aby poznać szczegóły przeprowadzanego od lat porównania wydajności frameworków web. Opisane podejście jest dobrą bazą. Nie należy się sugerować czasmi testów ani obciążeniem jakie wykorzystują autorzy akrykułu. W zależności od tego czy testujemy pojedynczą usługę czy system realizujący wiele różnych funkcji będziemy musieli odpowiedni dostosować czas każdej iteracji testu oraz obciążenie. Nie powinniśmy zapominać też o tzw. "ramp-up period" czyli czasie w jakim obciążenie wzrasta do docelowych wartości. Znaczenie tego parametru rośnie wraz ze wzrostem liczby wirtualnych użytkowników w naszym teście. Jeśli pominelibyśmy stopniowy wzrast obciążenia i w jednym momencie wygenerowali ruch od kilku dziesięciu tysięcy użytkowników stworzylibyśmy sytuację na jaką system nie jest przygotowane lub powinna być ona weryfikowana w dedykowanym teście.

## Kiedy system jest przeciążony
Typowym objawem przeciążenia systemu są błędy w odpowiedziach. Pojedyncze błędy nie oznaczają przeciążenia, choć wskazują na problemy w działaniu systemu. Do stwierdzenia, że system jest przeciążony liczba błędów powinna przekroczyć określony w wymaganiach próg. Zwykle będzie 1%, 0.1% lub 0.01%.

Niekiedy system odpowiada bez błędów ale czas odpowiedzi wydłuższa się poza określone w wymaganiach granice. Średni czas odpowiedzi lub mediana czasu odpowiedzi może być również kryterium oceny przeciążenia systemu.

