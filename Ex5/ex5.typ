#import "../exercise-style.typ": *
#import "@preview/unify:0.7.1": num, numrange, qty, qtyrange
#import "@preview/simple-plot:0.3.0": plot

#show: exercise-sheet.with(
  "QFT for Many-Body Systems",
  5,
  author: "Samuel Badr",
  semester: "Sommersemester 2026",
  tutorial: "TUTORIUM: Friday, 12.06.2026.",
  title-suffix: "Exercise Sheet",
)

#let start = 10
#counter(heading).update(start - 1)

#set math.equation(numbering: "(1)")

= Van Hove singularities

#problem[
  Consider the dispersion relation (single-particle energy states) for electrons on a simple hypercubic lattice in $d$ dimensions, with only nearest-neighbor hopping:

  $
    epsilon_vb(k) = -2 t sum_(i=1)^d cos k_i,
  $ <eq:dispersion>

  with the hopping amplitude $t$ and the lattice constant $a = 1$. The density of single-particle states in this system is then given by

  $
    N(epsilon)
    = 1 / (2 pi)^d
    integral_(-pi)^pi dif^d k
    delta(epsilon - epsilon_vb(k)).
  $ <eq:dos>

  In the first exercise you have calculated numerically and then plotted these densities of states for $d = 1, 2, 3$. Here, the singular structures (divergences, cusps) of these functions should be analyzed analytically.
]

==

#problem[
  Calculate $N(epsilon)$ for $d = 1$ explicitly and determine the interval $[epsilon_1, epsilon_2]$ on which $N(epsilon) != 0$.
  Moreover, identify the values $epsilon^*$ where $D$ diverges, i.e. where $N(epsilon^*) = infinity$.
  From which points $vb(k^*)$ in the dispersion relation originate these divergences?
  Show that the divergences can be reproduced by taking into account only the contributions from these $vb(k^*)$-points.

  _Hint: Replace $epsilon_vb(k)$ in @eq:dos by a corresponding Taylor-expansion around these points up to second order._
]

#solution[
  From Exercise 1, for $d = 1$ the dispersion is
  $
    epsilon_k = -2 t cos(k),
  $
  so the density of states is
  $
    N(epsilon) = cases(
      1/(pi sqrt(4 t^2 - epsilon^2)) & "if" abs(epsilon) < 2 t,
      0 & "if" abs(epsilon) > 2 t,
    ).
  $
  Thus the band is supported on
  $
    epsilon in [-2t, 2t]
  $
  and the DOS diverges at the band edges
  $
    epsilon^*_1 & = minus 2t \
    epsilon^*_2 & = + 2t
  $
  The dispersion has value $epsilon^*_1 = - 2t$ at
  $
    vb(k^*)_1 = 0
  $
  and $epsilon^*_2 = + 2t$ at
  $
    vb(k^*)_2 = plus.minus pi.
  $

  - Expanding $epsilon_vb(k)$ around $vb(k^*)_1 = 0$ (a minimum, with $epsilon_(vb(k)^*_1) = -2t$) gives
    $
      epsilon_k = - 2 t + k^2 t + Order(k^4)
    $
    which yields for the DOS
    $
      N_1(epsilon) = cases(
        0 & "if" epsilon < -2t,
        1 / (4 pi sqrt(t (2t + epsilon))) & "if" -2t <= epsilon
      ),
    $
    a band-edge singularity at the onset ($epsilon = -2t$) of DOS.

  - Expanding $epsilon_vb(k)$ around $vb(k^*)_2 = plus.minus pi$ (a maximum with $epsilon_(vb(k)^*_2) = 2t$) gives
    $
      epsilon_k = 2 t - (k minus.plus pi)^2 t + Order((k minus.plus pi)^4)
    $
    which yields for the DOS
    $
      N_2(epsilon) = cases(
        1 / (4 pi sqrt(t (2t - epsilon))) & "if" epsilon <= 2t,
        0 & "if" 2t < epsilon
      ),
    $
    a band-edge singularity at the cutoff ($epsilon = +2t$) of DOS.

  #align(center)[
    #plot(
      width: 6,
      height: 4,
      xmin: -2.2,
      xmax: 2.2,
      ymin: 0.0,
      ymax: 1.01,
      axis-y-extend: 0.2,
      show-grid: "none",
      xlabel: $frac(epsilon, t, style: "horizontal")$,
      ylabel: $t N (epsilon)$,

      (
        fn: e => 1.0 / (calc.pi * calc.sqrt(4 - calc.pow(e, 2))),
        domain: (-1.999999, 1.999999),
        stroke: accent,
      ),
      (
        fn: e => 1.0 / (4 * calc.pi * calc.sqrt(2 + e)),
        domain: (-1.999999, 1.999999),
        stroke: soft,
      ),
      (
        fn: e => 1.0 / (4 * calc.pi * calc.sqrt(2 - e)),
        domain: (-1.999999, 1.999999),
        stroke: plot-gray,
      ),
    )
  ]

  The plot shows that $N_plus.minus (epsilon)$ (grey curves) exhibit the same divergences as $N(epsilon)$.
]

