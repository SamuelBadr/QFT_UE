#import "@preview/cetz:0.4.2"
#import "contour-common.typ": *

#set page(width: auto, height: auto, margin: 8pt)

#align(center)[
  #cetz.canvas(length: 1.05cm, {
    import cetz.draw: *

    let bounds = (xmin: -3.0, xmax: 3.1, ymin: -2.0, ymax: 2.0)
    let pole-at = (1.15, 0)
    let pole-radius = 0.42
    let pole-label-start = (1.24, 0.08)
    let pole-label-at = (2.02, 0.62)
    let contour-label-start = (1.48, 0.32)
    let contour-label-at = (2.22, 1.08)
    let asymptote-stroke = (paint: palette.guide, thickness: 0.9pt, dash: "dashed")

    axes(bounds)

    circle(pole-at, radius: 0.095, fill: palette.pole, stroke: none)
    callout(pole-label-start, pole-label-at, [$z = epsilon_k$])

    line((0.28, 0.42), (0.85, 0.18), stroke: asymptote-stroke)
    line((0.28, -0.42), (0.85, -0.18), stroke: asymptote-stroke)

    circle(pole-at, radius: pole-radius, stroke: strokes.contour, fill: fills.contour)
    direction-mark((1.52, 0.46), [$arrow.l$])

    callout(contour-label-start, contour-label-at, [$cal(C)_"pole"$])
  })
]
