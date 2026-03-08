#import "../exercise-style.typ": *

#sheet-header(
  [QFT for Many-Body Systems],
  [1. Exercise Sheet Solutions],
  date: [Sommersemester 2026],
)

#align(right)[
  #text(
    font: "Hiragino Sans",
    size: 7.8pt,
    weight: "medium",
    tracking: 0.16em,
    fill: accent,
  )[TUTORIUM: Friday, 20.03.2026.]
]

#major-section([01], [Getting familiar with the Density of States])

The calculation of thermodynamic quantities, response functions and Feynman diagrams in QFT for condensed matter systems often requires the evaluation of integrals or sums over all momenta $vb(k)$ (typically over the first Brillouin Zone). An important simplification of these $vb(k)$-summations is possible, however, when the integrand $cal(F)$ depends on the *energy only*. In this case the integration/sum is best performed by using the energy $epsilon$ as a variable. In the case of a cubic lattice of volume $L^d$ in $d$ dimensions, for a given observable $F$, we have:

$
  F = 1 / L^d sum_(vb(k)) cal(F)(epsilon_(vb(k)))
  = 1/(2 pi)^d (2 pi)^d / (L^d) sum_(vb(k)) cal(F)(epsilon_(vb(k)))
  = integral dd(epsilon) cal(N)(epsilon) cal(F)(epsilon),
$

or, for the continuous case,

$
  F = 1 / (2 pi)^d integral dd(k, [d]) cal(F)(epsilon_(vb(k)))
  = integral dd(epsilon) cal(N)(epsilon) cal(F)(epsilon),
$

where $cal(N)(epsilon)$, i.e. the so-called Density of States (DOS), can be defined by comparison of the different expressions as

$
  cal(N)(epsilon) = 1 / L^d sum_(vb(k)) delta(epsilon - epsilon_(vb(k))),
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
  Freely moving particles can have arbitrary momenta, so one integrates over all of momentum space:
  $
    cal(N)(epsilon) = 1 / (2 pi)^d integral_(RR^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k))).
  $
  Particles bound to an infinite lattice with lattice spacing $a$ can only have momenta within the first Brillouin zone:
  $
    cal(N)(epsilon) = 1 / (2 pi)^d integral_([-pi/a, pi/a]^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k))).
  $
  Finally, for a one-dimensional finite lattice ($N$ lattice points, spacing $a$) with periodic boundary conditions, the sum runs over a discrete set of allowed momenta:
  $
    cal(N)(epsilon) = 1 / N sum_(k in K) delta(epsilon - epsilon_k),
  $
  with $K = {-pi/a + frac(2pi, N a) j | j = 0, dots, N-1}$.
]

== b)

#statement[
  Calculate and plot the explicit expression for $cal(N)(epsilon)$ for free, non-interacting particles of mass $m$ (so that $epsilon_(vb(k)) = frac(hbar^2 k^2, 2 m)$) in one, two and three dimensions. How do the corresponding Fermi surfaces look like in these cases?
]