==

#problem[
  For $d = 2$ one can show that $N(epsilon)$ is essentially given by a complete elliptic integral of the first kind.
  Here, however, only the singular contributions to $N(epsilon)$ should be analyzed.
  As in the one-dimensional case a singular contribution originates from stationary points in the dispersion relation.
  Determine the kind of stationary point (i.e., maximum, minimum or saddle point) which generates this so-called Van Hove singularity in the two-dimensional DOS and determine the singular contribution to $N(epsilon)$ by expanding $epsilon_vb(k)$ around the corresponding stationary point in @eq:dos as for the one-dimensional case above.
]

#solution[
  The dispersion relation has gradient
  $
    grad epsilon_vb(k) = 2t vec(sin k_x, sin k_y)
  $
  and thus stationary points at
  $
    vb(k)_1 = vec(0, 0)
  $
  (minimum),
  $
    vb(k)_2 = vec(pi, pi)
  $
  (maximum) and
  $
    vb(k)_3 = vec(0, pi)
  $
  (saddle point).

  Note 1: $pi$ should be taken to mean $plus.minus pi$ (periodic BC).

  Note 2: There is also $vec(pi, 0)$, which is equivalent by lattice symmetry to $vb(k)_3$.

  - We first expand around $vb(k)_1$ where $epsilon_(vb(k)_1) = -4t$:
    $
      epsilon_vb(k) = -4t + norm(vb(k))^2 t + Order(vb(k)^4)
    $
    which yields for the DOS
    $
      N_1(epsilon) = cases(
        0 & "if" epsilon < -4t,
        1 / (4 pi t) & "if" -4t <= epsilon
      ),
    $
    i.e. a band-edge singularity at DOS onset.

  - We now expand around $vb(k)_2$ where $epsilon_(vb(k)_2) = 4t$:
    $
      epsilon_vb(k) = 4t - norm(vb(k) - vb(k)_2)^2 t + Order((vb(k) - vb(k)_2)^4)
    $
    which yields for the DOS
    $
      N_2(epsilon) = cases(
        1 / (4 pi t) & "if" epsilon <= 4t,
        0 & "if" 4t < epsilon,
      ),
    $
    i.e. a band-edge singularity at DOS cutoff.

  - Lastly, we treat the saddle-point $vb(k)_3$ where $epsilon_(vb(k)_3) = 0$:
    $
      epsilon_vb(k) = k_x^2 t - (k_y - pi)^2 t + Order((vb(k) - vb(k)_3)^4)
    $
    which yields for the DOS
    $
      N_3(epsilon) = 1 / (4 pi^2 t) op("arcosh")(pi sqrt(t / abs(epsilon)))
    $
    i.e. a logarithmic singularity at $epsilon = 0$. Around $epsilon -> 0$, it has the leading asymptotic form
    $
      N_3(epsilon) -> 1 / (4 pi^2 t) log(2 pi sqrt(t / abs(epsilon))) = - 1/(8 pi^2 t) log abs(epsilon) + 1/(8 pi^2 t) log(4pi^2 t).
    $

    The contribution to the DOS is twice what is stated here because of the aforementioned second saddle point.

  From Exercise 1, for $t = 1$ the two-dimensional square-lattice DOS was
  $
    N(epsilon) = cases(
      1/(2 pi^2 t) K(1 - epsilon^2 / (16 t^2)) & "if" abs(epsilon) < 4 t,
      0 & "if" abs(epsilon) > 4 t,
    ),
  $
  where
  $
    K(m) = integral_0^(pi/2) frac(dif phi, sqrt(1 - m sin^2(phi))).
  $
  Thus the singular feature already found in Exercise 1 is a logarithmic Van Hove singularity at
  $
    epsilon = 0,
  $
  while the band edges at $epsilon = plus.minus 4t$ have finite DOS.

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

  #let acosh(x) = calc.ln(x + calc.sqrt(x * x - 1))

  #align(center)[
    #plot(
      width: 6,
      height: 4,
      xmin: -4.2,
      xmax: 4.2,
      ymin: 0.0,
      ymax: 0.6,
      axis-y-extend: 0.05,
      show-grid: "none",
      xlabel: $frac(epsilon, t, style: "horizontal")$,
      ylabel: $t N(epsilon)$,


      // Lower band-edge contribution from the minimum at epsilon = -4t
      (
        fn: e => 1.0 / (4 * calc.pi),
        domain: (-4.0, 4.0),
        stroke: soft,
        label: [$N_1$ and $N_2$],
        label-pos: 0.,
        label-side: "left",
      ),

      // Leading Van Hove logarithmic singularity from both saddle points
      (
        fn: e => 1.0 / (2 * calc.pow(calc.pi, 2)) * acosh(16 / calc.abs(e)),
        domain: (-4, -0.000001),
        stroke: soft,
      ),
      (
        fn: e => 1.0 / (2 * calc.pow(calc.pi, 2)) * acosh(16 / calc.abs(e)),
        domain: (0.000001, 4),
        stroke: soft,
        label: $N_3$,
      ),

      // Exact 2D square-lattice DOS:
      // t N(epsilon) = 1/(2 pi^2) K(1 - (epsilon/t)^2 / 16)
      (
        fn: e => 1.0 / (2 * calc.pow(calc.pi, 2)) * elliptic-k(1 - calc.pow(e, 2) / 16),
        domain: (-4, -0.001),
        stroke: red,
      ),
      (
        fn: e => 1.0 / (2 * calc.pow(calc.pi, 2)) * elliptic-k(1 - calc.pow(e, 2) / 16),
        domain: (0.001, 4),
        stroke: red,
        label: $N$,
        label-pos: 0.0,
        label-side: "right",
      ),
    )
  ]
]

