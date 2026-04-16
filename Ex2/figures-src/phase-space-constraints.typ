#import "@preview/cetz:0.5.0"

#let phase-space-constraints-figure(
  fermi: 2.5,
  excitation: 1.2,
  left-margin: 0.35,
  right-margin: 0.6,
  bottom-margin: 0.7,
  top-margin: 0.25,
  scale: 1.5cm,
) = {
  let x-left = fermi - excitation
  let excited = fermi + excitation

  let xmin = x-left - left-margin
  let xmax = fermi + right-margin
  let ymin = fermi - bottom-margin
  let ymax = excited + top-margin

  let diagonal-start = (xmin, xmin + excitation)
  let diagonal-end = (ymax - excitation, ymax)

  let tick-size = 0.05
  let axis-stroke = 1.0pt + black
  let tick-stroke = 0.8pt + black
  let overlap-stroke = (paint: rgb("#b22222"), thickness: 1.2pt)

  let condition-fills = (
    left: rgb("#4c78a822"),
    upper: rgb("#59a14f22"),
    lower: rgb("#f28e2b22"),
    overlap: rgb("#e1575933"),
  )
  let condition-strokes = (
    left: (paint: rgb("#4c78a8"), thickness: 1.1pt, dash: "dashed"),
    upper: (paint: rgb("#59a14f"), thickness: 1.1pt, dash: "dashed"),
    lower: (paint: rgb("#f28e2b"), thickness: 1.1pt, dash: "dashed"),
  )

  let x-tick(x, body) = {
    cetz.draw.line((x, ymin - tick-size), (x, ymin + tick-size), stroke: tick-stroke)
    cetz.draw.content((x, ymin - 0.18), anchor: "north", body)
  }
  let y-tick(y, body) = {
    cetz.draw.line((xmin - tick-size, y), (xmin + tick-size, y), stroke: tick-stroke)
    cetz.draw.content((xmin - 0.18, y), anchor: "east", body)
  }

  figure(
    cetz.canvas(length: scale, {
      import cetz.draw: *

      rect((xmin, ymin), (fermi, ymax), fill: condition-fills.left, stroke: none)
      rect((xmin, fermi), (xmax, ymax), fill: condition-fills.upper, stroke: none)
      line(
        (xmin, ymin),
        (xmax, ymin),
        (xmax, ymax),
        diagonal-end,
        diagonal-start,
        close: true,
        fill: condition-fills.lower,
        stroke: none,
      )

      line((xmin, ymin), (xmax, ymin), stroke: axis-stroke)
      line((xmin, ymin), (xmin, ymax), stroke: axis-stroke)

      line((fermi, ymin), (fermi, ymax), stroke: condition-strokes.left)
      line((xmin, fermi), (xmax, fermi), stroke: condition-strokes.upper)
      line(diagonal-start, diagonal-end, stroke: condition-strokes.lower)

      x-tick(fermi, [$epsilon_"F"$])
      x-tick(x-left, [$2 epsilon_"F" - epsilon_1$])
      y-tick(fermi, [$epsilon_"F"$])
      y-tick(excited, [$epsilon_1$])

      content((xmax + 0.08, ymin - 0.02), [$epsilon_2$])
      content((xmin - 0.06, ymax + 0.1), [$epsilon_3$])
    }),
  )
}