#solution[
  $
    cal(N)(epsilon) = 1 / (2 pi)^d integral_(RR^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k))),
  $
  with $epsilon_(vb(k)) = frac(hbar^2 k^2, 2 m)$.
  For a given energy $epsilon > 0$, the corresponding constant-energy shell is a sphere of radius
  $
    k_(epsilon) = frac(sqrt(2 m epsilon), hbar).
  $
  Using
  $
    integral_(RR^d) dd(k, [d]) delta(g(vb(k))) = integral_(g^(-1)(0)) frac(1, abs(grad g)) dd(sigma(k)),
  $
  which for $g(vb(k)) = epsilon - epsilon_(vb(k))$, $g^(-1)(0) = S^(d-1) (k_(epsilon))$  and $abs(grad g) = frac(hbar^2 k, m)$ yields
  $
    cal(N)(epsilon) = 1 / (2 pi)^d abs(S^(d-1) (k_(epsilon))) frac(1, frac(hbar^2 k_(epsilon), m)),
  $
  where $S^(d-1) (k)$ denotes the radius-$k$ sphere in $d$ dimensions. At $epsilon = epsilon_"F"$, $k_(epsilon)$ becomes the Fermi momentum $k_"F"$, and the constant-energy shell becomes the Fermi surface.

  #grid(
    columns: (auto, auto),
    // gutter: 0em,

    [
      - $d=1$: $|S^0(k)| = 2$, hence
      $
        cal(N)(epsilon) = 1/(2 pi) sqrt(2m)/(hbar sqrt(epsilon)).
      $

      - $d=2$: $|S^1(k)| = 2 pi k$, hence
        $
          cal(N)(epsilon) = 1/(2 pi) m/hbar^2.
        $

      - $d=3$: $|S^2(k)| = 4 pi k^2$, hence
        $
          cal(N)(epsilon) = 1/(2 pi^2) m/hbar^2 sqrt(2m epsilon)/hbar.
        $
    ],

    [
      #align(center)[
        #plot(
          width: 6,
          height: 4,
          xmin: 0.0,
          xmax: 4.0,
          ymin: 0.0,
          ymax: 2.4,
          show-grid: "none",

          // Here epsilon_0 > 0 is an arbitrary reference energy used for normalization.
          xlabel: $frac(epsilon, epsilon_0, style: "horizontal")$,
          ylabel: $frac(cal(N) (epsilon), cal(N)(epsilon_0), style: "horizontal")$,

          (
            fn: x => 1.0 / calc.sqrt(x),
            domain: (0.1, 4.0),
            stroke: accent,
            label: $d=1$,
            label-pos: 1,
            label-side: "right",
          ),
          (
            fn: x => 1.0,
            domain: (0.1, 4.0),
            stroke: soft,
            label: $d=2$,
            label-pos: 1,
            label-side: "right",
          ),
          (
            fn: x => calc.sqrt(x),
            domain: (0.1, 4.0),
            stroke: plot-gray,
            label: $d=3$,
            label-pos: 1,
            label-side: "right",
          ),
        )
      ]
    ],
  )
  At $epsilon = epsilon_"F"$, these constant-energy shells become the Fermi surfaces: two points in $d = 1$, a circle in $d = 2$, and a sphere in $d = 3$.
]

== c)

#statement[
  Consider the following one-dimensional tight-binding Hamiltonian
  $
    H = -t sum_(chevron.l i, j chevron.r, sigma) (c^dagger_(i, sigma) c_(j, sigma) + "h.c.").
  $
  Here the hopping ($t > 0$) is restricted to neighboring sites, where $c^dagger_(i, sigma)$ and $c_(i, sigma)$ are the creation/annihilation operators for one electron with spin $sigma = arrow.t, arrow.b$ at the position $x_i = i a$ with $i = 0, 1, ..., N - 1$ and $a$ being the lattice spacing. Assuming periodic boundary conditions ($x_0 = x_N$), compute the corresponding eigenenergies, e.g. using the following basis transformation (from real to momentum space)
  $
    c^dagger_(k, sigma) = 1 / sqrt(N) sum_(x_i) e^(-i k x_i) c^dagger_(i, sigma),
  $
  for the fermionic operators.
]

