#import "@preview/cetz:0.4.2"
#import "contour-common.typ": *

#set page(width: auto, height: auto, margin: 8pt)

#align(center)[
  #cetz.canvas(length: 0.95cm, {
    import cetz.draw: *

    let xmin = -4.8
    let xmax = 4.8
    let ymin = -0.6
    let ymax = 3.2
    let known-left = -2.2
    let known-right = 2.2
    let indices = (-4, -3, -2, -1, 1, 2, 3, 4)
    let heights = (0.72, 0.95, 1.35, 2.15, 2.15, 1.35, 0.95, 0.72)

    line((xmin, 0), (xmax, 0), stroke: strokes.axis)
    line((0, 0), (0, ymax), stroke: strokes.axis)
    content((xmax + 0.12, -0.06), [$n$])
    content((-0.05, ymax + 0.16), [$|G(upright(i) omega_n)|$])

    rect((xmin, 0), (known-left, ymax - 0.2), fill: rgb("#8a8f9810"), stroke: none)
    rect((known-right, 0), (xmax, ymax - 0.2), fill: rgb("#8a8f9810"), stroke: none)
    rect((known-left, 0), (known-right, ymax - 0.2), fill: rgb("#2f7ebc10"), stroke: none)

    for (index, height) in indices.zip(heights) {
      let x = index
      line((x, 0), (x, height), stroke: (paint: palette.matsubara, thickness: 1.0pt))
      circle((x, height), radius: 0.07, fill: palette.matsubara, stroke: none)
    }

    line((known-left, 0), (known-left, ymax - 0.2), stroke: (paint: palette.guide, thickness: 0.8pt, dash: "dashed"))
    line((known-right, 0), (known-right, ymax - 0.2), stroke: (paint: palette.guide, thickness: 0.8pt, dash: "dashed"))

    content((-2.45, 2.86), [known window: $-M <= n <= M$])
    content((known-left - 0.3, -0.26), [$-M$])
    content((known-right - 0.05, -0.26), [$M$])

    callout((known-right + 0.45, 1.05), (3.0, 1.72), [omitted tail])
    callout((1.0, 2.1), (2.55, 2.56), [subtract the large-$omega_n$ asymptote first])
  })
]
