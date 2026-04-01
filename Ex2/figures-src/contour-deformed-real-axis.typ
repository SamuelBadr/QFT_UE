#import "@preview/cetz:0.4.2"
#import "contour-common.typ": *

#set page(width: auto, height: auto, margin: 8pt)

#align(center)[
  #cetz.canvas(length: 1.05cm, {
    import cetz.draw: *

    let bounds = (xmin: -3.4, xmax: 3.4, ymin: -2.2, ymax: 2.2)
    let pole-at = (1.65, 0)
    let pole-label-start = (1.72, -0.06)
    let pole-label-at = (2.38, -0.68)
    let upper-band-left = (-2.75, 0.28)
    let upper-band-right = (2.95, 1.18)
    let lower-band-left = (-2.75, -1.72)
    let lower-band-right = (2.95, -0.28)
    let contour-radius = 0.22

    axes(bounds)

    circle(pole-at, radius: 0.1, fill: palette.pole, stroke: none)
    callout(pole-label-start, pole-label-at, [$z = epsilon_k$])

    rect(upper-band-left, upper-band-right, radius: contour-radius, stroke: strokes.contour, fill: fills.contour)
    rect(lower-band-left, lower-band-right, radius: contour-radius, stroke: strokes.contour, fill: fills.contour)

    content((-2.15, 1.42), [$cal(C)_+$])
    content((-2.15, -1.98), [$cal(C)_-$])
    content((1.92, 1.72), [analytic for $Im z > 0$])
    content((1.72, -2.12), [analytic for $Im z < 0$])
    direction-mark((2.0, 1.24), [$arrow.r$])
    direction-mark((2.0, -1.76), [$arrow.l$])
  })
]
