# Środowisko testowe
Chcąc jak najszybciej wykonać testy, często zapominamy o zweryfikowaniu naszego środowiska testowego. Bardzo często skutukuje to później nieoczekiwanymi problemami i konicznością powtarzania testów. W myśl zasady "Nie mamy czasu chodzić na skróty" zadbajmy o sprawdzenenie i przygotowanie środowiska przed rozpoczęciem testów.

## Powtarzalność wyników
Najważniejszą czynnością jaką musimy wykonać przed rozpoczęciem testów to sprawdzenia na czasy odpowiedzi nie mają dużego wpływu różnego rodzaju zakłucenia. W statystyce mówimy o jednorodności pomiarów. Jeśli obserwujemy duże różnice w czasach odpowiedzi to będziemy mieć trudności aby stwierdzić czy aktualny wynik jest wiarygodny czy też jest wynikiem przypadku.

Do prostego sprawdzenia jednorodności wyników możemy wykonać test pobierając nieduży plik z testowanego serwera co 15 sekund. Taki test powinien trwać przynajmniej 2h ale warto aby był dłuższy i trwał nawet dobę. Tak długi test pozwoli nam poznać godziny w jakich najlepiej wykonywać testy. 

Analizując wyniki powinniśmy zwrócić uwagę na rozkład czasów odpowiedzi, któy powinien być zbliżony do rozkładu normalnego. Świadczą o tym poniższe heurystyki: 
* średni czas odpowiedzi jest zbliżony do mediany
* odchylenie standardowe nie większe nić połowa średniej

## Wpływ na otoczenie testowanego systemu
W czasie testów wydajnościowych będziemy symulować duże ilości akcji użytkowników. Konsekwencje tych działań są dużo większe niż w przypadku testów funkcjonalnych i należy zadbać aby nie były uciążliwe dla innych.

Bardzo łatwo przez nieuwagę przeciążyć firmowy serwer mailowy albo zostać uznanym za atakującego hackera i zostać odciętym od sieci. Nawet jeśli konsekwecje nie są poważne to często powoduje to kilkugodzinne opóźnienie i niepotrzebne poszukiwanie przyczyn problemów.

Przed rozpoczęciem testów należy zatem poinformować osoby, na które testy mogą mieć wpływ. W szczególności powinniśmy zadbać o: 
* poinformowanie działu bezpieczeństwa/utrzymania systemu aby ruch jaki wygenerujemy nie został zaklasyfikowany jako atak; często sprowadza się to do wprowadzenie odpowiednich reguł dla adresów IP z jakich generujemy obciążenie
* poinformowanie właścicieli systemów zewnętrznych, na które mogą mieć wpływ testy o naszych planach i uzgodnienie współpracy 
* odpowiednie skonfigurowanie testowanego systemu aby zmniejszyć konsekwencje testów na innych użytkowników systemu; najczęściej dotyczy to różnego rodzaju powiadomień jakie wysyła nasz system

## Monitorowanie systemu
Warto zadbać o odpowiednie monitorowanie testowanego systemu oraz dostęp do dzienników (log'ów) pozwolących na analizę problemów. Dzisiejsze systemu są zwykle są podłączone do narzędzi pozwalających obserwować zarówno wykorzystanie zasobów systemowych jaki i wpisy diagnostyczne poprzez interface web. Więcej informacji na ten temat znajdziesz w artykule [Monitorowanie](./monitorowanie.md)

## Informacje o testowanych komponentach
Przed przystąpniem do testów warto zebrać podstawowe informacje o testowanym systemie i komponentach na jakich jest uruchomiony. Jest to szczególnie ważne jeśli planujemy okresowe wykonywanie testów (np. dla każdej nowej wersji). W dłuższym horyzoncie czasu można spodziewać się, że zmianie ulegnie nie tylko testowana aplikacja ale również elementy platformy na jakiej pracuje. Warto dla każdej iteracji zapisać:
* Wersja testowanego systemu
* Wersja serwera aplikacyjnego (np. IIS) i platformy na jakich jest uruchomiony (np. .NET 6.4)
* wersję i podstawowe parametry bazy danych
* Wersja systemu operacyjnego
* Szbkość sieci
* Podstawowe parametry serwerów takie jak rodzaj CPU, ilość pamięci wielkość i rodzaj dysku twardego 
Ręczne spisywanie tych parametrów jest czasochłonne zatem warto zautomatyzować zbieranie tych informacji. 
