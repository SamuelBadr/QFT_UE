#import "../exercise-style.typ": *

#sheet-header(
  [QFT for Many-Body Systems],
  [1. Exercise Sheet Solutions],
  date: [Sommersemester 2026],
)

TUTORIUM: Friday, 20.03.2026.

= 1. Getting familiar with the Density of States

The calculation of thermodynamic quantities, response functions and Feynman diagrams in QFT for condensed matter systems often requires the evaluation of integrals or sums over all momenta $vb(k)$ (typically over the first Brillouin Zone). An important simplification of these $vb(k)$-summations is possible, however, when the integrand $cal(F)$ depends on the *energy only*. In this case the integration/sum is best performed by using the energy $epsilon$ as a variable. In the case of a cubic lattice of volume $L^d$ in $d$ dimensions, for a given observable $F$, we have:

$
  F = 1 / L^d sum_(vb(k)) cal(F)(epsilon_(vb(k)))
  = 1/(2 pi)^d (2 pi)^d / (L^d) sum_(vb(k)) cal(F)(epsilon_(vb(k)))
  = integral dd(epsilon) cal(N)(epsilon) cal(F)(epsilon)
$

or, for the continuous case,

$
  F = 1 / (2 pi)^d integral dd(k, [d]) cal(F)(epsilon_(vb(k)))
  = integral dd(epsilon) cal(N)(epsilon) cal(F)(epsilon),
$

where $cal(N)(epsilon)$, i.e. the so-called Density of States (DOS), can be defined by comparison of the different expressions as

$
  cal(N)(epsilon) = 1 / L^d sum_(vb(k)) delta(epsilon - epsilon_(vb(k)))
$

or, for the continuous case,

$
  cal(N)(epsilon) = 1 / (2 pi)^d integral dd(k, [d]) delta(epsilon - epsilon_(vb(k))).
$

== a)

#statement[
  Consider the two cases of particles which can move freely and particles whose motion is bound to an infinite lattice with lattice spacing $a$. Which of the above expressions do you have to use in the first and second case, respectively? Is the integral/summation restricted to certain $vb(k)$-vectors? How does the result change, if one considers a one-dimensional, finite lattice ($N$ lattice points, lattice spacing $a$) with periodic boundary conditions?
]

#solution[
  Freely moving particles can have arbitrary momenta, requiring integration over all of space
  $
    cal(N)(epsilon) = 1 / (2 pi)^d integral_(RR^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k))).
  $
  Particles bound to an infinite lattice with lattice spacing $a$ can only have momenta within the first Brillouin zone, i.e.
  $
    cal(N)(epsilon) = 1 / (2 pi)^d integral_([0, frac(2pi, a)]^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k))).
  $
  Finally, for a one-dimensional, finite ($N$ lattice points, spacing $a$) lattice with periodic boundary conditions, the summation is restricted to a discrete set of allowed momenta
  $
    cal(N)(epsilon) = 1 / N sum_(k in K) delta(epsilon - epsilon_k)
  $
  with $K = {frac(2pi, a) j/N | j = 0, dots, N-1}$.
]

== b)

#statement[
  Calculate and plot the explicit expression for $cal(N)(epsilon)$ for free, non-interacting particles of mass $m$ (so that $epsilon_(vb(k)) = frac(hbar^2 k^2, 2 m)$) in one, two and three dimensions. How do the corresponding Fermi surfaces look like in these cases?
]

