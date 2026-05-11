#import "@preview/cetz:0.5.2": canvas, draw
#import draw: circle, content, group, line

// ============================================================
// Global style
// ============================================================

#let diagram_unit = 0.82cm

#let fstyle = (
  ink: rgb("#262932"),
  stroke: 1.05pt,
  arrow_size: 0.16,
  arrow_scale: 0.72,
  boson_amp: 0.07,
  boson_waves_per_cm: 2.2,
  loop_rx: 0.42,
  loop_ry: 0.38,
  tadpole_height: 1.18,
  bubble_height: 0.38,
  arch_height: 0.72,
  dot_radius: 0.020,
)

#let as-int(v) = int(calc.round(v))

// ============================================================
// Vector algebra
// ============================================================

#let vx(p) = p.at(0)
#let vy(p) = p.at(1)

#let vadd(a, b) = (vx(a) + vx(b), vy(a) + vy(b))
#let vsub(a, b) = (vx(a) - vx(b), vy(a) - vy(b))
#let vmul(s, a) = (s * vx(a), s * vy(a))
#let vmid(a, b) = vmul(0.5, vadd(a, b))

#let vnorm(v) = calc.sqrt(vx(v) * vx(v) + vy(v) * vy(v))

#let vunit(v) = {
  let n = vnorm(v)
  if n == 0 {
    (0, 0)
  } else {
    (vx(v) / n, vy(v) / n)
  }
}

#let vperp(v) = (-vy(v), vx(v))
#let vdist(a, b) = vnorm(vsub(b, a))

// ============================================================
// Bézier geometry
// ============================================================

#let qbez(p0, p1, p2, t) = {
  let u = 1 - t
  (
    u * u * vx(p0) + 2 * u * t * vx(p1) + t * t * vx(p2),
    u * u * vy(p0) + 2 * u * t * vy(p1) + t * t * vy(p2),
  )
}

#let qbez-tangent(p0, p1, p2, t) = {
  vadd(
    vmul(2 * (1 - t), vsub(p1, p0)),
    vmul(2 * t, vsub(p2, p1)),
  )
}

#let arc-control(a, b, height) = {
  vadd(vmid(a, b), vmul(height, vunit(vperp(vsub(b, a)))))
}

#let arc-point(a, b, height, t) = {
  qbez(a, arc-control(a, b, height), b, t)
}

#let arc-tangent(a, b, height, t) = {
  qbez-tangent(a, arc-control(a, b, height), b, t)
}

// ============================================================
// Anchor geometry
// ============================================================

#let loop-anchor(center, rx, ry, angle) = (
  vx(center) + rx * calc.cos(angle),
  vy(center) + ry * calc.sin(angle),
)

#let loop-bottom(center, rx, ry) = loop-anchor(center, rx, ry, -90deg)
#let loop-left(center, rx, ry) = loop-anchor(center, rx, ry, 180deg)
#let loop-right(center, rx, ry) = loop-anchor(center, rx, ry, 0deg)
#let loop-upper-left(center, rx, ry) = loop-anchor(center, rx, ry, 135deg)
#let loop-upper-right(center, rx, ry) = loop-anchor(center, rx, ry, 45deg)

#let loop-tangent(rx, ry, angle, clockwise: true) = {
  if clockwise {
    (rx * calc.sin(angle), -ry * calc.cos(angle))
  } else {
    (-rx * calc.sin(angle), ry * calc.cos(angle))
  }
}

// ============================================================
// Primitive drawing functions
// ============================================================

#let arrow-at(p, direction, style: fstyle) = {
  let u = vunit(direction)

  line(
    vsub(p, vmul(style.arrow_size, u)),
    vadd(p, vmul(style.arrow_size, u)),
    stroke: none,
    mark: (
      end: "stealth",
      fill: style.ink,
      scale: style.arrow_scale,
    ),
  )
}

#let dot(p, r: fstyle.dot_radius, style: fstyle) = {
  circle(p, radius: r, fill: style.ink, stroke: none)
}

#let label(p, body) = {
  content(p, body)
}

#let fermion(a, b, arrow: true, pos: 0.55, style: fstyle) = {
  line(a, b, stroke: (paint: style.ink, thickness: style.stroke))

  if arrow {
    arrow-at(
      vadd(a, vmul(pos, vsub(b, a))),
      vsub(b, a),
      style: style,
    )
  }
}

