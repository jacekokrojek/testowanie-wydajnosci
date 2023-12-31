# Testowanie wydajności
Repozytorium z materiałami wykorzystywanymi na szkoleniu Testowanie Wydajności.
# Przygotowanie do szkolenia
- Pobierz lub sklonuj to repozytorium
- Pobierz i zainstaluj przeglądarkę FireFox ze strony https://www.mozilla.org/pl/firefox/new/
- Pobierz i zainstaluj oprogramowanie Java SE 8 lub nowsze ze strony https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
- Pobierz aplikację JMeter ze strony https://jmeter.apache.org/download_jmeter.cgi. Rozpakuj archiwum do aktualnego katalogu. Po rozpakowaniu zprawdź czy aktualny katalog ma strukturę jak poniżej

```
|   README.md
|   run-performance-test.bat
|   run-stability-test.bat
\---apache-jmeter-5.6.2
|   \---bin
|   \---docs
|   \---extras
|   \---lib
|   \---licenses
|   \---printable_docs
\---scripts
        ContactsWS.jmx
        user.properties
        users.csv
```
- W aktualnym katalogu otwórz wiersz poleceń (cmd)
- W zależności od systemu operacyjnego wykonaj poniższe polecenia:

Windows: 
```
SET IP=3.75.247.44
run-stability-test.bat
```
macOs (zsh):  
```
IP=3.75.247.44
./run-stability-test-mac.sh
```
Linux (bash):
```
export IP=3.75.247.44
./run-stability-test.sh
```

Po zakończeniu działania skryptu (ok. 5 minut) w katalogu results powinien pojawić się katalog a w nim plik 'index.html'

Link do katalogu:
https://drive.google.com/drive/folders/1gFQdXSJfKSh98gpsBH16Rde7iWWWKf2f?usp=sharing

Link do pliku z adresami IP: 
https://docs.google.com/spreadsheets/d/1EPcPBmqoAS6bVVesJIiiPV34DW0NQjEdYIHj7smaReg/edit?usp=sharing
