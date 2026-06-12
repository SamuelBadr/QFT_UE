#import "@preview/simple-plot:0.3.0": plot
#import "../exercise-style.typ": *
// ------------------------------------------------------------
// Ferromagnetic susceptibility for hypercubic tight-binding band
// at half filling.
//
// Plots:
//
//   chi-tilde_F = (2t / hbar^2) chi_F
//
// as a function of theta = T/t.
//
// Numerical strategy:
//   d = 1: direct one-dimensional k integral
//   d = 2: exact DOS integral using elliptic K
//   d = 3: DOS convolution n_3(e) = integral dk n_2(e + 2 cos k)
//
// Low-temperature susceptibility integrals are evaluated in the
// scaled thermal variable x = e / (2 theta). This avoids
// undersampling the narrow sech^2 kernel near theta = 0.
// ------------------------------------------------------------
// ---------- numerical helpers ----------
#let sech2(x) = {
  let ax = calc.abs(x)
  if ax > 40.0 {
    0.0
  } else {
    let c = calc.cosh(x)
    1.0 / (c * c)
  }
}
#let kernel(e, theta) = {
  // e = epsilon / t
  // theta = T / t
  1.0 / (4.0 * theta) * sech2(e / (2.0 * theta))
}
#let midpoint-integral(f, a, b, n) = {
  let h = (b - a) / n
  let s = 0.0
  for i in range(n) {
    let x = a + (i + 0.5) * h
    s += f(x)
  }
  h * s
}
// ---------- complete elliptic integral K(m) ----------
#let elliptic-k(m, steps: 8) = {
  if m < 0.0 {
    panic("elliptic-k expects m >= 0")
  }
  if m >= 1.0 {
    calc.inf
  } else {
    let a = 1.0
    let b = calc.sqrt(1.0 - m)
    for _ in range(steps) {
      let an = (a + b) / 2.0
      let bn = calc.sqrt(a * b)
      a = an
      b = bn
    }
    calc.pi / (2.0 * a)
  }
}
// ---------- dimensionless DOS: n_d(e) = t rho_d(e) ----------
//
// Dispersion:
//
//   epsilon_k / t = -2 sum_i cos(k_i)
//
// Band support:
//
//   d = 1: e in [-2, 2]
//   d = 2: e in [-4, 4]
//   d = 3: e in [-6, 6]
#let dos1(e) = {
  if calc.abs(e) >= 2.0 {
    0.0
  } else {
    1.0 / (calc.pi * calc.sqrt(4.0 - e * e))
  }
}
#let dos2(e) = {
  if calc.abs(e) >= 4.0 {
    0.0
  } else {
    let m = 1.0 - e * e / 16.0
    if m >= 1.0 {
      calc.inf
    } else {
      1.0 / (2.0 * calc.pow(calc.pi, 2)) * elliptic-k(m)
    }
  }
}
// ---------- 3D DOS by convolution ----------
//
// n_3(e) = int_{-pi}^{pi} dk/(2pi) n_2(e + 2 cos k)
//
// Increase nk3 for higher precision.
// Decrease nk3 for faster compilation.
//
// The value nk3 = 384 is intentionally higher than the original
// value because the 2D DOS has a logarithmic van-Hove singularity.
// A coarse k-grid can imprint small numerical features into dos3(e).
#let nk3 = 192
#let dos3(e) = {
  if calc.abs(e) >= 6.0 {
    0.0
  } else {
    (
      midpoint-integral(
        k => dos2(e + 2.0 * calc.cos(k)),
        -calc.pi,
        calc.pi,
        nk3,
      )
        / (2.0 * calc.pi)
    )
  }
}
// ---------- susceptibilities ----------
//
// chi_d(theta) = integral de n_d(e) kernel(e, theta)
//
// d = 1 uses a direct k integral to avoid the 1D DOS band-edge
// singularity.
//
// d = 2 and d = 3 are evaluated with the scaled thermal variable
//
//   x = e / (2 theta)
//
// so that
//
//   chi(theta) = 1/2 int dx n(2 theta x) sech^2(x).
//
// This avoids the low-temperature artifact caused by trying to
// resolve a width-O(theta) kernel on a fixed, coarse energy grid.
#let ne1 = 600
#let nx2 = 500
#let nx3 = 320
#let chi1(theta) = {
  (
    midpoint-integral(
      k => kernel(-2.0 * calc.cos(k), theta),
      -calc.pi,
      calc.pi,
      ne1,
    )
      / (2.0 * calc.pi)
  )
}
#let chi2(theta) = {
  let xmax = calc.min(40.0, 4.0 / (2.0 * theta))
  (
    0.5
      * midpoint-integral(
        x => dos2(2.0 * theta * x) * sech2(x),
        -xmax,
        xmax,
        nx2,
      )
  )
}
#let chi3(theta) = {
  let xmax = calc.min(40.0, 6.0 / (2.0 * theta))
  (
    0.5
      * midpoint-integral(
        x => dos3(2.0 * theta * x) * sech2(x),
        -xmax,
        xmax,
        nx3,
      )
  )
}
// ---------- low-temperature references ----------
//
// In the plotted normalization:
//
//   chi-tilde_F(T -> 0) = n_d(0)
//
// d = 1:
//   n_1(0) = 1 / (2 pi)
//
// d = 2:
//   n_2(0) diverges logarithmically.
//
// d = 3:
//   n_3(0) is finite and computed numerically.
#let chi1-zero = 1.0 / (2.0 * calc.pi)
#let chi3-zero = dos3(0.0)
// ---------- plot ----------
//
// For CeTZ anchors, use:
//   "north", "south", "east", "west"
// not:
//   "top", "bottom", "left", "right"
// ---------- antiferromagnetic susceptibility ----------
//
// Plotted normalization:
//
//   chi-tilde_AF = (2t / hbar^2) chi_AF
//
// With e = epsilon / t and theta = T / t:
//
//   chi-tilde_AF
//     = 1/2 int de n_d(e) tanh(e / (2 theta)) / e
//
// Since the integrand is even at half filling:
//
//   chi-tilde_AF
//     = int_0^band de n_d(e) tanh(e / (2 theta)) / e
//
// Using x = e / (2 theta):
//
//   chi-tilde_AF
//     = int_0^{band / (2 theta)} dx
//         n_d(2 theta x) tanh(x) / x
//
// The logarithmic variable below makes the large-x tail efficient.
#let tanh-stable(x) = {
  if x > 40.0 {
    1.0
  } else if x < -40.0 {
    -1.0
  } else {
    let y = calc.exp(2.0 * x)
    (y - 1.0) / (y + 1.0)
  }
}
#let tanh-over-x(x) = {
  if calc.abs(x) < 1e-8 {
    1.0
  } else {
    tanh-stable(x) / x
  }
}
#let naf-linear = 300
#let naf-log = 500
#let chi-af-from-dos(dos, band, theta) = {
  let xmax = band / (2.0 * theta)
  if xmax <= 1.0 {
    midpoint-integral(
      x => dos(2.0 * theta * x) * tanh-over-x(x),
      0.0,
      xmax,
      naf-linear,
    )
  } else {
    let small-x = midpoint-integral(
      x => dos(2.0 * theta * x) * tanh-over-x(x),
      0.0,
      1.0,
      naf-linear,
    )
    let large-x = midpoint-integral(
      u => {
        let x = calc.exp(u)
        dos(2.0 * theta * x) * tanh-stable(x)
      },
      0.0,
      calc.ln(xmax),
      naf-log,
    )
    small-x + large-x
  }
}
#let chi-af1(theta) = {
  chi-af-from-dos(dos1, 2.0, theta)
}
#let chi-af2(theta) = {
  chi-af-from-dos(dos2, 4.0, theta)
}
#let chi-af3(theta) = {
  chi-af-from-dos(dos3, 6.0, theta)
}
// ---------- two-panel plot ----------
#let susceptibility-plot() = {
  align(center)[
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        #plot(
          width: 5.4,
          height: 4,
          xmin: 0.01,
          xmax: 4.0,
          ymin: 0.0,
          ymax: 0.3,
          xscale: "log",
          axis-y-extend: 0.05,
          show-grid: "none",
          xlabel: $T / t$,
          ylabel: $(2 t) / hbar^2 chi_"F"$,
          (
            fn: theta => chi1(theta),
            domain: (0.01, 4.0),
            stroke: green,
            label: $d = 1$,
            label-pos: 0.0,
            label-side: "west",
          ),
          (
            fn: theta => chi2(theta),
            domain: (0.01, 4.0),
            stroke: red,
            label: $d = 2$,
            label-pos: 0.02,
            label-side: "west",
          ),
          (
            fn: theta => chi3(theta),
            domain: (0.01, 4.0),
            stroke: blue,
            label: $d = 3$,
            label-pos: 0.8,
            label-side: "north",
          ),
        )
      ],
      [
        #plot(
          width: 5.4,
          height: 4,
          xmin: 0.01,
          xmax: 4.0,
          ymin: 0.0,
          ymax: 1.8,
          xscale: "log",
          axis-y-extend: 0.05,
          show-grid: "none",
          xlabel: $T / t$,
          ylabel: $(2 t) / hbar^2 chi_"AF"$,
          (
            fn: theta => chi-af1(theta),
            domain: (0.01, 4.0),
            stroke: green,
            label: $d = 1$,
            label-pos: 0.2,
            label-side: "north",
          ),
          (
            fn: theta => chi-af2(theta),
            domain: (0.01, 4.0),
            stroke: red,
            label: $d = 2$,
            label-pos: 0.15,
            label-side: "north",
          ),
          (
            fn: theta => chi-af3(theta),
            domain: (0.01, 4.0),
            stroke: blue,
            label: $d = 3$,
            label-pos: 0.4,
            label-side: "south",
          ),
        )
      ],
    )
  ]
}
