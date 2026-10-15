---
title: "Model Relacyjny i podstawy SQL"
---

## ✅ Sprawdź się z wykładu 3

<div id="rsod-quiz"></div>
<script src="../assets/js/quiz-engine.js"></script>
<script>
CourseQuiz.mount(document.getElementById('rsod-quiz'), {
  course: "prba2026",
  lecture: "wyklad4",
  title: "Wykład 3: Od modelu ER do modelu relacyjnego",
  submitUrl: "https://sebastianzajac.pl/rsod-quiz/submit.php",
  questions: [
    {
      id: "q1", points: 1, diff: "bardzo łatwe",
      text: "Każda encja z modelu ER staje się w modelu relacyjnym:",
      options: [
        {v:"A", t:"Kolumną"},
        {v:"B", t:"Tabelą"},
        {v:"C", t:"Kluczem obcym"},
        {v:"D", t:"Widokiem"}
      ]
    },
    {
      id: "q2", points: 1, diff: "łatwe",
      text: "Jak przekształcamy atrybut złożony (np. Adres) do modelu relacyjnego?",
      options: [
        {v:"A", t:"Zostawiamy jako jedną kolumnę tekstową"},
        {v:"B", t:"Rozbijamy na osobne kolumny (Ulica, KodPocztowy, Miasto)"},
        {v:"C", t:"Tworzymy osobną tabelę połączoną 1:1"},
        {v:"D", t:"Usuwamy go — model relacyjny nie obsługuje adresów"}
      ]
    },
    {
      id: "q3", points: 2, diff: "średnie",
      text: "Po której stronie związku 1:N umieszczamy klucz obcy?",
      options: [
        {v:"A", t:"Po stronie „1”"},
        {v:"B", t:"Po stronie „N”"},
        {v:"C", t:"W obu tabelach"},
        {v:"D", t:"W osobnej tabeli pośredniczącej"}
      ]
    },
    {
      id: "q4", points: 2, diff: "trudne",
      text: "Jak realizuje się związek N:M w modelu relacyjnym?",
      options: [
        {v:"A", t:"Kluczem obcym w jednej z tabel"},
        {v:"B", t:"Kluczem obcym w obu tabelach jednocześnie, bez dodatkowej tabeli"},
        {v:"C", t:"Przez tabelę pośredniczącą zawierającą klucze obce obu encji"},
        {v:"D", t:"N:M nie da się zrealizować relacyjnie"}
      ]
    },
    {
      id: "q5", points: 3, diff: "wnioskowanie",
      text: "Atrybut wielowartościowy „Email” zamieniamy w tabelę EMAIL(NrIndeksu, Email). Jaki to związek między STUDENT a EMAIL, i czy zgadza się to z regułą „klucz obcy dodajemy po stronie N”?",
      options: [
        {v:"A", t:"1:1 — NrIndeksu jest kluczem obcym po obu stronach"},
        {v:"B", t:"1:N (jeden student, wiele emaili) — NrIndeksu jako klucz obcy w EMAIL zgadza się z regułą klucza po stronie N"},
        {v:"C", t:"N:M — potrzebna byłaby trzecia tabela pośrednicząca"},
        {v:"D", t:"Nie da się tego sklasyfikować"}
      ]
    }
  ]
});
</script>