==

#problem[
  Try to predict how the singular behavior of the DOS evolves with the dimensions of the system for $d >= 3$.
]

#solution[
  We have that:
  - Minimum of $epsilon_vb(k)$ $=>$ Singularity at DOS onset
  - Maximum of $epsilon_vb(k)$ $=>$ Singularity at DOS cutoff
  - Saddle point of $epsilon_vb(k)$ $=>$ Singularity within DOS

  So, for $d >= 3$:
  - Minimum at $vb(k) = 0$:

    DOS "starts" at $epsilon = -2 d t$ with a singularity.

  - Maximum at $vb(k) = (pi, pi, dots, pi)^T$:

    DOS "ends" at $epsilon = +2 d t$ with a singularity.

  - Saddle points at $vb(k) = lr(
      (
        underbrace(lr(0, dots, 0), p),
        underbrace(lr(pi, dots, pi), d - p)), size: #1em
    )^T$ with $1 <= p < d$:

    DOS has a singularity at $epsilon = 2 (d - 2p) t$.


  #v(2em)

  Examples:

  - $d = 3$

    Start at $-6t$, singularities at $-2t$ and $2t$, end at $6t$.

  - $d = 4$

    Start at $-8t$, singularities at $-4t$, $0$ and $4t$, end at $8t$.
]

