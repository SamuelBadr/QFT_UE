#import "../exercise-style.typ": *

#sheet-header(
  [QFT for Many-Body Systems],
  [1. Exercise Sheet Solutions],
  date: [Sommersemester 2026],
)

TUTORIUM: Friday, 20.03.2026.

= 1. Getting familiar with the Density of States

The calculation of thermodynamic quantities, response functions and Feynman diagrams in QFT for condensed matter systems often requires the evaluation of integrals or sums over all momenta $vec(k)$ (typically over the first Brillouin Zone). An important simplification of these $vec(k)$-summations is possible, however, when the integrand $cal(F)$ depends on the *energy only*. In this case the integration/sum is best performed by using the energy $epsilon$ as a variable. In the case of a cubic lattice of volume $L^d$ in $d$ dimensions, for a given observable $F$, we have:

$
  F = 1 / L^d sum_(vec(k)) cal(F)(epsilon_(vec(k)))
  = 1/(2 pi)^d (2 pi)^d / (L^d) sum_(vec(k)) cal(F)(epsilon_(vec(k)))
  = integral dd(epsilon) cal(N)(epsilon) cal(F)(epsilon)
$

or, for the continuous case,

$
  F = 1 / (2 pi)^d integral dd(k, [d]) cal(F)(epsilon_(vec(k)))
  = integral dd(epsilon) cal(N)(epsilon) cal(F)(epsilon),
$

where $cal(N)(epsilon)$, i.e. the so-called Density of States (DOS), can be defined by comparison of the different expressions as

$
  cal(N)(epsilon) = 1 / L^d sum_(vec(k)) delta(epsilon - epsilon_(vec(k)))
$

or, for the continuous case,

$
  cal(N)(epsilon) = 1 / (2 pi)^d integral dd(k, [d]) delta(epsilon - epsilon_(vec(k))).
$

== a)

#statement[
  Consider the two cases of particles which can move freely and particles whose motion is bound to an infinite lattice with lattice spacing $a$. Which of the above expressions do you have to use in the first and second case, respectively? Is the integral/summation restricted to certain $vec(k)$-vectors? How does the result change, if one considers a one-dimensional, finite lattice ($N$ lattice points, lattice spacing $a$) with periodic boundary conditions?
]

#solution[
  _Write your solution here._
]

== b)

#statement[
  Calculate and plot the explicit expression for $N(epsilon)$ for free, non-interacting particles of mass $m$ (so that $epsilon_(vec(k)) = #hbar^2 vec(k)^2 / (2 m)$) in one, two and three dimensions. How do the corresponding Fermi surfaces look like in these cases?
]

#solution[
  _Write your solution here._
]

== c)

#statement[
  Consider the following one-dimensional tight-binding Hamiltonian
  $
    H = -t sum_(chevron.l i, j chevron.r, σ) (c^dagger_(i, σ) c_(j, σ) + "h.c.").
  $
  Here the hopping ($t > 0$) is restricted to neighboring sites, where $c^dagger_(i, σ)$ and $c_(i, σ)$ are the creation/annihilation operators for one electron with spin $σ = upright(↑), upright(↓)$ at the position $x_i = i a$ with $i = 0, 1, ..., N - 1$ and $a$ being the lattice spacing. Assuming periodic boundary conditions ($x_0 = x_N$), compute the corresponding eigenenergies, e.g. using the following basis transformation (from real to momentum space)
  $
    c^dagger_(k, σ) = 1 / sqrt(N) sum_(x_i) e^(-i k x_i) c^dagger_(i, σ)
  $
  for the fermionic operators.
]

#solution[
  _Write your solution here._
]

== d)

#statement[
  How can one extend the results of 1c) to arbitrary dimensions $d > 1$? Plot numerically the DOS $N(epsilon)$ for the cases $d = 1, 2, 3$ with $#hbar = m = t = a = 1$. Which are the most prominent features of these DOS functions and at which energies $epsilon$ do they occur? How would the corresponding Fermi surfaces look like for the cases $d = 1, 2$, e.g. if one has an average density of one electron per site (half-filled system)?
]

#solution[
  _Write your solution here._
]

= 2. Screened and Unscreened Coulomb Potentials

== a)

#statement[
  From the integral representation of the delta function,
  $
    delta(vec(r)) = integral dd(k, 3) / (2 pi)^3 e^(i vec(k) dot vec(r))
  $
  and the fact that the Coulomb potential $φ(vec(r)) = -e / abs(vec(r))$ satisfies Poisson's equation,
  $
    -#laplacian φ(vec(r)) = -4 pi e delta(vec(r)),
  $
  show that the electronic pair potential, $V(vec(r)) = -e φ(vec(r)) = e^2 / abs(vec(r))$, can be written in the form
  $
    V(vec(r)) = integral dd(k, 3) / (2 pi)^3 e^(i vec(k) dot vec(r)) V(vec(k)),
  $
  where the Fourier transform $V(vec(k))$ is given by
  $
    V(vec(k)) = 4 pi e^2 / vec(k)^2.
  $
]

#solution[
  _Write your solution here._
]

== b)

#statement[
  Show that the Fourier transform of the screened Coulomb interaction $V_s(vec(r)) = (e^2 / abs(vec(r))) e^(-k_"TF" abs(vec(r)))$ is
  $
    V_s(vec(k)) = 4 pi e^2 / (vec(k)^2 + k_"TF"^2)
  $
  by substituting this expression into the Fourier integral
  $
    V_s(vec(r)) = integral dd(k, 3) / (2 pi)^3 e^(i vec(k) dot vec(r)) V_s(vec(k)),
  $
  and evaluating that integral in spherical coordinates (Hint: The radial integral is best done as a contour integral.). Finally, deduce that $V_s(vec(r))$ satisfies
  $
    (-#laplacian + k_"TF"^2) V_s(vec(r)) = 4 pi e^2 delta(vec(r)).
  $
]

#solution[
  _Write your solution here._
]
