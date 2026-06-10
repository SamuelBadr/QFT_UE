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

==

#problem[
  For $d = 2$ one can show that $N(epsilon)$ is essentially given by a complete elliptic integral of the first kind.
  Here, however, only the singular contributions to $N(epsilon)$ should be analyzed.
  As in the one-dimensional case a singular contribution originates from stationary points in the dispersion relation.
  Determine the kind of stationary point (i.e., maximum, minimum or saddle point) which generates this so-called Van Hove singularity in the two-dimensional DOS and determine the singular contribution to $N(epsilon)$ by expanding $epsilon_vb(k)$ around the corresponding stationary point in @eq:dos as for the one-dimensional case above.
]

==

#problem[
  Try to predict how the singular behavior of the DOS evolves with the dimensions of the system for $d >= 3$.
]

==

#problem[
  _(Bonus points)_ Finally, consider the limit $d -> infinity$.
  In this case, one has to rescale the hopping amplitude as $t -> t / sqrt(d)$ in order to render the total energy of the system as well as the second moment (standard deviation) of the density of state finite.
  Show that $N_infinity(epsilon)$ is proportional to a Gauß distribution.
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
