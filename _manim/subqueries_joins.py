"""Animate lecture 7 membership and JOIN multiplicity, not a physical plan.

Render: .venv/bin/manim -qm --media_dir /tmp/prba7-manim \
    _manim/subqueries_joins.py SubqueriesAndJoins
"""
from manim import (
    BLUE, DOWN, FadeIn, FadeOut, GREEN, LEFT, ORANGE, RIGHT, Scene,
    SurroundingRectangle, Text, UP, VGroup, WHITE, YELLOW, config,
)

config.background_color = "#101827"


def label(value, size=25, color=WHITE):
    """Render Polish labels with native fonts, without TeX."""
    return Text(value, font="Helvetica Neue", font_size=size, color=color)


def table(headers, rows, width=5.5):
    """Align small relations in fixed-width columns."""
    lines = VGroup()
    for index, row in enumerate([headers, *rows]):
        cells = VGroup(*[label(str(cell), 23, BLUE if index == 0 else WHITE) for cell in row])
        for col, cell in enumerate(cells):
            cell.move_to((col * width / len(headers), 0, 0))
        lines.add(cells)
    lines.arrange(DOWN, aligned_edge=LEFT, buff=0.30)
    return lines


class SubqueriesAndJoins(Scene):
    """Show nested membership, matching combinations and deduplication."""

    def heading(self, title, subtitle):
        title_text = label(title, 35).to_edge(UP, buff=0.35)
        subtitle_text = label(subtitle, 23, YELLOW).next_to(title_text, DOWN, buff=0.22)
        self.play(FadeIn(title_text), FadeIn(subtitle_text))

    def clear_scene(self):
        self.play(*[FadeOut(obj) for obj in list(self.mobjects)])

    def construct(self):
        self.heading("Podzapytania: od zbioru do wyniku", "Kto ma potwierdzony zapis na kurs SQL?")
        intro = VGroup(
            label("1. Wybierz edycje SQL", 30, BLUE),
            label("2. Wybierz potwierdzone zapisy tych edycji", 30, GREEN),
            label("3. Wybierz uczestników z tych zapisów", 30, ORANGE),
        ).arrange(DOWN, buff=0.6).shift(DOWN * 0.25)
        self.play(FadeIn(intro))
        self.play(FadeIn(label("Model logiczny — rzeczywisty plan wybiera optymalizator.", 22, YELLOW).to_edge(DOWN)))
        self.wait(6)
        self.clear_scene()

        self.heading("1. Podzapytanie wybiera edycje", "SELECT edition_id FROM editions WHERE course_id = 'SQL'")
        editions = table(["edycja", "kurs", "limit"], [
            ["E1", "SQL", "2"], ["E2", "SQL", "3"],
            ["E3", "PY", "5"], ["E4", "PY", "2"],
        ]).shift(LEFT * 3 + DOWN * 0.1)
        self.play(FadeIn(editions))
        self.play(*[FadeIn(SurroundingRectangle(editions[i], color=GREEN, buff=0.1)) for i in (1, 2)])
        self.play(FadeIn(label("Wynik: { E1, E2 }", 31, GREEN).shift(RIGHT * 3)))
        self.wait(6)
        self.clear_scene()

        self.heading("2. Zewnętrzne zapytanie filtruje zapisy", "status = 'confirmed' AND edition_id IN (E1, E2)")
        enrollments = table(["osoba", "edycja", "status"], [
            ["P1", "E1", "confirmed"], ["P1", "E2", "confirmed"],
            ["P2", "E1", "confirmed"], ["P3", "E2", "cancelled"],
            ["P3", "E3", "confirmed"],
        ], width=6).shift(LEFT * 3 + DOWN * 0.1)
        self.play(FadeIn(enrollments))
        for index in (1, 2, 3):
            self.play(FadeIn(SurroundingRectangle(enrollments[index], color=GREEN, buff=0.1)), run_time=0.7)
        output = VGroup(label("Pasują: P1, P1, P2", 29, GREEN),
                        label("P3/E2: anulowany", 22, ORANGE),
                        label("P3/E3: inny kurs", 22, ORANGE)).arrange(DOWN, buff=0.5).shift(RIGHT * 3.6)
        self.play(FadeIn(output))
        self.wait(7)
        self.clear_scene()

        self.heading("3. IN bada przynależność", "participant_id IN (P1, P1, P2)")
        people = table(["ID", "imię"], [["P1", "Anna"], ["P2", "Bartek"], ["P3", "Celina"], ["P4", "Dawid"]], 3.7).shift(LEFT * 3)
        self.play(FadeIn(people))
        for index in (1, 2):
            self.play(FadeIn(SurroundingRectangle(people[index], color=GREEN, buff=0.1)))
        result = VGroup(label("Anna", 36, GREEN), label("Bartek", 36, GREEN),
                        label("Każdy uczestnik raz.", 25), label("Powtórzone P1 nie mnoży wyniku IN.", 20)).arrange(DOWN, buff=0.45).shift(RIGHT * 3)
        self.play(FadeIn(result))
        self.wait(7)
        self.clear_scene()

        self.heading("4. JOIN tworzy pasujące kombinacje", "participants JOIN enrollments JOIN editions")
        result = table(["ID", "imię", "edycja"], [["P1", "Anna", "E1"], ["P1", "Anna", "E2"], ["P2", "Bartek", "E1"]], 5.3).shift(DOWN * 0.05)
        self.play(FadeIn(result))
        for index in (1, 2):
            self.play(FadeIn(SurroundingRectangle(result[index], color=ORANGE, buff=0.1)))
        self.play(FadeIn(label("Anna ma dwa zapisy → dwa wiersze. To poprawny raport zapisów.", 24, ORANGE).to_edge(DOWN, buff=0.65)))
        self.wait(7)
        self.clear_scene()

        self.heading("5. Jak otrzymać listę uczestników?", "SELECT DISTINCT p.participant_id, p.name ...")
        result = table(["ID", "imię"], [["P1", "Anna"], ["P2", "Bartek"]], 3.8).shift(LEFT * 3.7)
        self.play(FadeIn(result))
        notes = VGroup(label("IN / EXISTS: czy istnieje?", 27, GREEN),
                       label("JOIN: pokaż dopasowania", 27, BLUE),
                       label("DISTINCT: usuń identyczne wiersze", 23, YELLOW)).arrange(DOWN, aligned_edge=LEFT, buff=0.55).shift(RIGHT * 2.3 + DOWN * 0.2)
        self.play(FadeIn(notes))
        self.play(FadeIn(label("Najpierw ustal: jeden wiersz oznacza osobę czy zapis?", 27, YELLOW).to_edge(DOWN, buff=0.65)))
        self.wait(9)
