#import "../exercise-style.typ": *
#import "./ex1-figures.typ": *

#show heading.where(level: 1): render-major-heading
#show heading.where(level: 2): render-part-heading

#sheet-header(
  [QFT for Many-Body Systems],
  [1#super[st] Exercise Sheet Solutions],
  date: [Sommersemester 2026],
)

#tutorium_note[TUTORIUM: Friday, 20.03.2026.]

= Getting Familiar with the Density of States

#statement[
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
]

==

#statement[
  Consider the two cases of particles which can move freely and particles whose motion is bound to an infinite lattice with lattice spacing $a$. Which of the above expressions do you have to use in the first and second case, respectively? Is the integral/summation restricted to certain $vb(k)$-vectors? How does the result change, if one considers a one-dimensional, finite lattice ($N$ lattice points, lattice spacing $a$) with periodic boundary conditions?
]

#solution[
  Freely moving particles can have arbitrary momenta, so one integrates over all of momentum space
  $
    cal(N)(epsilon) = 1 / (2 pi)^d integral_(RR^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k))).
  $
  Particles bound to an infinite lattice with lattice spacing $a$ can only have momenta within the first Brillouin zone
  $
    cal(N)(epsilon) = 1 / (2 pi)^d integral_([-pi/a, pi/a]^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k))).
  $
  Finally, for a one-dimensional finite lattice of length $L = N a$ with periodic boundary conditions, the sum runs over a discrete set of allowed momenta satisfying
  $
    ee^(ii k L) = 1,
  $
  i.e. over the $N$ distinct momenta
  $
    K = {k in [-pi/a, pi/a) | ee^(ii k N a) = 1}.
  $
  Keeping the DOS normalized per unit length, one obtains
  $
    cal(N)(epsilon) = 1 / L sum_(k in K) delta(epsilon - epsilon_k) = 1 / (N a) sum_(k in K) delta(epsilon - epsilon_k).
  $
  If one instead wants the DOS per lattice site, this is simply multiplied by $a$
  $
    cal(N)_"site" (epsilon) = 1 / N sum_(k in K) delta(epsilon - epsilon_k).
  $
]

==

#statement[
  Calculate and plot the explicit expression for $cal(N)(epsilon)$ for free, non-interacting particles of mass $m$ (so that $epsilon_(vb(k)) = frac(hbar^2 k^2, 2 m)$) in one, two and three dimensions. How do the corresponding Fermi surfaces look like in these cases?
]

#solution[
  $
    cal(N)(epsilon) = 1 / (2 pi)^d integral_(RR^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k))),
  $
  with $epsilon_(vb(k)) = frac(hbar^2 k^2, 2 m)$.
  Since $epsilon_(vb(k)) = frac(hbar^2 k^2, 2 m) >= 0$, there are no states at negative energy, so the formulas below are understood to vanish for $epsilon < 0$.
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

  #two_panel(
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
    [#continuum_dos_plot()],
  )
  At $epsilon = epsilon_"F"$, these constant-energy shells become the Fermi surfaces: two points in $d = 1$, a circle in $d = 2$, and a sphere in $d = 3$.
]

==

#statement[
  Consider the following one-dimensional tight-binding Hamiltonian
  $
    H = -t sum_(chevron.l i, j chevron.r, sigma) (c^dagger_(i, sigma) c_(j, sigma) + "h.c.").
  $
  Here the hopping ($t > 0$) is restricted to neighboring sites, where $c^dagger_(i, sigma)$ and $c_(i, sigma)$ are the creation/annihilation operators for one electron with spin $sigma = arrow.t, arrow.b$ at the position $x_i = i a$ with $i = 0, 1, ..., N - 1$ and $a$ being the lattice spacing. Assuming periodic boundary conditions ($x_0 = x_N$), compute the corresponding eigenenergies, e.g. using the following basis transformation (from real to momentum space)
  $
    c^dagger_(k, sigma) = 1 / sqrt(N) sum_(x_i) ee^(-ii k x_i) c^dagger_(i, sigma),
  $
  for the fermionic operators.
]