==

#problem[
  _(Bonus points)_ Finally, consider the limit $d -> infinity$.
  In this case, one has to rescale the hopping amplitude as $t -> frac(t, sqrt(d), style: "horizontal")$ in order to render the total energy of the system as well as the second moment (standard deviation) of the density of state finite.
  Show that $N_infinity (epsilon)$ is proportional to a Gauß distribution.
]

= Magnetic susceptibilities in $d$ dimensions

#problem[
  Consider a system of non-interacting electrons on a (hyper)cubic lattice whose energy dispersion is given by @eq:dispersion.
]

==

#problem[
  Compute the magnetic susceptibility, i.e. the Fourier transform of the spin-spin response function

  $
    chevron.l T_tau S^z (vb(r)_i, tau) S^z (0, 0) chevron.r,
  $

  with

  $
    S^z (vb(r)_i, tau)
    = hbar / 2 [
      c^dagger_(i arrow.t)(tau) c_(i arrow.t)(tau)
      - c^dagger_(i arrow.b)(tau) c_(i arrow.b)(tau)
    ],
  $

  for the frequency $Omega_m = 0$ (static susceptibility), and for the two momenta $vb(Q) = (0, 0, 0, dots)$ (ferromagnetic susceptibility) and $vb(Q) = (pi, pi, pi, dots)$ (antiferromagnetic susceptibility).
]

==

#problem[
  Determine the leading divergences of the ferromagnetic and the antiferromagnetic susceptibilities for $T -> 0$ in $d = 2$ dimensions.
  To this end write the total density of states as a sum of a singular and a regular contribution as calculated in Problem 10b).

  _Hint: It is convenient to write the total density of states as $N(epsilon) = N_"reg"(epsilon) + N_"sing"(epsilon)$, and treat the two contributions separately. For the ferromagnetic case, expand $N_"reg"$ around zero (Sommerfeld-like expansion) and, for the singular part, change variable to $x = beta epsilon$ to make the temperature dependence manifest. For the antiferromagnetic case, (i) differentiate the susceptibility with respect to $beta$ before integrating, (ii) proceed as in the ferromagnetic case, (iii) integrate back over $beta$ at the end._
]

==

#problem[
  Discuss how the results above are modified in $d >= 3$ dimensions.
]

==

#problem[
  Consider now non-interacting electrons on a one-dimensional lattice with dispersion $epsilon_k = -2 t cos(k a)$ at half-filling ($mu = 0$).
  Is there a $Q$-point in the Brillouin zone, $Q in [0, 2 pi]$, for which $epsilon_(k + Q) = -epsilon_k = 0$?
  What is the signature of this “nesting” property in the free (bubble) susceptibility $chi_0(Q, omega = 0)$ (calculated in Exercise 2, Problem 4c)?
  Remember that the sum over $k$, $sum_k$, can be replaced by $integral dif epsilon N(epsilon)$ with the density of states $N(epsilon)$ from Exercise 1.
]

#solution[
  From Exercise 1, the one-dimensional nearest-neighbor tight-binding dispersion is
  $
    epsilon_k = -2 t cos(k a).
  $
  At half filling, the Fermi energy is
  $
    epsilon_"F" = 0,
  $
  and for $a = 1$ the Fermi points are
  $
    k = plus.minus pi/2.
  $
  The corresponding one-dimensional DOS from Exercise 1 is
  $
    N_1(epsilon) = cases(
      1/(pi sqrt(4 t^2 - epsilon^2)) & "if" abs(epsilon) < 2 t,
      0 & "if" abs(epsilon) > 2 t,
    ).
  $
]