#solution[
  We start from the given basis transformation
  $
    c^dagger_(k, sigma) = 1 / sqrt(N) sum_(x_i) e^(-i k x_i) c^dagger_(i, sigma)
  $
  and invert it to express the real-space operators in terms of momentum-space operators:
  $
    c^dagger_(i, sigma) & = 1 / sqrt(N) sum_k e^(i k x_i) c^dagger_(k, sigma) \
           c_(i, sigma) & = 1 / sqrt(N) sum_k e^(-i k x_i) c_(k, sigma).
  $
  For periodic boundary conditions, the allowed momenta are
  $
    k = -pi/a + frac(2pi, N a) n, quad n = 0, dots, N-1.
  $
  With this discrete set of momenta, the finite geometric sum in the Hamiltonian becomes the Kronecker delta appearing below.
  Substituting this into the Hamiltonian, we obtain (here $j+1$ is understood modulo $N$ because of the periodic boundary conditions)
  $
    H &= -t sum_(j, sigma) (c^dagger_(j, sigma) c_(j+1, sigma) + "h.c.") \
    &= -t sum_(j, sigma) (1 / sqrt(N) sum_k e^(i k x_j) c^dagger_(k, sigma) 1 / sqrt(N) sum_k' e^(-i k' x_(j+1)) c_(k', sigma) + "h.c.") \
    &= -t 1/N sum_(k,k') sum_(j, sigma) (e^(i k j a - i k' (j+1) a) c^dagger_(k, sigma) c_(k', sigma) + "h.c."),
  $
  Using the identity
  $
    1/N sum_j e^(i k j a - i k' (j+1) a) = e^(-i k' a) 1/N sum_j e^(i j a (k - k')) = e^(-i k' a) delta_(k, k'),
  $
  we find
  $
    H & = -t sum_(k,k') sum_(sigma) (e^(-i k' a) delta_(k,k') c^dagger_(k, sigma) c_(k', sigma) + "h.c.") \
      & = -t sum_(k,sigma) (e^(-i k a) c^dagger_(k, sigma) c_(k, sigma) + "h.c.") \
      & = -t sum_(k,sigma) (e^(-i k a) c^dagger_(k, sigma) c_(k, sigma) + e^(i k a) c^dagger_(k, sigma) c_(k, sigma)) \
      & = sum_(k,sigma) epsilon_k c^dagger_(k, sigma) c_(k, sigma)
  $
  Thus the eigenenergies are
  $
    epsilon_k = -2 t cos(k a)
  $
  and the corresponding eigenstates are
  $
    ket((k, sigma)) = c^dagger_(k, sigma) ket(0).
  $
]

== d)

#statement[
  How can one extend the results of 1c) to arbitrary dimensions $d > 1$? Plot numerically the DOS $cal(N)(epsilon)$ for the cases $d = 1, 2, 3$ with $#hbar = m = t = a = 1$. Which are the most prominent features of these DOS functions and at which energies $epsilon$ do they occur? How would the corresponding Fermi surfaces look like for the cases $d = 1, 2$, e.g. if one has an average density of one electron per site (_half-filled system_)?
]

