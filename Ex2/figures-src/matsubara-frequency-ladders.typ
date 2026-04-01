#import "@preview/cetz:0.4.2"
#import "contour-common.typ": *

#set page(width: auto, height: auto, margin: 8pt)

#align(center)[
  #cetz.canvas(length: 1.0cm, {
    import cetz.draw: *

    let bounds = (xmin: -3.0, xmax: 3.3, ymin: -3.2, ymax: 3.2)
    let fermion-x = -0.9
    let boson-x = 0.9
    let fermion-y = (-2.5, -1.5, -0.5, 0.5, 1.5, 2.5)
    let boson-y = (-2, -1, 0, 1, 2)

    axes(bounds)

    line((fermion-x, bounds.ymin + 0.1), (fermion-x, bounds.ymax - 0.1), stroke: strokes.imag)
    line((boson-x, bounds.ymin + 0.1), (boson-x, bounds.ymax - 0.1), stroke: strokes.imag)

    for y in fermion-y {
      circle((fermion-x, y), radius: 0.08, fill: fills.white, stroke: (paint: palette.matsubara, thickness: 0.85pt))
    }
    for y in boson-y {
      circle((boson-x, y), radius: 0.08, fill: rgb("#f39c12"), stroke: none)
    }

    content((fermion-x, bounds.ymax + 0.06), anchor: "south", [$upright(i) omega_n$])
    content((boson-x, bounds.ymax + 0.06), anchor: "south", [$upright(i) Omega_m$])

    content((-2.82, 2.52), anchor: "west", [$omega_n = 2 pi / beta (n + 1 / 2)$])
    content((-2.82, 2.02), anchor: "west", [$Omega_m = 2 pi / beta m$])

    callout((fermion-x + 0.08, 1.5), (1.62, 1.8), [fermionic: odd multiples of $pi / beta$])
    callout((boson-x + 0.08, 1.0), (1.62, 1.26), [bosonic: even multiples of $pi / beta$])
  })
]
