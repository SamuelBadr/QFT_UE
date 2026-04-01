#import "@preview/cetz:0.4.2"
#import "contour-common.typ": *

#set page(width: auto, height: auto, margin: 8pt)

#align(center)[
  #cetz.canvas(length: 1.0cm, {
    import cetz.draw: *

    let bounds = (xmin: -1.8, xmax: 4.3, ymin: -0.4, ymax: 3.6)
    let origin = (0, 0)
    let static-start = (3.2, 0)
    let dynamic-start = (0, 3.0)
    let static-stroke = (paint: palette.pole, thickness: 1.3pt)
    let dynamic-stroke = (paint: palette.shifted-pole, thickness: 1.3pt)

    line((bounds.xmin, 0), (bounds.xmax, 0), stroke: strokes.axis)
    line((0, bounds.ymin), (0, bounds.ymax), stroke: strokes.axis)
    content((bounds.xmax + 0.12, -0.06), [$|q|$])
    content((-0.05, bounds.ymax + 0.16), [$|Omega_m|$])

    line(static-start, origin, stroke: static-stroke)
    line(dynamic-start, origin, stroke: dynamic-stroke)

    content((1.7, 0.2), [$arrow.l$])
    content((0.18, 1.65), [$arrow.b$])

    circle(origin, radius: 0.08, fill: palette.axis, stroke: none)

    content((2.35, 0.52), [#text(weight: "bold")[static]: $Omega_m = 0$, then $|q| -> 0$])
    content((-1.7, 2.5), [#text(weight: "bold")[dynamic]: $|q| = 0$, then $Omega_m -> 0$])
    callout((0.06, 0.08), (2.54, 3.06), [same endpoint, different path])
  })
]