#solution[
  In arbitrary dimensions $d > 1$, the tight-binding Hamiltonian is
  $
    H = sum_(vb(k), sigma) epsilon_(vb(k)) c^dagger_(vb(k), sigma) c_(vb(k), sigma),
  $
  with dispersion
  $
    epsilon_(vb(k)) = -2 t sum_(i=1)^d cos(k_i a),
  $
  The density of states is therefore
  $
    cal(N)_d (epsilon)
    = 1/(2 pi)^d
    integral_([-pi / a, pi / a]^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k))),
  $

  Using
  $
    integral_([-pi / a, pi / a]^d) dd(k, [d]) delta(g(vb(k)))
    = integral_(g^(-1)(0) inter [-pi/a, pi/a]^d)
    frac(dd(sigma(vb(k))), abs(grad g)),
  $
  with $g(vb(k)) = epsilon - epsilon_(vb(k))$, and setting $hbar = m = t = a = 1$, we obtain
  $
    grad g = -2 vec(sin(k_1), dots.v, sin(k_d)),
    quad
    abs(grad g) = 2 sqrt(sum_(i=1)^d sin^2(k_i)),
  $

  - $d = 1$: For $abs(epsilon) < 2$, there are two solutions $plus.minus k_(epsilon)$ with
    $
      cos(k_(epsilon)) = -epsilon / 2,
    $
    Hence
    $
      abs(grad g)
      = 2 abs(sin(k_(epsilon)))
      = 2 sqrt(1 - cos^2(k_(epsilon)))
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
      integral_(-pi)^pi dd(k_x)
      integral_(-pi)^pi dd(k_y)
      delta(epsilon + 2 cos(k_x) + 2 cos(k_y)),
    $
    For fixed $k_x$, define
    $
      A = epsilon + 2 cos(k_x),
    $
    Then the inner integral is exactly the $d=1$ result:
    $
      integral_(-pi)^pi dd(k_y) delta(A + 2 cos(k_y))
      = 2 / sqrt(4 - A^2).
    $
    Thus
    $
      cal(N)_2(epsilon)
      = 1/(2 pi)^2
      integral_(-pi)^pi dd(k_x)
      frac(2, sqrt(4 - (epsilon + 2 cos(k_x))^2)),
    $
    With $u = cos(k_x)$ and symmetry, this becomes
    $
      cal(N)_2(epsilon)
      = 1/(pi^2)
      integral_(-1)^1
      frac(dd(u), sqrt(1 - u^2) sqrt(4 - (epsilon + 2u)^2)).
    $
    This is a complete elliptic integral of the first kind, so
    $
      cal(N)_2(epsilon) = dcases(
        1/(2 pi^2) K(sqrt(1 - epsilon^2 / 16)) & "if" abs(epsilon) < 4,
        0 & "otherwise"
      ),
    $

  - $d = 3$: Starting from
    $
      cal(N)_3(epsilon)
      = 1/(2 pi)^3
      integral_(-pi)^pi dd(k_x)
      integral_(-pi)^pi dd(k_y)
      integral_(-pi)^pi dd(k_z)
      delta(epsilon + 2 cos(k_x) + 2 cos(k_y) + 2 cos(k_z)),
    $
    we fix $k_z$ and define
    $
      epsilon' = epsilon + 2 cos(k_z),
    $
    The remaining $k_x,k_y$ integral is exactly the $d=2$ DOS at energy $epsilon'$:
    $
      cal(N)_3(epsilon)
      = 1/(2 pi) integral_(-pi)^pi dd(k_z) cal(N)_2(epsilon + 2 cos(k_z)),
    $
    Inserting the $d=2$ result gives
    $
      cal(N)_3(epsilon)
      = 1/(4 pi^3)
      integral_(-pi)^pi dd(k_z)
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

  #align(center)[
    #plot(
      width: 7.7,
      height: 4.7,

      xmin: -6.2,
      xmax: 6.2,
      ymin: 0,
      ymax: 0.32,
      ytick-step: 0.1,
      show-grid: "none",
      axis-y-pos: "left",
      axis-x-extend: 0.5,
      axis-y-extend: 0.04,

      xlabel: $epsilon$,
      ylabel: $cal(N)(epsilon)$,

      line-plot(
        c1,
        stroke: accent,
        mark: "none",
        label: $d = 1$,
        label-pos: 0.95,
      ),

      line-plot(
        c2,
        stroke: soft,
        mark: "none",
        label: $d = 2$,
        label-pos: 0.95,
      ),

      line-plot(
        c3,
        stroke: plot-gray,
        mark: "none",
        label: $d = 3$,
        label-pos: 0.95,
      ),
    )
  ]

  === Prominent Features of the DOS Functions
  - $d = 1$: inverse square root divergence at the band edges $epsilon = plus.minus 2$.
  - $d = 2$: logarithmic van Hove singularity at $epsilon = 0$, finite band edges at $epsilon = plus.minus 4$.
  - $d = 3$: non-analytic kinks at $epsilon = plus.minus 2$, band edges at $epsilon = plus.minus 6$. The kinks occur because at $epsilon = plus.minus 2$ the topology of the constant-energy surface changes, so the phase-space measure is non-analytic there even though the DOS remains finite.

  For one electron per site (half filling), exactly half of all available single-particle
  states are occupied. Since
  $
    epsilon_(vb(k)) = -2 sum_(i=1)^d cos(k_i),
  $
  is particle-hole symmetric on the bipartite hypercubic lattice, the spectrum is symmetric
  around $epsilon = 0$. Therefore at half filling the Fermi energy at $T = 0$ is
  $
    epsilon_"F" = 0,
  $
  The Fermi surface is defined by $epsilon_(vb(k)) = epsilon_"F"$, i.e.
  $
    -2 sum_(i=1)^d cos(k_i) = 0,
  $
  Therefore
  $
    d = 1: quad cos(k) = 0 quad arrow.r quad k = plus.minus pi/2,
  $
  and
  $
    d = 2: quad cos(k_x) + cos(k_y) = 0,
  $
  i.e. a diamond-shaped Fermi surface in the first Brillouin zone.

  #grid(
    columns: (auto, auto),
    gutter: 1.1em,

    [
      #align(center + horizon)[
        #plot(
          width: 4.4,
          height: 1.5,
          xmin: -3.5,
          xmax: 3.5,
          ymin: -1,
          ymax: 1,
          axis-y-extend: 0,
          xtick: (-calc.pi, -calc.pi / 2, calc.pi / 2, calc.pi),
          xtick-labels: ($-pi$, $-pi/2$, $pi/2$, $pi$),
          ytick: (),
          xlabel: $k$,

          line-plot(
            ((-calc.pi / 2, -0.35), (-calc.pi / 2, 0.35)),
            stroke: accent,
            mark: "none",
          ),
          line-plot(
            ((calc.pi / 2, -0.35), (calc.pi / 2, 0.35)),
            stroke: accent,
            mark: "none",
          ),
        )
      ]
      #align(center)[
        #text(font: "Hiragino Sans", fill: soft)[Fermi surface for $d = 1$ at half filling]
      ]
    ],

    [
      #align(center + horizon)[
        #plot(
          width: 4.4,
          height: 4.4,
          xmin: -3.5,
          xmax: 3.5,
          ymin: -3.5,
          ymax: 3.5,
          show-origin: false,
          xtick: (-calc.pi, -calc.pi / 2, calc.pi / 2, calc.pi),
          xtick-labels: ($-pi$, $-pi/2$, $pi/2$, $pi$),
          ytick: (-calc.pi, -calc.pi / 2, calc.pi / 2, calc.pi),
          ytick-labels: ($-pi$, $-pi/2$, $pi/2$, $pi$),
          xlabel: $k_x$,
          ylabel: $k_y$,

          line-plot(
            ((0.0, calc.pi), (calc.pi, 0.0), (0.0, -calc.pi), (-calc.pi, 0.0), (0.0, calc.pi)),
            stroke: accent,
            mark: "none",
          ),
        )
      ]
      #align(center)[
        #text(font: "Hiragino Sans", fill: soft)[Fermi surface for $d = 2$ at half filling]
      ]
    ],
  )
]

