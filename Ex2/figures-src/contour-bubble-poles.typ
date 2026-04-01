#import "@preview/cetz:0.4.2"
#import "contour-common.typ": *

#set page(width: auto, height: auto, margin: 8pt)

#align(center)[
  #cetz.canvas(length: 1.05cm, {
    import cetz.draw: *

    let bounds = (xmin: -3.5, xmax: 3.7, ymin: -3.0, ymax: 3.0)
    let matsubara-y = (-2.2, -1.4, -0.6, 0.6, 1.4, 2.2)
    let contour-left = -0.58
    let contour-right = 0.58
    let contour-bottom = -2.6
    let contour-top = 2.6
    let base-pole = (1.35, 0)
    let ghost-pole = (2.15, 0)
    let shifted-pole = (2.15, -1.15)
    let shifted-pole-x = 2.15
    let shifted-pole-y = -1.15
    let shift-label-at = (2.52, -0.46)

    axes(bounds)
    imag-axis(bounds)
    for y in matsubara-y {
      circle((0, y), radius: 0.075, fill: fills.white, stroke: (paint: palette.matsubara, thickness: 0.85pt))
    }

    circle(base-pole, radius: 0.095, fill: palette.pole, stroke: none)
    circle(ghost-pole, radius: 0.075, fill: fills.white, stroke: (paint: palette.ghost, thickness: 0.8pt))
    circle(shifted-pole, radius: 0.095, fill: palette.at("shifted-pole"), stroke: none)

    line((shifted-pole-x, shifted-pole-y + 0.1), (shifted-pole-x, -0.1), stroke: (paint: palette.at("shifted-pole"), thickness: 0.9pt, dash: "dashed"))

    callout((1.42, 0.08), (2.02, 0.84), [$z = epsilon_k$])
    callout((2.25, -1.05), (3.08, -1.42), [$z = epsilon_(k+q) - upright(i) Omega_m$], boxed: true)
    content(shift-label-at, [$-upright(i) Omega_m$])

    rect(
      (contour-left, contour-bottom),
      (contour-right, contour-top),
      radius: 0.26,
      stroke: strokes.contour,
      fill: none,
    )
    content((0.0, contour-top + 0.18), anchor: "south", [$cal(C)_"M"$])
    direction-mark((0.75, 1.86), [$arrow.t$])
    callout((0.08, 2.18), (1.0, 2.58), [$z_n = upright(i) omega_n$])
    content((1.72, -2.2), [$Omega_m > 0$])
  })
]
