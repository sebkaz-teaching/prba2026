# PRBA 2026 — Zaplecze szkoleniowe „Ośrodek Dąb”

Samodzielny scenariusz siedmiu wykładów, po polsku, dla prowadzącego. Zawiera wskazówki odpowiedzi. Projekt nie wymaga udziału w RSOD, PAS ani WDP i nie korzysta z ich baz.

## Historia i efekt końcowy

„Organizujecie indywidualne zapisy uczestników na zajęcia w fikcyjnym ośrodku szkoleniowym. Kierownik chce wiedzieć: kto bierze udział, kto prowadzi zajęcia i ile miejsc pozostało. Pierwszy arkusz działał dla jednej grupy. Teraz pojawia się kilka grup, zmiany terminów i powtórne edycje tego samego kursu”.

Efektem ma być **uzasadniony projekt bazy**, a nie aplikacja internetowa: opis reguł, ERD, schemat relacyjny, ograniczenia i zestaw zapytań sprawdzających. Wszystkie dane są syntetyczne. Nie modelujemy rzeczywistych jednostek ani procedur wojskowych.

## Kontrakt dziedziny — wspólny punkt odniesienia

- Kurs oznacza temat; edycja jest konkretnym przeprowadzeniem tego kursu.
- W tej wersji edycja zajmuje jedną salę i ma jednego prowadzącego.
- Uczestnik może zapisać się na wiele edycji, ale najwyżej raz na każdą.
- Zapis ma status `confirmed` albo `cancelled`. Anulowany zapis zachowujemy. Ponowne zgłoszenie do tej samej edycji aktualizuje ten sam zapis po sprawdzeniu limitu; nie tworzy drugiego wiersza. W tej wersji przechowujemy aktualny status, nie pełny dziennik jego zmian.
- Limit edycji jest dodatni i nie przekracza pojemności jej sali.
- Liczba potwierdzonych zapisów nie może przekroczyć limitu edycji.
- W podstawowej wersji każda edycja jest pojedynczym blokiem czasowym. Przedziały są półotwarte: początek należy do zajęć, koniec już nie; 08:00–10:00 i 10:00–12:00 nie nachodzą na siebie.
- Nakładające się edycje nie mogą korzystać z tej samej sali ani tego samego prowadzącego. Implementacja tych reguł jest rozszerzeniem; obowiązkowe jest ich rozpoznanie i opisanie.

### Mały zestaw danych do rozmowy i ręcznej kontroli

| Obiekt | Dane |
|---|---|
| Uczestnicy | U1 Ada, U2 Bartek, U3 Celina |
| Prowadzący | I1 Igor, I2 Ewa |
| Sale | S1: 2 miejsca; S2: 4 miejsca |
| Kursy | K1: obsługa wyposażenia; K2: pierwsza pomoc |
| Edycja E1 | K1, S1, I1, dzień 1 08:00–10:00, limit 2 |
| Edycja E2 | K1, S2, I2, dzień 1 10:00–12:00, limit 4 |
| Edycja E3 | K2, S2, I2, dzień 1 12:00–14:00, limit 4 |
| Zapisy | U1–E1 confirmed; U2–E1 confirmed; U3–E2 confirmed; U2–E2 cancelled |

Wolne miejsca: E1 — 0, E2 — 3, E3 — 4. U2 nie jest potwierdzonym uczestnikiem E2. Zapisane „dzień 1” to etykieta scenariusza; w bazie prowadzący wybiera jedną datę dla całego zestawu.

## Przebieg i role

Proponowany moduł 90 minut: 8 min quiz/diagnoza, 10 min rozmowa z użytkownikiem, 17 min teoria, 10 min zadanie A, 20 min zadanie B z pokazem, 15 min zmiana wymagania, 10 min obrona projektu. Od wykładu 2 użyj istniejącego quizu z poprzedniego wykładu.

Pary na zmianę pełnią role projektanta i recenzenta. Prowadzący gra klienta, odpowiada zgodnie z kontraktem powyżej. Nie oceniaj odgadywania niewypowiedzianych wymagań: jeśli grupa przyjęła inne jawne założenie, najpierw je wyjaśnij.

Projekt rozwija się w ramach tego kursu. Przed kolejnymi zajęciami przypomnij kontrakt i uzgodniony model; osoby bez poprzedniego rozwiązania mogą na nim pracować. Nie uzależniaj udziału w wykładzie od posiadania gotowego kodu SQL.

## Wykład 1 — Czego naprawdę potrzebuje kierownik?

Materiał: [Wprowadzenie](../lectures/wyklad1.qmd).

**Sytuacja:** kierownik mówi tylko: „Chcę listę ludzi i szkoleń”. To jeszcze nie specyfikacja.

**Zadanie A:** zadaj trzy pytania, od których zależy projekt. Przykładowe trafne pytania: czy kurs jest powtarzany, czy zapis można anulować, czy przechowujemy historię. Wynik: trzy pytania i zapisane odpowiedzi klienta.