#solution[
  $
    cal(N)(epsilon) = 1 / (2 pi)^d integral_(RR^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k)))
  $
  with $epsilon_(vb(k)) = frac(hbar^2 k^2, 2 m)$.
  We have
  $
    integral_(RR^d) dd(k, [d]) delta(g(vb(k))) = integral_(g^(-1)(0)) frac(1, abs(grad g)) dd(sigma(k))),
  $
  which for $g(vb(k)) = epsilon - epsilon_(vb(k))$, $g^(-1)(0) = S^(d-1) (k_"F")$  and $abs(grad g) = frac(hbar^2 k, m)$ yields
  $
    cal(N)(epsilon) = 1 / (2 pi)^d abs(S^(d-1) (k_"F")) frac(1, frac(hbar^2 k_"F", m))
  $
  where $k_"F" = frac(sqrt(2 m epsilon), hbar)$ is the Fermi momentum and $S^(d-1) (k)$ is the radius-$k$ sphere in $d$ dimensions.

  #grid(
    columns: (auto, auto),
    // gutter: 0em,

    [
      - $d=1$: $|S^0(k)| = 2$, hence
      $
        cal(N)(epsilon) = 1/(2 pi) sqrt(2m)/(hbar sqrt(epsilon))
      $
      Fermi surface: two points at $k = plus.minus k_"F"$.

      - $d=2$: $|S^1(k)| = 2 pi k$, hence
        $
          cal(N)(epsilon) = 1/(2 pi) m/hbar^2
        $
        Fermi surface: circle with radius $k_"F"$.

      - $d=3$: $|S^2(k)| = 4 pi k^2$, hence
        $
          cal(N)(epsilon) = 1/(2 pi^2) m/hbar^2 sqrt(2m epsilon)/hbar
        $
        Fermi surface: sphere with radius $k_"F"$.
    ],

    [
      #plot(
        xmin: 0.0,
        xmax: 4.0,
        ymin: 0.0,
        ymax: 2.4,

        xlabel: $frac(epsilon, epsilon_0, style: "horizontal")$,
        ylabel: $frac(cal(N) (epsilon), cal(N)(epsilon_0), style: "horizontal")$,

        (
          fn: x => 1.0 / calc.sqrt(x),
          domain: (0.1, 4.0),
          stroke: blue,
          label: $d=1$,
          label-pos: 1,
          label-side: "right",
        ),
        (
          fn: x => 1.0,
          domain: (0.1, 4.0),
          stroke: red,
          label: $d=2$,
          label-pos: 1,
          label-side: "right",
        ),
        (
          fn: x => calc.sqrt(x),
          domain: (0.1, 4.0),
          stroke: green,
          label: $d=3$,
          label-pos: 1,
          label-side: "right",
        ),
      )
    ],
  )
]

== c)

#statement[
  Consider the following one-dimensional tight-binding Hamiltonian
  $
    H = -t sum_(chevron.l i, j chevron.r, sigma) (c^dagger_(i, sigma) c_(j, sigma) + "h.c.").
  $
  Here the hopping ($t > 0$) is restricted to neighboring sites, where $c^dagger_(i, sigma)$ and $c_(i, sigma)$ are the creation/annihilation operators for one electron with spin $sigma = arrow.t, arrow.b$ at the position $x_i = i a$ with $i = 0, 1, ..., N - 1$ and $a$ being the lattice spacing. Assuming periodic boundary conditions ($x_0 = x_N$), compute the corresponding eigenenergies, e.g. using the following basis transformation (from real to momentum space)
  $
    c^dagger_(k, sigma) = 1 / sqrt(N) sum_(x_i) e^(-i k x_i) c^dagger_(i, sigma)
  $
  for the fermionic operators.
]

#solution[
  We use the given basis transformation
  $
    c^dagger_(k, sigma) = 1 / sqrt(N) sum_(x_i) e^(-i k x_i) c^dagger_(i, sigma)
  $
  and invert it to express the real-space operators in terms of the momentum-space operators
  $
    c^dagger_(i, sigma) & = 1 / sqrt(N) sum_k e^(i k x_i) c^dagger_(k, sigma) \
           c_(i, sigma) & = 1 / sqrt(N) sum_k e^(-i k x_i) c_(k, sigma).
  $
  Plugging into the Hammiltonian, we arrive at (here, $j+1$ is to be understood modulo $N$ due to the periodic boundary conditions)
  $
    H &= -t sum_(j, sigma) (c^dagger_(j, sigma) c_(j+1, sigma) + "h.c.") \
    &= -t sum_(j, sigma) (1 / sqrt(N) sum_k e^(i k x_j) c^dagger_(k, sigma) 1 / sqrt(N) sum_k' e^(-i k' x_(j+1)) c_(k', sigma) + "h.c.") \
    &= -t 1/N sum_(k,k') sum_(j, sigma) (e^(i k j a - i k' (j+1) a) c^dagger_(k, sigma) c_(k', sigma) + "h.c.")
  $
  Now we use the identity
  $
    1/N sum_j e^(i k j a - i k' (j+1) a) = e^(-i k' a) 1/N sum_j e^(i j a (k - k')) = e^(-i k' a) delta_(k, k')
  $
  to arrive at
  $
    H & = -t sum_(k,k') sum_(sigma) (e^(-i k' a) delta_(k,k') c^dagger_(k, sigma) c_(k', sigma) + "h.c.") \
      & = -t sum_(k,sigma) (e^(-i k a) c^dagger_(k, sigma) c_(k, sigma) + "h.c.") \
      & = -t sum_(k,sigma) (e^(-i k a) c^dagger_(k, sigma) c_(k, sigma) + e^(i k a) c^dagger_(k, sigma) c_(k, sigma)) \
      & =sum_(k,sigma) epsilon_k c^dagger_(k, sigma) c_(k, sigma)
  $
  with eigenenergies
  $
    epsilon_k = -2 t cos(k a)
  $
  and eigenstates
  $
    ket((k, sigma)) = c^dagger_(k, sigma) ket(0).
  $
]

