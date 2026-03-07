#import "@preview/physica:0.9.5": dd, grad, hbar, ket, laplacian, vb
#import "@preview/simple-plot:0.3.0": line-plot, plot

#let paper = rgb("#f8f6f1")
#let ink = rgb("#181615")
#let soft = rgb("#867d73")
#let rule = rgb("#cfc5b8")
#let accent = rgb("#c8422b")
#let accent-soft = rgb("#eadfd0")
#let plot-gray = rgb("#666b72")

// https://forum.typst.app/t/how-to-transform-all-math-cases-with-its-children-to-be-in-math-display-mode/3615/4
#let dcases(..args) = math.cases(..args.pos().map(math.display), ..args.named())

#set page(
  paper: "a4",
  margin: (left: 2.25cm, right: 1.75cm, top: 1.45cm, bottom: 1.7cm),
  fill: paper,
  numbering: "1",
)

#set text(
  font: ("Hiragino Mincho ProN", "Baskerville", "Libertinus Serif"),
  size: 10.7pt,
  fill: ink,
)

#set par(
  justify: true,
  leading: 0.75em,
)

#show emph: it => text(fill: accent, style: "italic")[#it.body]
#show strong: it => text(weight: "medium")[#it.body]

#let vertical-label(body, fill: ink) = rotate(-90deg, reflow: true)[
  #text(
    font: "Hiragino Sans",
    size: 8.3pt,
    weight: "medium",
    tracking: 0.2em,
    fill: fill,
  )[#body]
]

#let sun(size: 0.28cm, fill: accent) = circle(radius: size / 2, fill: fill)

#let sheet-header(title, subtitle, date: none) = [
  #grid(
    columns: (1fr, auto),
    gutter: 1em,
    align: top,
  )[
    #block[
      #text(
        font: "Hiragino Sans",
        size: 7.8pt,
        tracking: 0.22em,
        fill: soft,
      )[#title]
      #v(0.18em)
      #text(
        font: "Hiragino Mincho ProN",
        size: 25pt,
        weight: "regular",
        fill: ink,
      )[#subtitle]
    ]
  ][
    #align(right)[
      #sun()
      #if date != none [
        #v(0.55em)
        #text(
          font: "Hiragino Sans",
          size: 7.6pt,
          tracking: 0.16em,
          fill: accent,
        )[#date]
      ]
    ]
  ]
  #v(0.55em)
  #line(length: 100%, stroke: (paint: rule, thickness: 0.75pt))
]

#let major-section(number, title) = [
  #v(1.25em)
  #grid(
    columns: (0.9cm, 1fr, auto),
    gutter: 0.65em,
    align: bottom,
  )[
    #vertical-label([SECTION], fill: soft)
  ][
    #block[
      #text(
        font: "Hiragino Sans",
        size: 26pt,
        weight: "bold",
        tracking: -0.04em,
        fill: accent,
      )[#number]
      #v(-0.05em)
      #text(
        font: "Hiragino Mincho ProN",
        size: 19pt,
        weight: "regular",
        tracking: -0.01em,
        fill: ink,
      )[#title]
    ]
  ][
    #align(right)[
      #sun(size: 0.18cm, fill: accent-soft)
    ]
  ]
  #v(0.25em)
  #line(length: 100%, stroke: (paint: rule, thickness: 0.75pt))
  #v(0.6em)
]

#show heading.where(level: 1): it => major-section([00], [#it.body])

#show heading.where(level: 2): it => [
  #v(1.0em)
  #grid(
    columns: (0.9cm, auto, 1fr),
    gutter: 0.55em,
    align: bottom,
  )[
    #vertical-label([PART], fill: soft)
  ][
      #text(
        font: "Hiragino Sans",
        size: 14.5pt,
        weight: "medium",
        fill: ink,
      )[#it.body]
  ][
    #line(length: 100%, stroke: (paint: rule, thickness: 0.7pt))
  ]
  #v(0.26em)
]

#let statement(body) = block(width: 100%)[
  #grid(
    columns: (0.9cm, 1fr),
    gutter: 0.7em,
    align: top,
  )[
    #align(center)[
      #vertical-label([PROBLEM], fill: accent)
      #v(0.5em)
      #sun(size: 0.17cm)
    ]
  ][
    #block[
      #line(length: 100%, stroke: (paint: accent, thickness: 0.85pt))
      #v(0.42em)
      #set text(
        font: ("Hiragino Sans", "Helvetica Neue", "Arial"),
        size: 9.9pt,
        fill: ink,
      )
      #body
      #v(0.24em)
      #line(length: 100%, stroke: (paint: accent-soft, thickness: 0.75pt))
    ]
  ]
]

#let solution(body) = block(width: 100%)[
  #grid(
    columns: (0.9cm, 1fr),
    gutter: 0.7em,
    align: top,
  )[
    #align(center)[
      #vertical-label([SOLUTION], fill: soft)
    ]
  ][
    #block[
      #line(length: 100%, stroke: (paint: rule, thickness: 0.75pt))
      #v(0.45em)
      #body
    ]
  ]
]