**Zadanie B:** rozdziel pojęcia kursu, edycji i zapisu na przykładzie E1/E2. Oddaj słownik pojęć oraz dwie reguły spójności. Oczekiwane: wspólny temat K1 nie oznacza, że E1 i E2 są tym samym wydarzeniem.

**Nowe zdarzenie:** pokaż przejście: przed rezygnacją zapis U2–E2 miał status `confirmed`, po rezygnacji ma `cancelled`. Tabela początkowa przedstawia stan po tej zmianie. Usunięcie jego danych z całej ewidencji zniszczyłoby również zapis do E1. Dyskusja prowadzi do rozdzielenia osoby od zdarzenia/związku.

**Pytanie końcowe:** „Co trzeba ustalić przed wyborem typów kolumn?” Odpowiedź: znaczenie danych, identyfikację obiektów i reguły dziedziny.

## Wykład 2 — Diagram, który da się obronić

Materiał: [Model ER](../lectures/wyklad2.qmd).

**Sytuacja:** dwa zespoły projektowe narysowały różne diagramy. Jeden łączy uczestnika bezpośrednio z kursem, drugi z edycją.

**Zadanie A:** narysuj encje uczestnika, kursu, edycji, sali i prowadzącego oraz krotności związków. Oczekiwane: kurs 1:N edycja, sala 1:N edycja, prowadzący 1:N edycja, uczestnik M:N edycja przez zapis. Uczestnik i kurs mogą istnieć przed pierwszym zapisem/edycją.

**Zadanie B:** umieść status zapisu we właściwym miejscu. Wynik: atrybut związku/zapisu, nie uczestnika ani kursu. Wskaż minimalne i maksymalne liczności po obu stronach wybranego związku.

**Nowe zdarzenie:** ośrodek planuje edycję z dwoma prowadzącymi. To jawna zmiana kontraktu, a nie błąd wcześniejszego rozwiązania. Grupa wskazuje, które połączenie stanie się M:N; podstawowy projekt zachowuje jednego prowadzącego do końca cyklu.

**Pytanie końcowe:** „Dlaczego E3 może istnieć bez zapisów?” Odpowiedź: planowanie edycji i zapis uczestnika to osobne zdarzenia.

## Wykład 3 — Od diagramu do ograniczeń

Materiał: [Model relacyjny](../lectures/wyklad3.qmd).

**Sytuacja:** operator zapisuje U1 do E1 drugi raz. Formularz nie zauważył powtórzenia.

**Zadanie A:** przełóż ERD na `participants`, `courses`, `sessions`, `rooms`, `instructors`, `enrollments`. Zaznacz PK i FK. Dla zapisu wybierz parę `(participant_id, session_id)` jako klucz lub dodaj do niej `UNIQUE`, jeśli używasz osobnego identyfikatora.

**Zadanie B:** sklasyfikuj reguły: istnienie uczestnika — FK; dodatni limit — CHECK; brak drugiego zapisu — UNIQUE; nieprzekroczenie liczby miejsc — kontrola wielu wierszy, wymagająca dodatkowego mechanizmu przy zapisie. Oczekiwane: student nie obiecuje rozwiązania każdej reguły zwykłym CHECK pojedynczego rekordu.

**Nowe zdarzenie:** klient chce skasować salę z istniejącymi edycjami. Oddawany wynik: decyzja i jej konsekwencje. Preferowane: odrzucić usunięcie lub oznaczyć salę jako nieaktywną; automatyczne usunięcie całej historii wymagałoby osobnego uzasadnienia.

**Pytanie końcowe:** „Czy FK sam wymusza relację 1:1?” Odpowiedź: nie, potrzebna jest również odpowiednia unikalność.

## Wykład 4 — Baza zaczyna odpowiadać

Materiał: [Podstawy SQL](../lectures/wyklad4.qmd).

**Sytuacja:** dyżurny potrzebuje listy E1 oraz zestawienia obciążenia wszystkich edycji.

**Zadanie A:** odczytaj uczestników z potwierdzonym zapisem do E1. Wynik kontrolny: Ada i Bartek.

**Zadanie B:** pokaż każdą edycję i liczbę potwierdzonych zapisów, także edycje bez zapisów. Wynik: E1 — 2, E2 — 1, E3 — 0. Dla `LEFT JOIN` zwróć uwagę na miejsce warunku statusu oraz liczenie niepustego identyfikatora zapisu.

**Nowe zdarzenie:** ktoś liczy wszystkie wiersze `enrollments` i otrzymuje dla E2 dwie osoby. Studenci wskazują, dlaczego zapytanie działa technicznie, ale odpowiada na inne pytanie.

**Przygotowanie:** demonstrację DDL/DML prowadź w jednym wybranym silniku, proponowany PostgreSQL. Alternatywny wariant SQLite wymaga własnego DDL i włączonego egzekwowania FK. Scenariusz nie zawiera jeszcze gotowego skryptu inicjalizacji.

**Pytanie końcowe:** „Dlaczego nie usuwamy anulowanego zapisu tylko po to, żeby uprościć COUNT?” Odpowiedź: utracilibyśmy potrzebną historię.

## Wykład 5 — Projekt po zmianie nazwy kursu

