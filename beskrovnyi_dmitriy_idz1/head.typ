#let conf(title: [], subject: [], hwNumber: 0, doc) = {
  set text(font: "New Computer Modern")
  show math.equation: set block(below: 8pt, above: 9pt)
  show math.equation: set text(weight: 400)
  set math.equation(numbering: "(1)")
  set page(
    paper: "us-letter", //ams template
    margin: 1.5cm, //\usepackage(fullpage)
  )
  title.split("\n").join("\n" + [#h(11cm)]) //a bit hacky way)
  line(length: 100%)
  v(1cm)
  align(center, subject)
  align(center, "Индивидуальное домашнее задание № " + str(hwNumber))
  doc
}

#let task(tasknum: "", body) = {
  strong("Задание")
  if tasknum != "" {
    strong(" " + str(tasknum))
  }
  strong(".")
  [ ] + emph(body)
  h(1fr)
}

#let proof(body) = {
  emph[Решение.

  ]
  [ ] + body
  h(1fr)
}