== d)

#statement[
  How can one extend the results of 1c) to arbitrary dimensions $d > 1$? Plot numerically the DOS $cal(N)(epsilon)$ for the cases $d = 1, 2, 3$ with $#hbar = m = t = a = 1$. Which are the most prominent features of these DOS functions and at which energies $epsilon$ do they occur? How would the corresponding Fermi surfaces look like for the cases $d = 1, 2$, e.g. if one has an average density of one electron per site (half-filled system)?
]

#solution[
  In arbitrary dimension $d > 1$, the tight-binding Hamiltonian is
  $
    H = sum_(vb(k), sigma) epsilon_(vb(k)) c^dagger_(vb(k), sigma) c_(vb(k), sigma),
  $
  with dispersion
  $
    epsilon_(vb(k)) = -2 t sum_(i=1)^d cos(k_i a).
  $
  The density of states is therefore
  $
    cal(N)_d(epsilon)
    = 1/(2 pi)^d
    integral_([0, 2 pi / a]^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k))).
  $

  Using
  $
    integral_([0, 2 pi / a]^d) dd(k, [d]) delta(g(vb(k)))
    = integral_(g^(-1)(0) inter [0, 2 pi / a]^d)
    frac(dd(sigma(vb(k))), abs(grad g)),
  $
  with $g(vb(k)) = epsilon - epsilon_(vb(k))$, and setting $hbar = m = t = a = 1$, we obtain
  $
    grad g = -2 vec(sin(k_1), dots.v, sin(k_d)),
    quad
    abs(grad g) = 2 sqrt(sum_(i=1)^d sin^2(k_i)).
  $

  - $d = 1$: For $abs(epsilon) < 2$, there are two Fermi points $plus.minus k_"F"$ with
    $
      cos(k_"F") = -epsilon / 2.
    $
    Hence
    $
      abs(grad g)
      = 2 abs(sin(k_"F"))
      = 2 sqrt(1 - cos^2(k_"F"))
      = sqrt(4 - epsilon^2),
    $
    and therefore
    $
      cal(N)_1(epsilon) = dcases(
        1/(pi sqrt(4 - epsilon^2)) & "if" abs(epsilon) < 2,
        0 & "otherwise"
      ).
    $

  - $d = 2$: We write
    $
      cal(N)_2(epsilon)
      = 1/(2 pi)^2
      integral_0^(2 pi) dd(k_x)
      integral_0^(2 pi) dd(k_y)
      delta(epsilon + 2 cos(k_x) + 2 cos(k_y)).
    $
    For fixed $k_x$, define
    $
      A = epsilon + 2 cos(k_x).
    $
    Then the inner integral is exactly the $d=1$ result:
    $
      integral_0^(2 pi) dd(k_y) delta(A + 2 cos(k_y))
      = 2 / sqrt(4 - A^2).
    $
    Thus
    $
      cal(N)_2(epsilon)
      = 1/(2 pi)^2
      integral_0^(2 pi) dd(k_x)
      frac(2, sqrt(4 - (epsilon + 2 cos(k_x))^2)).
    $
    With $u = cos(k_x)$ and symmetry, this becomes
    $
      cal(N)_2(epsilon)
      = 1/(pi^2)
      integral_(-1)^1
      frac(dd(u), sqrt(1 - u^2) sqrt(4 - (epsilon + 2u)^2)).
    $
    This is the complete elliptic integral of the first kind, so
    $
      cal(N)_2(epsilon) = dcases(
        1/(2 pi^2) K(sqrt(1 - epsilon^2 / 16)) & "if" abs(epsilon) < 4,
        0 & "otherwise"
      ).
    $

  - $d = 3$: Starting from
    $
      cal(N)_3(epsilon)
      = 1/(2 pi)^3
      integral_0^(2 pi) dd(k_x)
      integral_0^(2 pi) dd(k_y)
      integral_0^(2 pi) dd(k_z)
      delta(epsilon + 2 cos(k_x) + 2 cos(k_y) + 2 cos(k_z)),
    $
    we fix $k_z$ and define
    $
      epsilon' = epsilon + 2 cos(k_z).
    $
    The remaining $k_x,k_y$ integral is then exactly the $d=2$ DOS at energy $epsilon'$:
    $
      cal(N)_3(epsilon)
      = 1/(2 pi) integral_0^(2 pi) dd(k_z) cal(N)_2(epsilon + 2 cos(k_z)).
    $
    Inserting the $d=2$ result gives
    $
      cal(N)_3(epsilon)
      = 1/(4 pi^3)
      integral_0^(2 pi) dd(k_z)
      K(sqrt(1 - (epsilon + 2 cos(k_z))^2 / 16)),
    $
    where the integrand contributes only if
    $
      abs(epsilon + 2 cos(k_z)) < 4.
    $
    Equivalently, with $u = cos(k_z)$,
    $
      cal(N)_3(epsilon)
      = 1/(2 pi^3)
      integral_(-1)^1
      frac(
        K(sqrt(1 - (epsilon + 2u)^2 / 16)),
        sqrt(1 - u^2)
      ) dd(u),
    $
    again with the restriction
    $
      abs(epsilon + 2u) < 4.
    $
    In particular,
    $
      cal(N)_3(epsilon) = 0 quad "for" quad abs(epsilon) > 6.
    $

  #let load-curve(path) = {
    let rows = csv(path, row-type: dictionary)
    rows.map(r => (
      float(r.at("x")),
      float(r.at("rho")),
    ))
  }

  #let c1 = load-curve("dos-data/dos_1d.csv")
  #let c2 = load-curve("dos-data/dos_2d.csv")
  #let c3 = load-curve("dos-data/dos_3d.csv")

  #plot(
    width: 8,
    height: 5,

    xmin: -3.2,
    xmax: 3.2,
    ymin: 0,
    ymax: 0.32,
    ytick-step: 0.1,
    show-grid: "major",
    axis-y-pos: "left",
    axis-x-extend: 0,
    axis-y-extend: 0,

    xlabel: $epsilon$,
    ylabel: $cal(N)(epsilon)$,

    line-plot(
      c1,
      stroke: blue,
      mark: "none",
      label: $d = 1$,
      label-pos: 0.95,
    ),

    line-plot(
      c2,
      stroke: red,
      mark: "none",
      label: $d = 2$,
      label-pos: 0.95,
    ),

    line-plot(
      c3,
      stroke: green,
      mark: "none",
      label: $d = 3$,
      label-pos: 0.95,
    ),
  )
]