#let boson(
  a,
  b,
  amp: fstyle.boson_amp,
  waves: auto,
  phase: 0,
  style: fstyle,
) = {
  let d = vsub(b, a)
  let n = vunit(vperp(d))
  let length = vdist(a, b)

  let wave_count = if waves == auto {
    calc.max(1, as-int(length * style.boson_waves_per_cm))
  } else {
    waves
  }

  let steps = as-int(calc.max(16, wave_count * 20))
  let pts = ()

  for i in range(steps + 1) {
    let t = i / steps
    let s = calc.sin(2 * calc.pi * wave_count * t + phase)
    pts.push(vadd(vadd(a, vmul(t, d)), vmul(amp * s, n)))
  }

  line(..pts, stroke: (paint: style.ink, thickness: style.stroke))
}

#let arc(
  a,
  b,
  height: fstyle.arch_height,
  arrow: false,
  pos: 0.55,
  style: fstyle,
) = {
  let ctrl = arc-control(a, b, height)

  let pts = ()
  let steps = 72

  for i in range(steps + 1) {
    let t = i / steps
    pts.push(qbez(a, ctrl, b, t))
  }

  line(..pts, stroke: (paint: style.ink, thickness: style.stroke))

  if arrow {
    arrow-at(
      qbez(a, ctrl, b, pos),
      qbez-tangent(a, ctrl, b, pos),
      style: style,
    )
  }
}

#let wavy-arc(
  a,
  b,
  height: fstyle.arch_height,
  amp: fstyle.boson_amp,
  waves: auto,
  style: fstyle,
) = {
  let ctrl = arc-control(a, b, height)
  let length = vdist(a, b)

  let wave_count = if waves == auto {
    calc.max(2, as-int(length * style.boson_waves_per_cm))
  } else {
    waves
  }

  let steps = as-int(calc.max(24, wave_count * 22))
  let pts = ()

  for i in range(steps + 1) {
    let t = i / steps

    let p = qbez(a, ctrl, b, t)
    let tangent = qbez-tangent(a, ctrl, b, t)
    let n = vunit(vperp(tangent))
    let s = calc.sin(2 * calc.pi * wave_count * t)

    pts.push(vadd(p, vmul(amp * s, n)))
  }

  line(..pts, stroke: (paint: style.ink, thickness: style.stroke))
}

#let fermion-loop(
  center,
  rx: fstyle.loop_rx,
  ry: fstyle.loop_ry,
  arrow_angle: -78deg,
  clockwise: true,
  style: fstyle,
) = {
  circle(
    center,
    radius: (rx, ry),
    stroke: (paint: style.ink, thickness: style.stroke),
  )

  let p = loop-anchor(center, rx, ry, arrow_angle)
  let tangent = loop-tangent(rx, ry, arrow_angle, clockwise: clockwise)

  arrow-at(p, tangent, style: style)
}

// ============================================================
// Topological motifs
// ============================================================

#let baseline-vertices(n, length: 4.0, y: 0) = {
  let out = ()
  let x0 = -length / 2

  for i in range(n) {
    let xx = x0 + i * length / (n - 1)
    out.push((xx, y))
  }

  out
}

#let fermion-chain(points, arrows: auto, style: fstyle) = {
  for i in range(points.len() - 1) {
    fermion(points.at(i), points.at(i + 1), arrow: false, style: style)
  }

  let n_arrows = if arrows == auto {
    points.len() - 1
  } else {
    arrows
  }

  let start = points.first()
  let stop = points.last()

  for i in range(n_arrows) {
    let t = (i + 0.55) / n_arrows
    arrow-at(
      vadd(start, vmul(t, vsub(stop, start))),
      vsub(stop, start),
      style: style,
    )
  }
}

#let fermion-bubble(
  left,
  right,
  height: fstyle.bubble_height,
  top_arrow: 0.55,
  bottom_arrow: 0.55,
  style: fstyle,
) = {
  arc(left, right, height: height, arrow: true, pos: top_arrow, style: style)
  arc(right, left, height: height, arrow: true, pos: bottom_arrow, style: style)
}

#let boson-bridge(
  left,
  right,
  height: 0.45,
  waves: auto,
  style: fstyle,
) = {
  wavy-arc(left, right, height: height, waves: waves, style: style)
}