#solution[
  We start from the given basis transformation
  $
    c^dagger_(k, sigma) = 1 / sqrt(N) sum_(x_i) ee^(-ii k x_i) c^dagger_(i, sigma)
  $
  and invert it to express the real-space operators in terms of momentum-space operators
  $
    c^dagger_(i, sigma) & = 1 / sqrt(N) sum_(k in K) ee^(ii k x_i) c^dagger_(k, sigma) \
           c_(i, sigma) & = 1 / sqrt(N) sum_(k in K) ee^(-ii k x_i) c_(k, sigma).
  $
  For periodic boundary conditions, the allowed momenta satisfy
  $
    ee^(ii k N a) = 1,
  $
  i.e.
  $
    k = frac(2 pi, N a) n, quad n in ZZ,
  $
  taken modulo the reciprocal lattice vector $2 pi / a$. Choosing one representative from each equivalence class inside the first Brillouin zone gives the $N$ allowed momenta collected in the set
  $
    K = {k in [-pi/a, pi/a) | ee^(ii k N a) = 1}.
  $
  With this discrete set of momenta, the finite geometric sum in the Hamiltonian becomes the Kronecker delta appearing below.
  Since $sum_(chevron.l i, j chevron.r)$ counts each nearest-neighbor bond once, in one dimension we may write it as a sum over $j$ with the neighbor $j+1$ understood modulo $N$.
  Substituting this into the Hamiltonian, we obtain (here $j+1$ is understood modulo $N$ because of the periodic boundary conditions)
  $
    H &= -t sum_(j, sigma) (c^dagger_(j, sigma) c_(j+1, sigma) + "h.c.") \
    &= -t sum_(j, sigma) (1 / sqrt(N) sum_(k in K) ee^(ii k x_j) c^dagger_(k, sigma) 1 / sqrt(N) sum_(k' in K) ee^(-ii k' x_(j+1)) c_(k', sigma) + "h.c.") \
    &= -t 1/N sum_(k in K, k' in K) sum_(j, sigma) (e^(ii k j a - ii k' (j+1) a) c^dagger_(k, sigma) c_(k', sigma) + "h.c."),
  $
  Using the identity
  $
    1/N sum_j ee^(ii k j a - ii k' (j+1) a) = ee^(-ii k' a) 1/N sum_j ee^(ii j a (k - k')) = ee^(-ii k' a) delta_(k, k'),
  $
  we find
  $
    H & = -t sum_(k in K, k' in K) sum_(sigma) (ee^(-ii k' a) delta_(k,k') c^dagger_(k, sigma) c_(k', sigma) + "h.c.") \
    & = -t sum_(k in K, sigma) (ee^(-ii k a) c^dagger_(k, sigma) c_(k, sigma) + "h.c.") \
    & = -t sum_(k in K, sigma) (ee^(-ii k a) c^dagger_(k, sigma) c_(k, sigma) + ee^(ii k a) c^dagger_(k, sigma) c_(k, sigma)) \
    & = sum_(k in K, sigma) epsilon_k c^dagger_(k, sigma) c_(k, sigma)
  $
  Thus the eigenenergies are
  $
    epsilon_k = -2 t cos(k a)
  $
  and the corresponding eigenstates are
  $
    lr(|(k, sigma) chevron.r) = c^dagger_(k, sigma) lr(|0 chevron.r).
  $
]

==

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
  obtained by applying the same Fourier transform as in 1c) independently in each lattice direction.
  The density of states is therefore
  $
    cal(N)_d (epsilon)
    = 1/(2 pi)^d
    integral_([-pi / a, pi / a]^d) dd(k, [d]) delta(epsilon - epsilon_(vb(k))),
  $
  For $hbar = m = t = a = 1$, the band runs from $-2d$ to $2d$.

  - $d = 1$: evaluating the delta function at the two roots of $epsilon + 2 cos(k) = 0$ gives
    $
      cal(N)_1(epsilon) = cases(
        1/(pi sqrt(4 - epsilon^2)) & "if" abs(epsilon) < 2,
        0 & "if" abs(epsilon) > 2
      ),
    $
    so the DOS diverges at the band edges $epsilon = plus.minus 2$.

  - $d = 2$: the square-lattice DOS can be reduced to a complete elliptic integral. In the parameter convention
    $
      K(m) = integral_0^(pi/2) frac(dd(phi), sqrt(1 - m sin^2(phi))),
    $
    one finds
    $
      cal(N)_2(epsilon) = cases(
        1/(2 pi^2) K(1 - epsilon^2 / 16) & "if" abs(epsilon) < 4,
        0 & "if" abs(epsilon) > 4
      ),
    $
    with a logarithmic van Hove singularity at $epsilon = 0$ and the finite band-edge value $cal(N)_2(plus.minus 4) = 1/(4 pi)$.

  - $d = 3$: for the cubic lattice it is convenient to evaluate the DOS numerically via the convolution
    $
      cal(N)_3(epsilon)
      = 1/(2 pi) integral_(-pi)^pi dd(k_z) cal(N)_2(epsilon + 2 cos(k_z)),
    $
    so $cal(N)_3(epsilon) = 0$ for $abs(epsilon) > 6$. This DOS remains finite, but develops non-analytic kinks at $epsilon = plus.minus 2$.

  The plotted DOS data were generated with a Julia script: it uses the closed-form $d=1$ result, the elliptic-integral expression for $d=2$, and the $k_z$ integral above for $d=3$.

  #lattice_dos_plot()

  For one electron per site (half filling), exactly half of all available single-particle
  states are occupied. Since
  $
    epsilon_(vb(k)) = -2 sum_(i=1)^d cos(k_i),
  $
  is particle-hole symmetric on the bipartite hypercubic lattice, the spectrum is symmetric
  around $epsilon = 0$. Therefore at half filling the Fermi energy at $T = 0$ is
  $
    epsilon_"F" = 0.
  $
  #two_panel[
    The Fermi surface is defined by $epsilon_(vb(k)) = epsilon_"F"$, i.e.
    $
      -2 sum_(i=1)^d cos(k_i) = 0.
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
  ][
    #half_filled_fermi_surface_pair()
  ]
]