#major-section([02], [Screened and Unscreened Coulomb Potentials])

== a)

#statement[
  From the integral representation of the delta function,
  $
    delta(vb(r)) = integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r)),
  $
  and the fact that the Coulomb potential $phi.alt(vb(r)) = -e \/ r$ satisfies Poisson's equation,
  $
    -laplacian phi.alt(vb(r)) = -4 pi e delta(vb(r)),
  $
  show that the electronic pair potential, $V(vb(r)) = -e phi.alt(vb(r)) = e^2 \/ r$, can be written in the form
  $
    V(vb(r)) = integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r)) V(vb(k)),
  $
  where the Fourier transform $V(vb(k))$ is given by
  $
    V(vb(k)) = (4 pi e^2) / k^2.
  $
]

#solution[
  Assume that the Coulomb potential has the Fourier representation
  $
    phi.alt(vb(r))
    = integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r)) phi.alt(vb(k)),
  $
  Applying $-laplacian$ gives
  $
    -laplacian phi.alt(vb(r))
    = integral dd(k, 3) / (2 pi)^3 (-laplacian e^(i vb(k) dot vb(r))) phi.alt(vb(k))
    = integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r)) k^2 phi.alt(vb(k)),
  $
  since
  $
    -laplacian e^(i vb(k) dot vb(r)) = k^2 e^(i vb(k) dot vb(r)).
  $
  On the other hand, Poisson's equation implies
  $
    -laplacian phi.alt(vb(r))
    = -4 pi e delta(vb(r))
    = -4 pi e integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r)),
  $
  Comparing the Fourier coefficients of $e^(i vb(k) dot vb(r))$ gives
  $
    k^2 phi.alt(vb(k)) = -4 pi e,
  $
  hence
  $
    phi.alt(vb(k)) = - (4 pi e) / k^2.
  $
  Therefore
  $
    V(vb(k)) = -e phi.alt(vb(k)) = (4 pi e^2) / k^2.
  $
  Thus
  $
    V(vb(r))
    = integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r)) V(vb(k)),
  $
  with
  $
    V(vb(k)) = (4 pi e^2) / k^2.
  $
]

== b)