#let tadpole(
  root,
  height: fstyle.tadpole_height,
  rx: fstyle.loop_rx,
  ry: fstyle.loop_ry,
  inside_boson: false,
  crown_boson: false,
  style: fstyle,
) = {
  let center = vadd(root, (0, height))

  let bottom = loop-bottom(center, rx, ry)
  let left = loop-left(center, rx, ry)
  let right = loop-right(center, rx, ry)
  let upper_left = loop-upper-left(center, rx, ry)
  let upper_right = loop-upper-right(center, rx, ry)

  boson(root, bottom, style: style)
  fermion-loop(center, rx: rx, ry: ry, style: style)

  if inside_boson {
    boson(left, right, waves: 2, style: style)
  }

  if crown_boson {
    wavy-arc(upper_left, upper_right, height: 0.7, waves: 4, style: style)
  }
}

#let supported-bubble(
  left_root,
  right_root,
  stem_height: 0.72,
  bubble_height: fstyle.bubble_height,
  style: fstyle,
) = {
  let left_top = vadd(left_root, (0, stem_height))
  let right_top = vadd(right_root, (0, stem_height))

  boson(left_root, left_top, style: style)
  boson(right_root, right_top, style: style)
  fermion-bubble(left_top, right_top, height: bubble_height, style: style)
}

#let double-arch(
  left_top,
  right_top,
  top_height: 0.80,
  lower_height: 0.22,
  top_arrow: 0.78,
  lower_arrow: 0.48,
  style: fstyle,
) = {
  arc(left_top, right_top, height: top_height, arrow: true, pos: top_arrow, style: style)
  arc(right_top, left_top, height: lower_height, arrow: true, pos: lower_arrow, style: style)
}

#let boson-chain-with-bubbles(
  baseline_left,
  baseline_right,
  bubble_centers,
  bubble_width: 0.78,
  bubble_height: 0.36,
  end_bridge_height: 0.42,
  mid_bridge_height: 0.08,
  end_waves: 3,
  mid_waves: 2,
  style: fstyle,
) = {
  let endpoints = ()

  for c in bubble_centers {
    endpoints.push((
      left: vadd(c, (-bubble_width / 2, 0)),
      right: vadd(c, (bubble_width / 2, 0)),
    ))
  }

  wavy-arc(
    baseline_left,
    endpoints.first().left,
    height: end_bridge_height,
    waves: end_waves,
    style: style,
  )

  for ep in endpoints {
    fermion-bubble(
      ep.left,
      ep.right,
      height: bubble_height,
      style: style,
    )
  }

  for i in range(endpoints.len() - 1) {
    wavy-arc(
      endpoints.at(i).right,
      endpoints.at(i + 1).left,
      height: mid_bridge_height,
      waves: mid_waves,
      style: style,
    )
  }

  wavy-arc(
    endpoints.last().right,
    baseline_right,
    height: end_bridge_height,
    waves: end_waves,
    style: style,
  )
}

// Fixed-size diagram panel.
// `unit` is the actual scale of one coordinate unit.
// This is the main knob that makes the whole figure fit.
#let diagram-panel(
  body,
  width: 4cm,
  height: 2.6cm,
  shift: (2, 0.35),
  unit: diagram_unit,
) = {
  box(
    width: width,
    height: height,
    clip: false,
    canvas(length: unit, {
      group(shift: shift, {
        body
      })
    }),
  )
}

// ============================================================
// Diagrams
// ============================================================

#let diagram-a = diagram-panel(
  {
    let ps = baseline-vertices(6, length: 4.1)
    fermion-chain(ps, arrows: 5)

    boson-bridge(ps.at(1), ps.at(4), height: 1.05, waves: 7)
    boson-bridge(ps.at(2), ps.at(3), height: 0.72, waves: 4)

    label((1.55, 1.30), [(a)])
  },
  width: 3.95cm,
  height: 2.25cm,
  shift: (2.25, 0.35),
)

#let diagram-b = diagram-panel(
  {
    let ps = baseline-vertices(6, length: 4.5)
    fermion-chain(ps, arrows: 4)

    tadpole(ps.at(1))

    supported-bubble(
      ps.at(3),
      ps.at(4),
      stem_height: 0.76,
      bubble_height: 0.42,
    )

    label((1.75, 1.32), [(b)])
  },
  width: 4.45cm,
  height: 2.40cm,
  shift: (2.55, 0.35),
)

#let diagram-c = diagram-panel(
  {
    let ps = baseline-vertices(3, length: 1.9)
    fermion-chain(ps, arrows: 2)

    tadpole(ps.at(1), inside_boson: true)

    label((1.1, 1.35), [(c)])
  },
  width: 2.40cm,
  height: 2.40cm,
  shift: (1.35, 0.35),
)

