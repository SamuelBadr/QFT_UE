#import "@preview/physica:0.9.5": dd, grad, hbar, ket, laplacian, vb
#import "@preview/simple-plot:0.3.0": line-plot, plot
// #import "@preview/lilaq:0.5.0" as lq

#set page(
  paper: "a4",
  margin: (x: 2.2cm, y: 2.3cm),
  numbering: "1",
)

#let ink = rgb("#143642")
#let accent = rgb("#1f7a8c")
#let accent-soft = rgb("#eef7f8")
#let accent-line = rgb("#8db9c0")
#let warm = rgb("#c97c5d")
#let warm-soft = rgb("#fcf2ee")
#let warm-line = rgb("#d9a08c")

// https://forum.typst.app/t/how-to-transform-all-math-cases-with-its-children-to-be-in-math-display-mode/3615/4
#let dcases(..args) = math.cases(..args.pos().map(math.display), ..args.named())

#set text(
  font: "Libertinus Serif",
  size: 11pt,
  fill: ink,
)

#set par(
  justify: true,
  leading: 0.65em,
)

#show heading.where(level: 1): it => [
  #v(1.25em)
  #block(inset: (bottom: 0.2em))[
    #text(size: 16pt, weight: "bold", fill: accent)[#it.body]
  ]
  #line(length: 100%, stroke: (paint: accent-line, thickness: 1.1pt))
  #v(0.5em)
]

#show heading.where(level: 2): it => [
  #v(0.9em)
  #block(inset: (x: 0.45em, y: 0.15em), radius: 8pt, fill: accent-soft)[
    #text(weight: "semibold", fill: accent)[#it.body]
  ]
  #v(0.25em)
]

#let sheet-header(title, subtitle, date: none) = align(center)[
  #block(
    below: 0.8em,
    inset: (x: 1.2em, y: 0.9em),
    radius: 12pt,
    fill: accent-soft,
    stroke: (paint: accent-line, thickness: 1pt),
  )[
    #text(size: 15pt, weight: "semibold", fill: accent)[#title]
    #linebreak()
    #text(size: 13pt, fill: ink)[#subtitle]
    #if date != none [
      #v(0.35em)
      #text(size: 10pt, fill: warm)[#date]
    ]
  ]
]

#let statement(body) = block(
  below: 0.35em,
  width: 100%,
  inset: (x: 0.95em, y: 0.75em),
  fill: accent-soft,
  stroke: (
    left: (paint: accent, thickness: 2.2pt),
  ),
)[
  #box(
    inset: (x: 0.5em, y: 0.2em),
    radius: 99pt,
    fill: accent,
  )[
    #text(size: 8.5pt, weight: "bold", tracking: 0.08em, fill: white)[TASK]
  ]
  #v(0.25em)
  #body
]

#let solution(body) = block(
  width: 100%,
  inset: (x: 0.95em, y: 0.75em),
  fill: warm-soft,
  stroke: (
    left: (paint: warm, thickness: 2.2pt),
  ),
)[
  #box(
    inset: (x: 0.5em, y: 0.2em),
    radius: 99pt,
    fill: warm,
  )[
    #text(size: 8.5pt, weight: "bold", tracking: 0.08em, fill: white)[SOLUTION]
  ]
  #v(0.25em)
  #body
]
