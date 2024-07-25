# Zadania i materiały dodatkowe do szkolenia

## Analiza wymagań
Materiały opisujące zachowania użytkowników systemów e-learningowych
* [Massive Open Online Course Report 2013](docs/01-analiza-wymagan/BR1-MOOC-report-2013.pdf)
* [Overview statistics for the International Programmes’ Coursera MOOCs](docs/01-analiza-wymagan/BR2-Overview-statistics-for-the-nternational-MOOCs.pdf)

## Planowanie

Przykłady pokazujące planowanie testów
* [Arkusz przygotowań do testów](docs/Przyklady%20raportow%20i%20specyfikacji/SPORTSHOP/Analiza%20i%20planowanie.xlsx)

## Wykonanie testów

Przykładowe procedury
* [TechEmpower Benchamrks - Motivation and Questions](https://www.techempower.com/benchmarks/#section=motivation) 

### Testowanie Corporate Contacts 

* Ścieżki URL do zadań

    | Zadanie                | URL                          |
    |------------------------|------------------------------|
    | Stabilność środowiska  | ContactsWS/img/sjsi.png      |
    | Wydajność zapytania    | ContactsWS/login             |
    | Zapytania SOAP         | ContactsWS/getData           |


* Dane do logowania

    | Login | Hasło     |
    |-------|-----------|
    | p0001 | 12p000109 |

* Dane do wyszukiwania użytkowników

    ```csv
    ZGSFAQXTQ,VDGTYTZQO
    ADCBUJYRF,BHSNPQUNL
    CORQEZTKI,DGUNKVUKR
    NPQGMXJTA,FYKCJBEWS
    ```

* Zapytanie confirmUser

    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:pl="http://pl.ericpol.contacts.ws/">
    <soapenv:Header/>
    <soapenv:Body>
        <pl:confirmUser>
            <username>p0001</username>
            <password>12p000109</password>
        </pl:confirmUser>
    </soapenv:Body>
    </soapenv:Envelope>
    ```

* Zapytanie getPeople
    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:pl="http://pl.ericpol.contacts.ws/">
    <soapenv:Header/>
    <soapenv:Body>
        <pl:getPeople>
            <username>p0001</username>
            <sessionToken>5846a95451fd3fbb8641dfcc42f6796a</sessionToken>
        </pl:getPeople>
    </soapenv:Body>
    </soapenv:Envelope>
    ```

### Testowanie Moodle 

* Ścieżki URL do zadań

    | Zadanie                | URL                          |
    |------------------------|------------------------------|
    | Strona główna          | moodle                       |

* Dane do logowania

    | Login       | Hasło     |
    |-------------|-----------|
    | student0001 | Q!w2e3r4  |
    | student0100 | Q!w2e3r4  |