#let diagram-d = diagram-panel(
  {
    let ps = baseline-vertices(5, length: 2.8)
    fermion-chain(ps, arrows: 4)

    tadpole(ps.at(2))
    boson-bridge(ps.at(1), ps.at(3), height: -1, waves: 5)

    label((1.4, 1.36), [(d)])
  },
  width: 2.90cm,
  height: 2.40cm,
  shift: (1.65, 0.35),
)

#let diagram-e = diagram-panel(
  {
    let ps = baseline-vertices(5, length: 4)
    fermion-chain(ps, arrows: 3)

    boson-chain-with-bubbles(
      (-1.5, 0),
      (1.5, 0),
      (
        (-1.05, 0.78),
        (1.05, 0.78),
      ),
      bubble_width: 0.8,
      bubble_height: 0.36,
      end_bridge_height: 0.46,
      mid_bridge_height: 0.20,
      end_waves: 3,
      mid_waves: 2,
    )

    label((1.9, 1.22), [(e)])
  },
  width: 3.95cm,
  height: 2.25cm,
  shift: (2.25, 0.42),
)

#let diagram-f = diagram-panel(
  {
    let ps = baseline-vertices(3, length: 1.9)
    fermion-chain(ps, arrows: 2)

    tadpole(ps.at(1), crown_boson: true)

    label((1.1, 1.28), [(f)])
  },
  width: 2.40cm,
  height: 2.40cm,
  shift: (1.35, 0.35),
)

#let diagram-g = diagram-panel(
  {
    let ps = baseline-vertices(5, length: 4.4)
    fermion-chain(ps, arrows: 4)

    let left_top = vadd(ps.at(1), (0, 0.74))
    let right_top = vadd(ps.at(3), (0, 0.74))

    boson(ps.at(1), left_top)
    boson(ps.at(3), right_top)

    double-arch(
      left_top,
      right_top,
      top_height: 0.84,
      lower_height: 0.22,
      top_arrow: 0.78,
      lower_arrow: 0.50,
    )

    let lower_mid = arc-point(right_top, left_top, 0.22, 0.5)
    boson(ps.at(2), lower_mid, waves: 1)

    label((1.58, 1.34), [(g)])
  },
  width: 4.20cm,
  height: 2.35cm,
  shift: (2.40, 0.36),
)

#let diagram-h = diagram-panel(
  {
    let ps = baseline-vertices(6, length: 4.15)
    fermion-chain(ps, arrows: 5)

    boson-bridge(ps.at(1), ps.at(3), height: -1, waves: 6)
    boson-bridge((-1.5, 0), (0.8, 0), height: -2, waves: 11)

    tadpole(ps.at(2), height: 1.08, rx: 0.40, ry: 0.36)
    tadpole(ps.at(4), height: 1.08, rx: 0.40, ry: 0.36, inside_boson: true)

    label((2.5, 1.23), [(h)])
  },
  width: 4.15cm,
  height: 2.35cm,
  shift: (2.35, 0.36),
)

#let diagram-second-order = diagram-panel(
  {
    // Vertex layout:
    //
    //   incoming -- left -- right -- outgoing
    //                 |      |
    //                 |      |
    //              left_top right_top
    //
    // The upper fermion bubble and both interaction lines share exact vertices.

    let incoming = (-3.05, -0.48)
    let left = (-1.55, 0)
    let right = (1.55, 0)
    let outgoing = (3.05, -0.48)

    let stem_height = 1.85
    let left_top = vadd(left, (0, stem_height))
    let right_top = vadd(right, (0, stem_height))

    // External and internal fermion line.
    fermion(incoming, left, pos: 0.45)
    fermion(left, right, pos: 0.55)
    fermion(right, outgoing, pos: 0.55)

    // Interaction lines.
    boson(left, left_top, waves: 5)
    boson(right, right_top, waves: 5)

    // Fermion bubble.
    fermion-bubble(
      left_top,
      right_top,
      height: 1.15,
      top_arrow: 0.56,
      bottom_arrow: 0.50,
    )

    // Labels.
    label((-2.75, 0.72), $V(q)$)
    label((-2.45, -0.90), $bold(k), i omega_n$)
  },
  width: 6.3cm,
  height: 3.7cm,
  shift: (3.15, 1.00),
  unit: 1cm,
)
