/* Open-ended coursework submission; confirmation only after server receipt. */
(function () {
  "use strict";
  const form = document.getElementById("assignment-form");
  if (!form) return;
  const status = document.getElementById("assignment-status");
  const button = form.querySelector('button[type="submit"]');
  const fields = ["question1", "question2", "question3", "concepts", "rules", "case"];
  let pending = null;
  function collect() {
    const data = new FormData(form);
    return {
      course: "prba2026", lecture: "wyklad1",
      email: data.get("email").trim(), partner_email: data.get("partner_email").trim(),
      authors: data.get("authors").trim(),
      answers: Object.fromEntries(fields.map(key => [key, data.get(key).trim()]))
    };
  }
  document.getElementById("assignment-download").addEventListener("click", function () {
    const body = collect();
    const text = "PRBA — wykład 1\n" + body.authors + "\n" + body.email + "\n" + body.partner_email + "\n\n" +
      fields.map(key => form.elements[key].labels[0].textContent + "\n" + body.answers[key]).join("\n\n");
    const url = URL.createObjectURL(new Blob([text], {type: "text/plain;charset=utf-8"}));
    const link = document.createElement("a");
    link.href = url; link.download = "prba-wyklad1-notatka.txt"; link.click();
    setTimeout(() => URL.revokeObjectURL(url), 1000);
  });
  form.addEventListener("submit", async function (event) {
    event.preventDefault();
    if (!form.reportValidity()) return;
    const body = collect();
    if (body.partner_email && body.email.toLowerCase() === body.partner_email.toLowerCase()) {
      status.textContent = "Podaj dwa różne adresy e-mail albo pozostaw drugiego autora pustego."; return;
    }
    if (fields.slice(0, 3).some(key => !body.answers[key]) || !body.authors) {
      status.textContent = "Uzupełnij autorów oraz trzy pytania."; return;
    }
    const fingerprint = JSON.stringify(body);
    if (!pending || pending.fingerprint !== fingerprint) {
      pending = {fingerprint, id: crypto.randomUUID()};
    }
    button.disabled = true;
    status.textContent = "Zapisywanie… Poczekaj na potwierdzenie.";
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), 20000);
    try {
      const response = await fetch(form.dataset.endpoint, {
        method: "POST", headers: {"Content-Type": "application/json"},
        body: JSON.stringify({...body, request_id: pending.id}), signal: controller.signal
      });
      if (!response.ok) throw new Error("HTTP " + response.status);
      const receipt = await response.json();
      if (receipt.ok !== true || !Number.isInteger(receipt.id)) throw new Error("Invalid receipt");
      status.textContent = "Zapisano pracę nr " + receipt.id + ". Prowadzący widzi ją w panelu. " +
        "To potwierdzenie zapisu, nie ocena. Po uzupełnieniu treści możesz wysłać kolejną wersję.";
    } catch (error) {
      status.textContent = "Nie otrzymano potwierdzenia zapisu. Treść pozostała w formularzu. " +
        "Pobierz kopię i spróbuj ponownie lub zgłoś problem prowadzącemu. " +
        "Ponowienie niezmienionej pracy nie tworzy duplikatu.";
    } finally {
      clearTimeout(timer); button.disabled = false;
    }
  });
})();