= Screened and Unscreened Coulomb Potentials

==

#statement[
  From the integral representation of the delta function,
  $
    delta(vb(r)) = integral dd(k, 3) / (2 pi)^3 ee^(ii vb(k) dot vb(r)),
  $
  and the fact that the Coulomb potential $phi.alt(vb(r)) = -e \/ r$ satisfies Poisson's equation,
  $
    -laplacian phi.alt(vb(r)) = -4 pi e delta(vb(r)),
  $
  show that the electronic pair potential, $V(vb(r)) = -e phi.alt(vb(r)) = e^2 \/ r$, can be written in the form
  $
    V(vb(r)) = integral dd(k, 3) / (2 pi)^3 ee^(ii vb(k) dot vb(r)) V(vb(k)),
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
    = integral dd(k, 3) / (2 pi)^3 ee^(ii vb(k) dot vb(r)) phi.alt(vb(k)),
  $
  Applying $-laplacian$ gives
  $
    -laplacian phi.alt(vb(r))
    = integral dd(k, 3) / (2 pi)^3 (-laplacian ee^(ii vb(k) dot vb(r))) phi.alt(vb(k))
    = integral dd(k, 3) / (2 pi)^3 ee^(ii vb(k) dot vb(r)) k^2 phi.alt(vb(k)),
  $
  since
  $
    -laplacian ee^(ii vb(k) dot vb(r)) = k^2 ee^(ii vb(k) dot vb(r)).
  $
  On the other hand, Poisson's equation implies
  $
    -laplacian phi.alt(vb(r))
    = -4 pi e delta(vb(r))
    = -4 pi e integral dd(k, 3) / (2 pi)^3 ee^(ii vb(k) dot vb(r)),
  $
  Comparing the Fourier coefficients of $ee^(ii vb(k) dot vb(r))$ gives
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
    = integral dd(k, 3) / (2 pi)^3 ee^(ii vb(k) dot vb(r)) V(vb(k)),
  $
  with
  $
    V(vb(k)) = (4 pi e^2) / k^2.
  $
]

==

#statement[
  Show that the Fourier transform of the screened Coulomb interaction $V_"s" (vb(r)) = (e^2 \/ r) ee^(-k_"TF" r)$ is
  $
    V_"s" (vb(k)) = (4 pi e^2) / (k^2 + k_"TF"^2),
  $
  by substituting this expression into the Fourier integral
  $
    V_"s" (vb(r)) = integral dd(k, 3) / (2 pi)^3 ee^(ii vb(k) dot vb(r)) V_"s" (vb(k)),
  $
  and evaluating that integral in spherical coordinates (_Hint:_ The radial integral is best done as a contour integral.). Finally, deduce that $V_"s" (vb(r))$ satisfies
  $
    (-laplacian + k_"TF"^2) V_"s" (vb(r)) = 4 pi e^2 delta(vb(r)).
  $
]