= 2. Screened and Unscreened Coulomb Potentials

== a)

#statement[
  From the integral representation of the delta function,
  $
    delta(vb(r)) = integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r))
  $
  and the fact that the Coulomb potential $phi.alt(vb(r)) = -e / abs(vb(r))$ satisfies Poisson's equation,
  $
    -#laplacian phi.alt(vb(r)) = -4 pi e delta(vb(r)),
  $
  show that the electronic pair potential, $V(vb(r)) = -e phi.alt(vb(r)) = e^2 / abs(vb(r))$, can be written in the form
  $
    V(vb(r)) = integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r)) V(vb(k)),
  $
  where the Fourier transform $V(vb(k))$ is given by
  $
    V(vb(k)) = 4 pi e^2 / vb(k)^2.
  $
]

#solution[
  _Write your solution here._
]

== b)

#statement[
  Show that the Fourier transform of the screened Coulomb interaction $V_s(vb(r)) = (e^2 / abs(vb(r))) e^(-k_"TF" abs(vb(r)))$ is
  $
    V_s(vb(k)) = 4 pi e^2 / (vb(k)^2 + k_"TF"^2)
  $
  by substituting this expression into the Fourier integral
  $
    V_s(vb(r)) = integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r)) V_s(vb(k)),
  $
  and evaluating that integral in spherical coordinates (Hint: The radial integral is best done as a contour integral.). Finally, deduce that $V_s(vb(r))$ satisfies
  $
    (-#laplacian + k_"TF"^2) V_s(vb(r)) = 4 pi e^2 delta(vb(r)).
  $
]

#solution[
  _Write your solution here._
]
