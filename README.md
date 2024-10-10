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

- Sprawdź czy możesz uruchomić aplikację.

 ![alt](docs/img/jmeter-start.gif)

- Sprawdź czy możesz uruchomić rekorder skryptów (HTTP(S) Test Script Recorder) w JMeter
 
 ![alt](docs/img/jmeter-record.gif)

- Sprawdź czy po wejściu w przeglądarce na adres 
  - http://18.153.7.27/ widzisz stronę Apachu2 Ubuntu Default Page
  - http://18.153.7.27:8080/ContactsWS/ widzisz strone Corporate Contacts 