#solution[
  Following the hint, we substitute the Fourier transform of the screened Coulomb interaction into the Fourier integral
  $
    V_"s" (vb(r)) = integral dd(k, 3) / (2 pi)^3 ee^(ii vb(k) dot vb(r)) V_"s" (vb(k)) = integral dd(k, 3) / (2 pi)^3 ee^(ii vb(k) dot vb(r)) (4 pi e^2) / (k^2 + k_"TF"^2),
  $
  and pass to spherical coordinates
  $
    V_"s" (vb(r)) = integral (k^2 sin theta dd(k) dd(theta) dd(phi)) / (2 pi)^3 ee^(ii k r cos theta) (4 pi e^2) / (k^2 + k_"TF"^2),
  $
  where we first carry out the trivial $phi$-integral, yielding a factor of $2 pi$,
  $
    V_"s" (vb(r)) = integral (k^2 sin theta dd(k) dd(theta)) / (2 pi)^2 ee^(ii k r cos theta) (4 pi e^2) / (k^2 + k_"TF"^2).
  $
  Since
  $
    dv(, theta) ee^(ii k r cos theta) = -ee^(ii k r cos theta) ii k r sin theta
  $
  we can write
  $
    V_"s" (vb(r)) & = integral (k dd(k) dd(theta)) / (2 pi)^2 (dv(, theta) ee^(ii k r cos theta)) 1/(-ii r) (4 pi e^2) / (k^2 + k_"TF"^2)
  $
  and then carry out the $theta$-integral:
  $
    integral_0^pi dd(theta) (dv(, theta) ee^(ii k r cos theta)) = ee^(ii k r cos pi) - ee^(ii k r cos 0) = ee^(-ii k r) - ee^(ii k r) = -2 ii sin(k r),
  $
  yielding
  $
    V_"s" (vb(r)) & = (2e^2)/(pi r) integral_0^infinity dd(k) (k sin(k r)) / (k^2 + k_"TF"^2).
  $
  This integrand is an even function in $k$, so we can extend it to the whole real axis and write
  $
    V_"s" (vb(r)) & = (e^2)/(pi r) integral_(-infinity)^infinity dd(k) (k sin(k r)) / (k^2 + k_"TF"^2).
  $
  To evaluate the radial integral by contour integration, we instead consider
  $
    I(r) = (e^2)/(pi r) integral_(-infinity)^infinity dd(k) (k ee^(ii k r)) / (k^2 + k_"TF"^2),
  $
  so that $V_"s" (vb(r)) = im I(r)$.

  The integrand of $I(r)$ has poles at $k = plus.minus ii k_"TF"$. For $r > 0$, the factor $ee^(ii k r)$ decays exponentially in the upper half-plane, so we close the contour there and compute the residue
  $
    op("Res", limits: #true)_(k = ii k_"TF") (k ee^(ii k r)) / (k^2 + k_"TF"^2) = lim_(k arrow.r ii k_"TF") (k - ii k_"TF") (k ee^(ii k r)) / ((k - ii k_"TF")(k + ii k_"TF")) = (ii k_"TF" ee^(-k_"TF" r)) / (2 ii k_"TF") = 1/2 ee^(-k_"TF" r).
  $
  This gives
  $
    I(r) & = (e^2)/(pi r) 2 pi ii op("Res", limits: #true)_(k = ii k_"TF") (k ee^(ii k r)) / (k^2 + k_"TF"^2) = (e^2)/(r) ii ee^(-k_"TF" r)
  $
  and therefore
  $
    V_"s" (vb(r)) = im I(r) = (e^2) / r e^(-k_"TF" r)
  $

  For the second part, we proceed exactly as in part a) and write the differential equation
  $
    (-laplacian + k_"TF"^2) V_"s" (vb(r)) = 4 pi e^2 delta(vb(r))
  $
  in Fourier space as
  $
    (k^2 + k_"TF"^2) V_"s" (vb(k)) = 4 pi e^2
  $
  which is indeed satisfied by
  $
    V_"s" (vb(k)) = (4 pi e^2) / (k^2 + k_"TF"^2).
  $
]
