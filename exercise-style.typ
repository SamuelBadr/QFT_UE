#import "@preview/physica:0.9.5": dd, dv, grad, hbar, laplacian, vb
#let ink = rgb("#181615")
#let soft = rgb("#867d73")
#let rule = rgb("#cfc5b8")
#let accent = rgb("#c8422b")
#let accent-soft = rgb("#eadfd0")
#let plot-gray = rgb("#666b72")

#let ii = $ upright(i) $
#let ee = $ upright(e) $

#let ordinal-suffix(number) = {
  let mod100 = calc.rem(number, 100)
  let mod10 = calc.rem(number, 10)
  if mod100 == 11 or mod100 == 12 or mod100 == 13 {
    "th"
  } else if mod10 == 1 {
    "st"
  } else if mod10 == 2 {
    "nd"
  } else if mod10 == 3 {
    "rd"
  } else {
    "th"
  }
}

#let sheet-title-text(number, suffix: "Exercise Sheet Solutions") = {
  str(number) + ordinal-suffix(number) + " " + suffix
}

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

#let sheet-banner(course, title, semester: none) = [
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
      )[#course]
      #v(0.18em)
      #text(
        font: "Hiragino Mincho ProN",
        size: 25pt,
        weight: "regular",
        fill: ink,
      )[#title]
    ]
  ][
    #align(right)[
      #sun()
      #if semester != none [
        #v(0.55em)
        #text(
          font: "Hiragino Sans",
          size: 7.6pt,
          tracking: 0.16em,
          fill: accent,
        )[#semester]
      ]
    ]
  ]
  #v(0.55em)
  #line(length: 100%, stroke: (paint: rule, thickness: 0.75pt))
]

#let tutorial-note(body) = align(right)[
  #text(
    font: "Hiragino Sans",
    size: 7.8pt,
    weight: "medium",
    tracking: 0.16em,
    fill: accent,
  )[#body]
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
  #v(0.85em)
]

#let render-major-heading(it) = block(sticky: true, width: 100%)[
  #counter(heading).step(level: 1)
  #major-section(context counter(heading).display("01"), [#it.body])
]

#let render-part-heading(it) = block(sticky: true, width: 100%)[
  #counter(heading).step(level: 2)
  #v(0.35em)
  #text(
    font: "Hiragino Sans",
    size: 11pt,
    weight: "medium",
    fill: ink,
  )[
    #context numbering("a)", counter(heading).get().last())
    #if it.body != [] [
      #h(0.5em)
      #it.body
    ]
  ]
  #v(0.1em)
]

#let render-problem-heading(it) = block(sticky: true, width: 100%)[
  #vertical-label([PROBLEM], fill: accent)
  #sun(size: 0.17cm)
]

#let render-solution-heading(it) = block(sticky: true, width: 100%)[
  #vertical-label([SOLUTION], fill: soft)
]

#let exercise-sheet(
  course,
  number,
  author: none,
  semester: none,
  tutorial: none,
  title-suffix: "Exercise Sheet Solutions",
  pdf-description: auto,
  pdf-keywords: auto,
  body,
) = {
  show heading.where(level: 1): render-major-heading
  show heading.where(level: 2): render-part-heading
  show heading.where(level: 3): render-problem-heading
  show heading.where(level: 4): render-solution-heading
  show title: it => []

  let full-title = str(course) + " - " + sheet-title-text(number, suffix: title-suffix)
  let visible-title = [#number#super[#ordinal-suffix(number)] #title-suffix]

  set document(
    title: full-title,
    author: if author != none { (author,) } else { () },
    description: if pdf-description == auto {
      let details = ()
      if semester != none {
        details.push(semester)
      }
      if tutorial != none {
        details.push(tutorial)
      }
      if details.len() == 0 {
        full-title
      } else {
        full-title + " - " + details.join(" - ")
      }
    } else {
      pdf-description
    },
    keywords: if pdf-keywords == auto {
      let keys = (
        str(course),
        "Exercise Sheet " + str(number),
        title-suffix,
      )
      if semester != none {
        keys.push(semester)
      }
      if tutorial != none {
        keys.push(tutorial)
      }
      keys
    } else {
      pdf-keywords
    },
  )

  [
    #title([#full-title])
    #sheet-banner(course, visible-title, semester: semester)
    #if tutorial != none [
      #tutorial-note([#tutorial])
    ]
    #body
  ]
}

#let problem(body) = block(width: 100%)[
  #grid(
    columns: (0.9cm, 1fr),
    gutter: 0.7em,
    align: top,
  )[
    #align(center)[
      #heading(level: 3, numbering: none, outlined: false, bookmarked: false)[Problem]
    ]
  ][
    #block[
      #line(length: 100%, stroke: (paint: accent, thickness: 0.85pt))
      #v(0.42em)
      #set text(
        font: ("Hiragino Mincho ProN", "Baskerville", "Libertinus Serif"),
        size: 10pt,
        fill: ink,
      )
      #body
      #v(0.24em)
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
      #heading(level: 4, numbering: none, outlined: false, bookmarked: false)[Solution]
    ]
  ][
    #block[
      #line(length: 100%, stroke: (paint: rule, thickness: 0.75pt))
      #v(0.45em)
      #body
    ]
  ]
]

#let two_panel(left, right, gutter: 0em) = grid(
  columns: (auto, auto),
  gutter: gutter,
)[
  #left
][
  #right
]