#statement[
  Show that the Fourier transform of the screened Coulomb interaction $V_s (vb(r)) = (e^2 \/ r) e^(-k_"TF" r)$ is
  $
    V_s (vb(k)) = (4 pi e^2) / (k^2 + k_"TF"^2),
  $
  by substituting this expression into the Fourier integral
  $
    V_s (vb(r)) = integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r)) V_s (vb(k)),
  $
  and evaluating that integral in spherical coordinates (_Hint:_ The radial integral is best done as a contour integral.). Finally, deduce that $V_s (vb(r))$ satisfies
  $
    (-laplacian + k_"TF"^2) V_s (vb(r)) = 4 pi e^2 delta(vb(r)).
  $
]

#solution[
  Following the hint, we substitute the Fourier transform of the screened Coulomb interaction into the Fourier integral:
  $
    V_s (vb(r)) & = integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r)) V_s (vb(k)) \
                & = integral dd(k, 3) / (2 pi)^3 e^(i vb(k) dot vb(r)) (4 pi e^2) / (k^2 + k_"TF"^2),
  $
  and pass to spherical coordinates:
  $
    V_s (vb(r)) &= integral (k^2 sin theta dd(k) dd(theta) dd(phi)) / (2 pi)^3 e^(i k r cos theta) (4 pi e^2) / (k^2 + k_"TF"^2) \
    &= integral (k^2 sin theta dd(k) dd(theta)) / (2 pi)^2 e^(i k r cos theta) (4 pi e^2) / (k^2 + k_"TF"^2).
  $
  Since
  $
    dv(, theta) e^(i k r cos theta) = -e^(i k r cos theta) i k r sin theta
  $
  we can write
  $
    V_s (vb(r)) & = integral (k dd(k) dd(theta)) / (2 pi)^2 (dv(, theta) e^(i k r cos theta)) 1/(-i r) (4 pi e^2) / (k^2 + k_"TF"^2)
  $
  and then carry out the $theta$-integral:
  $
    integral_0^pi dd(theta) (dv(, theta) e^(i k r cos theta)) = e^(i k r cos pi) - e^(i k r cos 0) = e^(-i k r) - e^(i k r) = -2 i sin(k r),
  $
  yielding
  $
    V_s (vb(r)) & = (2e^2)/(pi r) integral_0^infinity dd(k) (k sin(k r)) / (k^2 + k_"TF"^2).
  $
  This integrand is an even function in $k$, so we can extend it to the whole real axis and write
  $
    V_s (vb(r)) & = (e^2)/(pi r) integral_(-infinity)^infinity dd(k) (k sin(k r)) / (k^2 + k_"TF"^2).
  $
  To evaluate the radial integral by contour integration, we instead consider
  $
    I(r) = (e^2)/(pi r) integral_(-infinity)^infinity dd(k) (k e^(i k r)) / (k^2 + k_"TF"^2),
  $
  so that $V_s (vb(r)) = "Im" I(r)$.

  The integrand of $I(r)$ has poles at $k = plus.minus i k_"TF"$. For $r > 0$, the factor $e^(i k r)$ decays exponentially in the upper half-plane, so we close the contour there and compute the residue
  $
    "Res"_(k = i k_"TF") (k e^(i k r)) / (k^2 + k_"TF"^2) = lim_(k arrow.r i k_"TF") (k - i k_"TF") (k e^(i k r)) / ((k - i k_"TF")(k + i k_"TF")) = (i k_"TF" e^(-k_"TF" r)) / (2 i k_"TF") = 1/2 e^(-k_"TF" r).
  $
  This gives
  $
    I(r) & = (e^2)/(pi r) 2 pi i "Res"_(k = i k_"TF") (k e^(i k r)) / (k^2 + k_"TF"^2) = (e^2)/(r) i e^(-k_"TF" r)
  $
  and therefore
  $
    V_s (vb(r)) = "Im" I(r) = (e^2) / r e^(-k_"TF" r)
  $

  For the second part, we proceed exactly as in part a) and write the differential equation
  $
    (-laplacian + k_"TF"^2) V_s (vb(r)) = 4 pi e^2 delta(vb(r))
  $
  in Fourier space as
  $
    (k^2 + k_"TF"^2) V_s (vb(k)) = 4 pi e^2
  $
  which is indeed satisfied by
  $
    V_s (vb(k)) = (4 pi e^2) / (k^2 + k_"TF"^2).
  $
]