Materiał: [Normalizacja](../lectures/wyklad5.qmd).

**Sytuacja:** jako celowo błędny wariant pokaż płaską tabelę zapisów, w której każdy wiersz powtarza nazwę kursu, nazwę sali i nazwisko prowadzącego. Nie zastępuje ona uzgodnionego dobrego modelu; służy porównaniu.

**Zadanie A:** wypisz zależności `course_id → course_name`, `room_id → capacity`, `session_id → course_id, room_id, instructor_id, starts_at, ends_at, seat_limit`. Wskaż anomalię aktualizacji, gdy zmienia się nazwa K1.

**Zadanie B:** usuń redundancję i uzasadnij odtworzenie listy uczestników przez łączenie po kluczach. Wyjaśnij różnicę między pojemnością sali a limitem edycji: limit może być mniejszy i nie jest zbędną kopią pojemności.

**Nowe zdarzenie:** klient wymaga zachowania nazwy kursu z dnia wystawienia zaświadczenia. Oczekiwane: zmienia się wymaganie historyczności; trzeba świadomie zaprojektować wersję lub zapis dokumentu, a nie mechanicznie usuwać każdą powtórzoną nazwę.

**Pytanie końcowe:** „Czy dwie podobne wartości zawsze są redundancją?” Odpowiedź: nie; trzeba porównać ich znaczenie i reguły zmiany.

## Wykład 6 — Dlaczego lista zapisów zwalnia?

Materiał: [Optymalizacja](../lectures/wyklad6.qmd).

**Sytuacja:** raport jednej edycji jest odczytywany często, a historia obejmuje wiele edycji.

**Zadanie A:** zaproponuj indeks do wyszukania potwierdzonych zapisów po `session_id`. Porównaj go z istniejącą unikalnością `(participant_id, session_id)`. Oczekiwane: kolejność kolumn ma znaczenie; fakt posiadania jakiegoś indeksu nie dowodzi, że wspiera dany dostęp.

**Zadanie B:** na dostarczonym planie i pomiarze porównaj zapytanie przed i po dodaniu indeksu. Wynik: krótka rekomendacja z dowodem, nie „indeks zawsze przyspiesza”. Na malutkim zestawie dopuszczalny jest brak poprawy.

**Nowe zdarzenie:** w ciągu kilku minut napływa dużo zapisów. Grupa wskazuje, że każdy dodatkowy indeks ma koszt utrzymania przy zmianie danych.

**Przygotowanie:** prowadzący przygotowuje większy syntetyczny zbiór oraz plany w tym samym silniku i na tym samym zapytaniu. Nie wyciągamy wniosków wydajnościowych z trzech edycji.

**Pytanie końcowe:** „Czy szybszy raport rozwiązuje przekroczenie limitu miejsc?” Odpowiedź: nie; wydajność i poprawność współbieżnego zapisu to odrębne własności.

## Wykład 7 — Raport gotowy do decyzji

Materiał: [Podzapytania i widoki](../lectures/wyklad7.qmd).

**Sytuacja:** kierownik chce zobaczyć edycje bez potwierdzonych uczestników i wolne miejsca bez ręcznego przeglądania tabel.

**Zadanie A:** znajdź edycje, dla których nie istnieje potwierdzony zapis. Oczekiwany wynik `NOT EXISTS`: E3. Dodaj osobny wariant z wyłącznie anulowanymi zapisami i sprawdź, że taka edycja również trafia do wyniku.

**Zadanie B:** zaproponuj widok z identyfikatorem edycji, nazwą kursu, limitem, liczbą potwierdzonych zapisów i liczbą wolnych miejsc. Wynik kontrolny: 0, 3, 4 wolne miejsca dla E1, E2, E3. Nie umieszczaj nazwisk w raporcie, który ich nie potrzebuje.

**Nowe zdarzenie:** dwie osoby odczytały ostatnie wolne miejsce, zanim którakolwiek się zapisała. Oczekiwane: widok informuje o stanie odczytu, ale nie rezerwuje miejsca. W projekcie trzeba wskazać miejsce atomowego egzekwowania limitu; implementacja transakcji nie jest warunkiem zaliczenia tej karty.

**Obrona projektu:** każda para pokazuje jedną regułę, jej implementację lub ograniczenie implementacji oraz przykład danych, które powinny zostać odrzucone.

## Jak oceniać

Propozycja formatywna: 0–2 pkt poprawność modelu/wyniku, 0–1 zgodność z jawnymi wymaganiami, 0–1 kontrprzykład sprawdzający regułę. Dopuszczaj różne nazwy i poprawne warianty kluczy. Nie nagradzaj liczby tabel ani rozmiaru diagramu. Przy zmianie wymagań oceniaj świadomą adaptację, nie zgodność z jednym rysunkiem prowadzącego.

Przed zajęciami przygotuj karty danych, diagram wzorcowy zgodny z kontraktem oraz bazę demonstracyjną na wykłady 4, 6 i 7. Dokument jest scenariuszem prowadzenia, nie gotowym środowiskiem ani opublikowaną stroną studencką.
