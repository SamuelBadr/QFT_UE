#import "@preview/cetz:0.4.2"

#let palette = (
  axis: rgb("#2f3437"),
  contour: rgb("#c8422b"),
  matsubara: rgb("#2f7ebc"),
  pole: rgb("#3a8f5d"),
  shifted-pole: rgb("#9b59b6"),
  ghost: rgb("#aeb6bf"),
  guide: rgb("#8a8f98"),
  cut: rgb("#5aa1e3"),
)

#let strokes = (
  axis: 1.0pt + palette.axis,
  contour: (paint: palette.contour, thickness: 1.2pt),
  contour-soft: (paint: palette.contour, thickness: 1.2pt),
  guide: (paint: palette.guide, thickness: 0.8pt),
  imag: (paint: palette.guide, thickness: 0.7pt),
  cut: (paint: palette.cut, thickness: 1.0pt),
)

#let fills = (
  contour: rgb("#c8422b10"),
  cut: rgb("#5aa1e322"),
  white: white,
)

#let axes(bounds) = {
  import cetz.draw: *

  line((bounds.xmin, 0), (bounds.xmax, 0), stroke: strokes.axis)
  line((0, bounds.ymin), (0, bounds.ymax), stroke: strokes.axis)
  content((bounds.xmax + 0.12, -0.06), [$Re z$])
  content((-0.05, bounds.ymax + 0.16), [$Im z$])
}

#let imag-axis(bounds) = {
  import cetz.draw: *
  line((0, bounds.ymin), (0, bounds.ymax), stroke: strokes.imag)
}

#let callout(from, to, body, label-anchor: "west", boxed: false) = {
  import cetz.draw: *

  line(from, to, stroke: strokes.guide)
  if boxed {
    content(to, anchor: label-anchor, [#box(fill: fills.white, inset: 2pt)[#body]])
  } else {
    content(to, anchor: label-anchor, [#body])
  }
}

#let direction-mark(at, body) = {
  import cetz.draw: *
  content(at, body)
}
