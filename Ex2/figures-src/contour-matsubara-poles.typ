#import "@preview/cetz:0.4.2"
#import "contour-common.typ": *

#set page(width: auto, height: auto, margin: 8pt)

#align(center)[
  #cetz.canvas(length: 1.05cm, {
    import cetz.draw: *

    let bounds = (xmin: -3.3, xmax: 3.5, ymin: -3.2, ymax: 3.2)
    let matsubara-y = (-2.4, -1.6, -0.8, 0.8, 1.6, 2.4)
    let contour-left = -0.55
    let contour-right = 0.55
    let contour-bottom = -2.8
    let contour-top = 2.8
    let contour-radius = 0.26
    let pole-at = (1.82, 0)
    let pole-label-start = (1.9, 0.08)
    let pole-label-at = (2.42, 0.34)
    let matsubara-label-start = (0.08, 2.32)
    let matsubara-label-at = (1.02, 2.6)

    axes(bounds)
    imag-axis(bounds)
    for y in matsubara-y {
      circle((0, y), radius: 0.085, fill: fills.white, stroke: (paint: palette.matsubara, thickness: 0.9pt))
    }

    circle(pole-at, radius: 0.09, fill: palette.pole, stroke: none)
    callout(pole-label-start, pole-label-at, [$z = epsilon_k$])
    callout(matsubara-label-start, matsubara-label-at, [$z_n = upright(i) omega_n$])

    rect(
      (contour-left, contour-bottom),
      (contour-right, contour-top),
      radius: contour-radius,
      stroke: strokes.contour,
      fill: none,
    )

    content((0.0, contour-top + 0.18), anchor: "south", [$cal(C)_"M"$])
    direction-mark((0.72, 2.05), [$arrow.t$])

    content((-0.6, 2.42), anchor: "east", [$upright(i) omega_1$])
    content((-0.6, 1.62), anchor: "east", [$upright(i) omega_0$])
    content((-0.6, -0.78), anchor: "east", [$upright(i) omega_(-1)$])
  })
]
