#import "@preview/cetz:0.4.2"
#import "contour-common.typ": *

#set page(width: auto, height: auto, margin: 8pt)

#align(center)[
  #cetz.canvas(length: 1.05cm, {
    import cetz.draw: *

    let bounds = (xmin: -3.4, xmax: 3.7, ymin: -2.35, ymax: 2.35)
    let cut-left = -2.7
    let cut-right = 2.8
    let cut-half-height = 0.09
    let upper-band-left = (-2.9, 0.28)
    let upper-band-right = (3.0, 1.18)
    let lower-band-left = (-2.9, -1.65)
    let lower-band-right = (3.0, -0.28)
    let contour-radius = 0.22

    axes(bounds)

    rect(
      (cut-left, -cut-half-height),
      (cut-right, cut-half-height),
      fill: fills.cut,
      stroke: none,
    )
    line((cut-left, 0), (cut-right, 0), stroke: strokes.cut)

    rect(upper-band-left, upper-band-right, radius: contour-radius, stroke: strokes.contour, fill: fills.contour)
    rect(lower-band-left, lower-band-right, radius: contour-radius, stroke: strokes.contour, fill: fills.contour)

    content((-2.15, 1.42), [$cal(C)_+$])
    content((-2.15, -1.92), [$cal(C)_-$])
    callout((-1.35, 0.13), (-2.32, 0.9), [branch cut])
    callout((1.82, 0.09), (3.16, 0.82), [$G^"R"(omega + upright(i) 0^+)$])
    callout((1.5, -0.18), (3.0, -1.1), [$G^"A"(omega - upright(i) 0^+)$])
    direction-mark((2.18, 1.24), [$arrow.r$])
    direction-mark((2.18, -1.7), [$arrow.l$])
  })
]
