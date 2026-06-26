#import "../exercise-style.typ": *
#import "@preview/unify:0.7.1": num, numrange, qty, qtyrange
#import "@preview/simple-plot:0.9.0": *
#import "@preview/cetz:0.5.2": canvas, draw

#show: exercise-sheet.with(
  "QFT for Many-Body Systems",
  6,
  author: "Samuel Badr",
  semester: "Sommersemester 2026",
  tutorial: "TUTORIUM: Friday, 26.06.2026.",
  title-suffix: "Exercise Sheet",
)

#let start = 12
#counter(heading).update(start - 1)

#set math.equation(numbering: "(1)")

Consider the Hubbard-Hamiltonian given by

$
  hat(H)
  = sum_(vb(k) sigma) epsilon_vb(k) hat(c)_(vb(k) sigma)^dagger hat(c)_(vb(k) sigma)
  + U sum_i underbrace(hat(c)_(i arrow.t)^dagger hat(c)_(i arrow.t), hat(n)_(i arrow.t))
  underbrace(hat(c)_(i arrow.b)^dagger hat(c)_(i arrow.b), hat(n)_(i arrow.b))
  - mu sum_i underbrace((n_(i arrow.t) + n_(i arrow.b)), hat(n)_i).
$ <eq:hubbard>

The term containing $mu$ fixes the number of particles.
Specifically, we consider the case of half-filling where we have $expval(hat(n)_i) = 1$ particle per site.
This corresponds to $mu = U / 2$.

= The Green's function in limiting cases

#problem[
  First, assume that the electrons governed by the Hamiltonian in @eq:hubbard are non-interacting, i.e., $U = 0$.
]

==

#problem[
  Compute the one-particle Green's function $G_sigma (vb(k), tau)$ by directly calculating the trace in the definition

  $
    G_sigma (vb(k), tau)
    = -1 / Z tr [
      ee^(-beta hat(H))
      hat(c)_(vb(k) sigma) (tau) hat(c)_(vb(k) sigma)^dagger
    ],
    quad beta >= tau >= 0,
  $ <eq:g-tau>

  of the Green's function.
  The partition function is defined as $Z = tr[ee^(-beta hat(H))]$.

  _Hint: Use the Lehmann representation, i.e. perform the trace over the basis of the eigenvalues and insert the completeness relation, where needed._
]

#solution[
  The noninteracting $U = 0$ Hamiltonian
  $
    H = sum_(vb(k) sigma) xi_vb(k) c_(vb(k) sigma)^dagger c_(vb(k) sigma) wide xi_vb(k) = epsilon_vb(k) - mu
  $
  has eigenstates
  $
    ket({n_(vb(k) sigma)}) wide n_(vb(k) sigma) in {0, 1}
  $
  with eigenenergies
  $
    E_({n}) = sum_(vb(k) sigma) xi_(vb(k)) n_(vb(k) sigma).
  $

  The partition function is then given by
  $
    Z & = sum_({n}) ee^(-beta E_({n})) = product_(vb(k) sigma) sum_(n_(vb(k) sigma) = 0)^1 ee^(-beta xi_(vb(k)) n_(vb(k) sigma)) = product_(vb(k) sigma) (1 + ee^(-beta xi_vb(k))).
  $

  Green's function:
  $
    G_sigma (vb(k), tau) & = -1 / Z sum_({n}) expval(
                             ee^(-beta H)
                             c_(vb(k) sigma) (tau) c_(vb(k) sigma)^dagger,
                             {n}
                           )
  $
  Because $ket({n})$ is an eigenstate of $H$,
  $
    G_sigma (vb(k), tau) & = -1 / Z sum_({n}) ee^(-beta E_({n})) expval(
                             c_(vb(k) sigma) (tau) c_(vb(k) sigma)^dagger,
                             {n}
                           ).
  $
  Inserting a resolution of unity
  $
    1 = sum_({m}) ketbra({m})
  $
  we get
  $
    G_sigma (vb(k), tau) & = -1 / Z sum_({n},{m})
                           ee^(-beta E_({n}))
                           mel({n}, c_(vb(k) sigma) (tau), {m})
                           mel({m}, c_(vb(k) sigma)^dagger, {n}).
  $
  Using
  $
    c_(vb(k) sigma) (tau) = ee^(tau H) c_(vb(k) sigma) ee^(-tau H),
  $
  the matrix element becomes
  $
    mel({n}, c_(vb(k) sigma) (tau), {m}) = ee^(tau (E_({n}) - E_({m}))) mel({n}, c_(vb(k) sigma), {m})
  $
  Therefore
  $
    G_sigma (vb(k), tau) & = -1 / Z sum_({n},{m})
                           ee^(-beta E_({n})) ee^(tau (E_({n}) - E_({m})))
                           mel({n}, c_(vb(k) sigma), {m})
                           mel({m}, c_(vb(k) sigma)^dagger, {n}).
  $<eq:lehmann>
  Now the matrix elements are only nonzero if
  $
    n_(vb(k) sigma) = 0 quad "and" quad m_(vb(k) sigma) = 1 quad "and" n_(vb(k') sigma') = m_(vb(k') sigma') "for all" vb(k') sigma' != vb(k) sigma
  $
  so we can conclude
  $
    E_({m}) = E_({n}) + xi_(vb(k))
  $
  and the product of matrix elements gives 1, so
  $
    G_sigma (vb(k), tau) & = -1 / Z sum_({n}, n_(vb(k) sigma) = 0)
                           ee^(-beta E_({n})) ee^(-tau xi_(vb(k))).
  $
  We can perform the sum
  $
    sum_({n}, n_(vb(k) sigma) = 0) ee^(-beta E_({n})) = product_(vb(k') sigma' != vb(k) sigma) sum_(n_(vb(k') sigma') = 0)^1 ee^(-beta xi_(vb(k')) n_(vb(k') sigma')) = product_(vb(k') sigma' != vb(k) sigma) (1 + ee^(-beta xi_vb(k')))
  $
  and then get
  $
    G_sigma (vb(k), tau) & = -ee^(-tau xi_(vb(k))) (product_(vb(k') sigma' != vb(k) sigma) (1 + ee^(-beta xi_vb(k')))) / (product_(vb(k') sigma') (1 + ee^(-beta xi_vb(k'))))
  $
  and are able to cancel common factors
  $
    G_sigma (vb(k), tau) & = -ee^(-tau xi_(vb(k))) / (1 + ee^(-beta xi_vb(k))) = -ee^(-tau xi_(vb(k))) [1 - n_"F" (xi_(vb(k)))].
  $

  #let t = 1.0
  #let mu = 0.0
  #let epsilon(k) = -2 * t * calc.cos(k)
  #let xi(k) = epsilon(k) - mu

  #let k1 = 0.0
  #let k2 = calc.pi / 2
  #let k3 = calc.pi

  #align(center)[
    #plot(
      width: 6,
      height: 4,
      xmin: -0.1,
      xmax: 1.1,
      ymin: -1.0,
      ymax: 0.1,
      axis-x-extend: 0.1,
      axis-y-extend: 0.1,
      show-grid: "none",
      xlabel: $frac(tau, beta, style: "horizontal")$,
      ylabel: $G_(sigma) (vb(k), tau)$,

      (
        fn: tau => -calc.exp(-tau * xi(k1)) / (1 + calc.exp(-xi(k1))),
        domain: (0, 1),
        label: $k = 0$,
        stroke: red,
      ),
      (
        fn: tau => -calc.exp(-tau * xi(k2)) / (1 + calc.exp(-xi(k2))),
        domain: (0, 1),
        label: $k = pi / 2$,
        stroke: green,
      ),
      (
        fn: tau => -calc.exp(-tau * xi(k3)) / (1 + calc.exp(-xi(k3))),
        domain: (0, 1),
        label: $k = pi$,
        stroke: blue,
      ),
    )
  ]
]

==

#problem[
  Continue the result obtained above for $G_sigma (vb(k), tau)$ to real times by the inverse Wick-rotation $tau -> ii t$.
  Give a physical interpretation for the result.
]

#solution[
  From the imaginary-time result for $0 < tau < beta$,

  $
    G_sigma (vb(k), tau)
    =
    -ee^(-tau xi_(vb(k))) / (1 + ee^(-beta xi_(vb(k))))
    =
    -ee^(-tau xi_(vb(k))) [1 - n_"F" (xi_(vb(k)))].
  $

  Performing the inverse Wick rotation $tau -> ii t$ gives

  $
    G_sigma (vb(k), t)
    =
    -ee^(-ii t xi_(vb(k))) / (1 + ee^(-beta xi_(vb(k))))
    =
    -ee^(-ii t xi_(vb(k))) [1 - n_"F" (xi_(vb(k)))].
  $

  This is the continuation of the positive imaginary-time branch. It
  corresponds to the propagation of an added particle in the state
  $(vb(k), sigma)$. The phase factor $ee^(-ii t xi_(vb(k)))$ describes
  free time evolution with energy measured relative to the chemical
  potential, while the factor $1 - n_"F" (xi_(vb(k)))$ is the probability
  that the state is initially empty and can therefore accept an added
  fermion.
]

==

#problem[
  Calculate the Green's function $G_sigma (vb(k), ii omega_n)$ in Matsubara frequency space by performing the Fourier-transform

  $
    G_sigma (vb(k), ii omega_n)
    = integral_0^beta dd(tau) ee^(ii omega_n tau) G_sigma (vb(k), tau),
  $ <eq:g-matsu>

  where $omega_n = pi / beta (2 n + 1)$, $n in ZZ$ is a fermionic Matsubara frequency.
  Then continue the results on the real frequency axis and calculate the corresponding spectral function $A(vb(k), omega)$.
]

#solution[
  We perform the Fourier transform
  $
    G_sigma (vb(k), ii omega_n)
    = integral_0^beta dd(tau) ee^(ii omega_n tau) G_sigma (vb(k), tau),
  $
  inserting the result from above
  $
    G_sigma (vb(k), ii omega_n) = - [1 - n_"F" (xi_(vb(k)))] integral_0^beta dd(tau) ee^(ii omega_n tau) ee^(-tau xi_(vb(k)))
  $
  to get
  $
    G_sigma (vb(k), ii omega_n) = 1 / (ii omega_n - xi_vb(k)).
  $

  More explicitly,
  $
    G_sigma (vb(k), ii omega_n)
    =
    -[1 - n_"F" (xi_vb(k))]
    integral_0^beta dd(tau)
    ee^((ii omega_n - xi_vb(k)) tau).
  $
  Hence
  $
    G_sigma (vb(k), ii omega_n)
    =
    -[1 - n_"F" (xi_vb(k))]
    (ee^((ii omega_n - xi_vb(k)) beta) - 1)
    / (ii omega_n - xi_vb(k)).
  $
  Since $omega_n$ is fermionic,
  $
    ee^(ii omega_n beta) = -1,
  $
  and therefore
  $
    ee^((ii omega_n - xi_vb(k)) beta) - 1
    =
    - (1 + ee^(-beta xi_vb(k))).
  $
  Using
  $
    1 - n_"F" (xi_vb(k))
    =
    1 / (1 + ee^(-beta xi_vb(k))),
  $
  the thermal factors cancel and one obtains
  $
    G_sigma (vb(k), ii omega_n)
    =
    1 / (ii omega_n - xi_vb(k)).
  $

  To continue the results, we set $ii omega_n -> omega + ii 0^+$ and get
  $
    G_sigma (vb(k), omega) = 1 / (omega - xi_vb(k) + ii 0^+)
  $
  as well as the spectral function
  $
    A(vb(k), omega) = - 1 / pi Im G_sigma (vb(k), omega) = delta(omega - xi_vb(k)).
  $
]

==

#problem[
  Now, consider the opposite limit where the kinetic energy appearing in the Hamiltonian in @eq:hubbard is negligible compared to the interaction, i.e., $epsilon_vb(k) = 0$ (atomic limit).
]

#solution[
  In the atomic limit, the Hamiltonian is reduced to
  $
    H = sum_i H_i
  $
  with
  $
    H_i = U n_(i arrow.t) n_(i arrow.b) - mu (n_(i arrow.t) + n_(i arrow.b))
  $
  and we work at half filling $mu = U / 2$.

  So it suffices to work in the local site $i$ (the label of which we'll omit), where we write down the Fock basis
  $
    ket(0) wide ket(arrow.t) wide ket(arrow.b) wide ket(arrow.t arrow.b) = c_arrow.t^dagger c_arrow.b^dagger ket(0)
  $
  which is already an eigenbasis with eigenvalues
  $
    0 wide -U/2 wide -U/2 wide 0.
  $

  Since the atoms are independent, the full problem factorizes into identical single-site problems.
]

==

#problem[
  The local Green's function for site $i$, $G_(i sigma) (tau)$, is defined as

  $
    G_(i sigma) (tau)
    = - expval(T_tau hat(c)_(i sigma) (tau) hat(c)_(i sigma)^dagger)
    = -1 / Z tr [
      ee^(-beta hat(H))
      hat(c)_(i sigma) (tau) hat(c)_(i sigma)^dagger
    ],
    quad beta >= tau >= 0.
  $ <eq:g-local>

  Note that the different atoms are completely independent in this case and the local Green's function is thus the same as already calculated in Problem 6 of Exercise 3.
  From its Fourier transform $G_(i sigma) (ii omega_n)$, extract the corresponding expression for the self-energy $Sigma_(i sigma) (ii omega_n)$.
  Is the atomic-limit expression derivable within conventional perturbation theory?
]

#solution[
  We first compute the partition function
  $
    Z = sum_n expval(ee^(-beta H), n) = 2 (1 + ee^(frac(beta U, 2, style: "horizontal")))
  $
  and then the Green's function.
  To that end, we start from @eq:lehmann, which we restate here in adapted form for convenience
  $
    G_sigma (tau) & = -1 / Z sum_(n,m)
                    ee^(-beta E_(n)) ee^(tau (E_(n) - E_(m)))
                    mel(n, c_(sigma), m)
                    mel(m, c_(sigma)^dagger, n).
  $
  and compute the nonzero matrix-elements
  $
                      mel(0, c_sigma, sigma) & = 1 wide  &                   mel(sigma, c_sigma^dagger, 0) & = 1 \
    mel(arrow.b, c_arrow.t, arrow.t arrow.b) & = 1 wide  & mel(arrow.t arrow.b, c_arrow.t^dagger, arrow.b) & = 1 \
    mel(arrow.t, c_arrow.b, arrow.t arrow.b) & = -1 wide & mel(arrow.t arrow.b, c_arrow.b^dagger, arrow.t) & = -1,
  $
  implying for either spin
  $
    G_sigma (tau) &= -1 / Z (ee^(frac(tau U, 2, style: "horizontal")) + ee^(frac(beta U, 2, style: "horizontal")) ee^(frac(-tau U, 2, style: "horizontal"))) = - 1/2 (ee^(frac(tau U, 2, style: "horizontal")) + ee^(frac((beta - tau) U, 2, style: "horizontal"))) / (1 + ee^(frac(beta U, 2, style: "horizontal"))).
  $
  and defining
  $
    f = n_"F" (U / 2) = [1 + ee^(frac(beta U, 2, style: "horizontal"))]^(-1)
  $
  we can write
  $
    G_sigma (tau) = -1/2 [f ee^(frac(tau U, 2, style: "horizontal")) + (1 - f) ee^(frac(-tau U, 2, style: "horizontal"))].
  $

  // - Continuing to real times $tau -> ii t$ yields
  //   $
  //     G_sigma (t) = -1/2 [f ee^(frac(ii t U, 2, style: "horizontal")) + (1 - f) ee^(frac(-ii t U, 2, style: "horizontal"))].
  //   $
  //   This is a superposition of two oscillations, both with frequency $U/2$,
  //   $
  //     ket(0) <-> ket(sigma),
  //   $
  //   weighted $f$ and
  //   $
  //     ket(-sigma) <-> ket(arrow.t arrow.b),
  //   $
  //   weighted $1 - f$.

  Fourier transforming yields
  $
    G_sigma (ii omega_n) = 1 / 2 [1 / (ii omega_n + U/2) + 1 / (ii omega_n - U/2)] = (ii omega_n) / ((ii omega_n)^2 - U^2 / 4)
  $
  and thus a self-energy of
  $
    Sigma_sigma (ii omega_n) = 1 / (G_(0sigma) (ii omega_n)) - 1 / (G_(sigma) (ii omega_n)) = U / 2 + U^2 / (4 ii omega_n).
  $
  because
  $
    G_(0sigma) (ii omega_n) = 1 / (ii omega_n + mu).
  $

  // - Continuing to the real frequency axis then gives
  //   $
  //     G_sigma (omega) = 1 / 2 [1 / (omega + U/2 + ii 0^+) + 1 / (omega - U/2 + ii 0^+)]
  //   $
  //   and
  //   $
  //     A_sigma (omega) = 1 / 2 [delta(omega + U/2) + delta(omega - U/2)].
  //   $

  // #text(fill: red, size: 14pt)[Important: Answer last question!]

  The self-energy contains a pole at zero Matsubara frequency,
  $
    Sigma_sigma (ii omega_n)
    =
    U / 2 + U^2 / (4 ii omega_n).
  $
  This pole is the atomic-limit signature of the splitting into lower and
  upper Hubbard levels. It is singular at $ii omega_n = 0$ and therefore
  cannot be obtained from conventional regular perturbation theory around the
  non-interacting limit. In ordinary weak-coupling perturbation theory one
  expands in powers of $U$ at fixed non-interacting propagator, whereas the
  atomic limit is controlled by the local interaction and already contains the
  non-perturbative separation of the spectrum into two Hubbard peaks.
]

==

#problem[
  Calculate, analogously as above, the local magnetic (spin) $chi^"s"_i (tau) = expval(T_tau S^z_i (tau) S^z_i)$ and density (charge) $chi^"c"_i (tau) = expval(T_tau n_i (tau) n_i)$ susceptibilities in the atomic limit of the Hubbard model (with $S^z_i = n_(i arrow.t) - n_(i arrow.b)$ and $n_i = n_(i arrow.t) + n_(i arrow.b)$), as well as their Fourier transform to Matsubara frequencies.
  Then, analytically continue the expressions to real frequencies.
  What can you say about the temperature dependence?
]

#solution[
  We observe, again omitting the site label $i$, that both spin and charge operators commute with the Hamiltonian
  $
    [S^z, H] = 0 = [n, H]
  $
  because $[n_sigma, n_(sigma')] = 0$ and so both susceptibilities lose their imaginary time dependence and become simple thermal averages
  $
    chi^"s" & = expval((S^z)^2) \
    chi^"c" & = expval(n^2).
  $

  We start by writing for the local magnetic (spin) susceptibility
  $
    chi^"s" = 1 / Z sum_m ee^(-beta E_m) expval(S^z S^z, m)
  $
  and expand out
  $
    (S^z)^2 = n_arrow.t^2 - 2 n_arrow.t n_arrow.b + n_arrow.b^2
  $
  to find
  $
                  expval((S^z)^2, 0) & = 0 \
            expval((S^z)^2, arrow.t) & = 1 \
            expval((S^z)^2, arrow.b) & = 1 \
    expval((S^z)^2, arrow.t arrow.b) & = 0
  $
  and thus
  $
    chi^"s" = 1 / Z 2 ee^(frac(beta U, 2, style: "horizontal")) = ee^(frac(beta U, 2, style: "horizontal")) / (1 + ee^(frac(beta U, 2, style: "horizontal"))) = 1 - f
  $
  with
  $
    f equiv n_"F" (U/2).
  $

  The local density (charge) susceptibility, on the other hand, is given by
  $
    chi^"c" = 1 / Z sum_m ee^(-beta E_m) expval(n n, m)
  $
  and we follow the same path as before
  $
    n^2 = n_arrow.t^2 + 2 n_arrow.t n_arrow.b + n_arrow.b^2
  $
  $
                  expval(n^2, 0) & = 0 \
            expval(n^2, arrow.t) & = 1 \
            expval(n^2, arrow.b) & = 1 \
    expval(n^2, arrow.t arrow.b) & = 4
  $
  to get
  $
    chi^"c" = 1 / Z (4 + 2 ee^(frac(beta U, 2, style: "horizontal"))) = (2 + ee^(frac(beta U, 2, style: "horizontal"))) / (1 + ee^(frac(beta U, 2, style: "horizontal"))) = 1 + f.
  $

  The Fourier transforms are then easy to compute
  $
    chi^"s" (ii omega_n) & = beta (1 - f) delta_(n, 0) \
    chi^"c" (ii omega_n) & = beta (1 + f) delta_(n, 0)
  $
  and continue
  $
    chi^"s" (omega) & = (1 - f) delta(omega) \
    chi^"c" (omega) & = (1 + f) delta(omega).
  $

  We can also compute the connected charge susceptibility
  $
    chi^"c"_"conn" (tau) equiv expval(T_tau n(tau) n(0)) - expval(n)^2 = f
  $
  and transform to Matsubara
  $
    chi^"c"_"conn" (ii omega_n) = beta f delta_(n, 0).
  $

  #align(center)[
    #plot(
      width: 6,
      height: 4,
      xmin: -0.1,
      xmax: 2.2,
      ymin: 0.0,
      ymax: 3.6,
      axis-x-extend: 0.1,
      axis-y-extend: 0.1,
      show-grid: "none",
      xlabel: $frac(T, U, style: "horizontal")$,
      ylabel: $chi(ii omega_0) U$,

      (
        fn: T => (1 - 1 / (calc.exp(1 / (2 * T)) + 1)) / T,
        domain: (0.0001, 2),
        label: $chi^"s"$,
        stroke: red,
      ),
      (
        fn: T => (1 + 1 / (calc.exp(1 / (2 * T)) + 1)) / T,
        domain: (0.0001, 2),
        label: $chi^"c"$,
        stroke: green,
      ),
      (
        fn: T => (1 / (calc.exp(1 / (2 * T)) + 1)) / T,
        domain: (0.0001, 2),
        label: $chi^"c"_"conn"$,
        label-pos: 0.0,
        stroke: blue,
      ),
      // hline(0.5, xmin: 0, xmax: 2, stroke: gray + 0.8pt),
      // note([$lim_(T -> infinity) chi^"s" = 1 / 2$], (0.0, 0.5), anchor: "east", size: 9pt),
      // hline(1.5, xmin: 0, xmax: 2, stroke: gray + 0.8pt),
      // note([$lim_(T -> infinity) chi^"c" = 3/2$], (0.0, 1.5), anchor: "east", size: 9pt),
    )
  ]
]

= RPA for the Hubbard model

In the Hubbard model (Hamiltonian in @eq:hubbard), the interaction is purely local and penalizes double occupations: $U sum_i n_(i arrow.t) n_(i arrow.b)$.
Therefore, the interaction only couples electrons with opposite spin.

Then also susceptibilities can acquire a spin-dependence: $chi_(sigma sigma')$.

Remembering that momentum, energy and spin need to be conserved at each vertex:

==

#problem[
  Draw the bubble diagram of the free susceptibility $chi_0^(sigma sigma') (vb(q), omega)$ and say which spin-combinations are possible.
]

#solution[
  #let chi0-bubble(
    left-spin: $sigma$,
    right-spin: $sigma'$,
    loop-spin: $s$,
    label: $chi_0^(sigma sigma')$,
  ) = cetz.canvas({
    import cetz.draw: *

    // Vertex positions
    let l = (-1.2, 0)
    let r = (1.2, 0)

    // Fermion loop: one continuous spin-conserving propagator loop.
    // The arrows indicate a consistent fermion-flow direction.
    bezier(l, r, (-0.75, 0.75), (0.75, 0.75), mark: (end: ">"))
    bezier(r, l, (0.75, -0.75), (-0.75, -0.75), mark: (end: ">"))

    // External density vertices. These conserve spin.
    circle(l, radius: 0.055, fill: black)
    circle(r, radius: 0.055, fill: black)

    // External momentum/frequency transfer
    // line((-2.0, 0), l, mark: (end: ">"))
    // line(r, (2.0, 0), mark: (end: ">"))
    content((-1.75, 0.0), $vb(q), omega$)
    content((1.75, 0.0), $vb(q), omega$)

    // Vertex spin labels: density n_sigma and n_sigma'
    content((-1.2, -0.35), $n_#left-spin$)
    content((1.2, -0.35), $n_#right-spin$)

    // Internal spin label: same spin around the whole loop
    content((0, 0.8), $G_0^#loop-spin$)
    content((0, -0.8), $G_0^#loop-spin$)

    // Object label
    // content((0, -1.15), label)
  })

  #align(center)[
    #chi0-bubble()
  ]

  The free susceptibility is diagonal in spin:
  $
    chi_0^(sigma sigma') (vb(q), omega)
    =
    delta_(sigma sigma') chi_0^sigma(vb(q), omega).
  $

  This is because the density vertices conserve spin, and the free propagators
  $G_0$ do not flip spin. Therefore the spin running around the bubble must be
  the same on both sides.

  Hence the only nonzero components are
  $
    chi_0^(arrow.t arrow.t)
    quad "and" quad
    chi_0^(arrow.b arrow.b),
  $
  while
  $
    chi_0^(arrow.t arrow.b)
    =
    chi_0^(arrow.b arrow.t)
    =
    0.
  $
]

==

#problem[
  Draw the random phase approximation (RPA) series for $chi_("RPA")^(arrow.t arrow.t)$ and $chi_("RPA")^(arrow.t arrow.b)$.
  What can you say about the allowed powers of $U$ in both series?
  Translate the diagrams into formulas and rewrite them using the geometric series.
  In all of this you can omit the labels for momentum and frequency.
]

#let rpa-bubble(
  x: 0,
  spin: $arrow.t$,
  left-label: none,
  right-label: none,
) = {
  import cetz.draw: *

  let l = (x - 0.55, 0)
  let r = (x + 0.55, 0)

  // Fermion loop: one conserved spin sector.
  bezier(l, r, (x - 0.35, 0.55), (x + 0.35, 0.55), mark: (end: ">"))
  bezier(r, l, (x + 0.35, -0.55), (x - 0.35, -0.55), mark: (end: ">"))

  // Density vertices
  circle(l, radius: 0.045, fill: black)
  circle(r, radius: 0.045, fill: black)

  // Internal spin label
  content((x, 0.72), $chi_0^#spin$)

  // Optional external spin-density labels
  if left-label != none {
    content((x - 0.55, -0.34), left-label)
  }

  if right-label != none {
    content((x + 0.55, -0.34), right-label)
  }
}

#let hubbard-U(x: 0) = {
  import cetz.draw: *

  // Hubbard vertex: U n_up n_down.
  // It connects opposite-spin density bubbles.
  // line((x, 0.40), (x, -0.40), stroke: (dash: "dashed"))
  content((x + 0.0, 0), $U$)
}

#let plus-sign(x: 0) = {
  import cetz.draw: *
  content((x, 0), $+$)
}

#let ellipsis(x: 0) = {
  import cetz.draw: *
  content((x, 0), $dots.c$)
}


#solution[
  The Hubbard interaction has the form
  $
    U n_(arrow.t) n_(arrow.b),
  $
  so every interaction vertex couples an $arrow.t$ density bubble to an
  $arrow.b$ density bubble. Thus the RPA chain alternates spin sectors.


  #align(center)[
    #cetz.canvas({
      import cetz.draw: *

      content((-4.05, 0), $chi_("RPA")^(arrow.t arrow.t) =$)

      // Zeroth-order term: chi_0^{up up}
      rpa-bubble(
        x: -2.55,
        spin: $arrow.t$,
        left-label: $n_(arrow.t)$,
        right-label: $n_(arrow.t)$,
      )

      plus-sign(x: -1.35)

      // Next allowed term:
      // up -- U -- down -- U -- up
      rpa-bubble(
        x: -0.45,
        spin: $arrow.t$,
        left-label: $n_(arrow.t)$,
      )

      hubbard-U(x: 0.30)

      rpa-bubble(
        x: 1.05,
        spin: $arrow.b$,
      )

      hubbard-U(x: 1.80)

      rpa-bubble(
        x: 2.55,
        spin: $arrow.t$,
        right-label: $n_(arrow.t)$,
      )

      plus-sign(x: 3.55)
      ellipsis(x: 3.95)
    })
  ]

  #v(1em)

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *

      content((-4.05, 0), $chi_("RPA")^(arrow.t arrow.b) =$)

      // First allowed term:
      // up -- U -- down
      rpa-bubble(
        x: -2.55,
        spin: $arrow.t$,
        left-label: $n_(arrow.t)$,
      )

      hubbard-U(x: -1.80)

      rpa-bubble(
        x: -1.05,
        spin: $arrow.b$,
        right-label: $n_(arrow.b)$,
      )

      plus-sign(x: 0.05)

      // Next allowed term:
      // up -- U -- down -- U -- up -- U -- down
      rpa-bubble(
        x: 0.95,
        spin: $arrow.t$,
        left-label: $n_(arrow.t)$,
      )

      hubbard-U(x: 1.70)

      rpa-bubble(
        x: 2.45,
        spin: $arrow.b$,
      )

      hubbard-U(x: 3.20)

      rpa-bubble(
        x: 3.95,
        spin: $arrow.t$,
      )

      hubbard-U(x: 4.70)

      rpa-bubble(
        x: 5.45,
        spin: $arrow.b$,
        right-label: $n_(arrow.b)$,
      )

      plus-sign(x: 6.45)
      ellipsis(x: 6.85)
    })
  ]

  The same-spin response contains an even number of Hubbard vertices:
  $
    chi_("RPA")^(arrow.t arrow.t)
    =
    chi_0^(arrow.t)
    +
    chi_0^(arrow.t) U chi_0^(arrow.b)
    U chi_0^(arrow.t)
    +
    dots.c
  $

  The opposite-spin response contains an odd number of Hubbard vertices:
  $
    chi_("RPA")^(arrow.t arrow.b)
    = -
    chi_0^(arrow.t) U chi_0^(arrow.b)
    -
    chi_0^(arrow.t) U chi_0^(arrow.b)
    U chi_0^(arrow.t) U chi_0^(arrow.b)
    -
    dots.c
  $

  We observe
  $
    chi_("RPA")^(arrow.t arrow.t) & = chi_0^(arrow.t) [1 - U chi_("RPA")^(arrow.b arrow.t)] \
    chi_("RPA")^(arrow.t arrow.b) & = -chi_0^(arrow.t) U chi_"RPA"^(arrow.b arrow.b),
  $
  and plug the second equation into the first
  $
    chi_("RPA")^(arrow.t arrow.t) & = chi_0^(arrow.t) [1 + U chi_0^(arrow.b) U chi_"RPA"^(arrow.t arrow.t)]
  $
  and solve to
  $
    chi_"RPA"^(arrow.t arrow.t) & = chi_0^(arrow.t) / (1 - U^2 chi_0^(arrow.t) chi_0^(arrow.b)).
  $
  For the other spin channel, we get
  $
    chi_("RPA")^(arrow.t arrow.b) & = -(U chi_0^(arrow.t) chi_0^(arrow.b)) / (1 - U^2 chi_0^(arrow.t) chi_0^(arrow.b)).
  $
]

==

#problem[
  The charge and spin susceptibilities (the local versions of which were already introduced above) are given by

  $
    chi^"c" = chi^(arrow.t arrow.t) + chi^(arrow.t arrow.b),
    wide
    chi^"s" = chi^(arrow.t arrow.t) - chi^(arrow.t arrow.b).
  $

  Using the result from above give expressions for these susceptibilities in the RPA.
  Which of the two $chi$s was discussed in the lecture in the context of screening?
]

#solution[
  Here, we will assume $"SU"(2)$ symmetry, which implies
  $
    chi_0^(arrow.b) = chi_0^(arrow.t) = chi_0
  $
  and then RPA yields for the density susceptibility
  $
    chi^"c" & = chi^(arrow.t arrow.t) + chi^(arrow.t arrow.b) \
            & = chi_0 / (1 - U^2 chi_0^2) - (U chi_0^2) / (1 - U^2 chi_0^2) \
            & = (chi_0 (1 - U chi_0)) / ((1 - U chi_0) (1 + U chi_0)) \
            & = chi_0 / (1 + U chi_0)
  $
  and for the spin susceptibility
  $
    chi^"s" & = chi^(arrow.t arrow.t) - chi^(arrow.t arrow.b) \
            & = chi_0 / (1 - U^2 chi_0^2) + (U chi_0^2) / (1 - U^2 chi_0^2) \
            & = (chi_0 (1 + U chi_0)) / ((1 - U chi_0) (1 + U chi_0)) \
            & = chi_0 / (1 - U chi_0).
  $
  In the lecture, to derive Thomas-Fermi screening, we used
  $
    V_"eff" = V / (1 + V chi_0),
  $
  which corresponds to $chi^"c"$.
]

==

#problem[
  _(Bonus points)_ Using the results of Problem 11 of Exercise 5, consider the electronic system for $d = 2$ in presence of the Hubbard interaction $U > 0$, and calculate within the RPA the two (ferromagnetic and antiferromagnetic) spin susceptibilities.
  On the basis of your RPA calculations, make your final considerations about the tendency of the system towards a given magnetic order at $T = 0$.
]

#solution[
  In Problem 11 we found for the non-interacting ferro- and antiferromagnetic susceptibilities of the hypercubic lattice
  $
     chi_0^"F" & = hbar^2 / 4 Pi_0^"F" \
    chi_0^"AF" & = hbar^2 / 4 Pi_0^"AF"
  $
  with the bare polarization bubbles
  $
     Pi_0^"F" & = 1 / N sum_vb(k) beta / 2 [cosh(frac(beta epsilon_vb(k), 2, style: "vertical"))]^(-2) \
    Pi_0^"AF" & = 1 / N sum_vb(k) 1 / epsilon_vb(k) tanh((beta epsilon_vb(k)) / 2).
  $
  We now add an interaction
  $
    H_"int" = U n_arrow.b n_arrow.t
  $
  to the Hamiltonian and approximate the susceptibilities in RPA
  $
     chi_"RPA"^"F" & = hbar^2 / 4 Pi_0^"F" / (1 - U Pi_0^"F") \
    chi_"RPA"^"AF" & = hbar^2 / 4 Pi_0^"AF" / (1 - U Pi_0^"AF").
  $

  === Ferromagnetic
  Taking the $T -> 0$ (i.e. $beta -> infinity$) limit, we note that
  $
    lim_(beta -> infinity) beta / 2 [cosh(frac(beta epsilon, 2, style: "vertical"))]^(-2) = 2delta(epsilon)
  $
  and therefore
  $
    Pi_0^"F" = 2 / N sum_(vb(k)) delta(epsilon_vb(k)) = 2 N(0),
  $
  where $N(0)$ is the DOS at the Fermi level.

  === Antiferromagnetic
  Because
  $
    lim_(beta -> infinity) 1 / epsilon tanh((beta epsilon) / 2) = 1 / abs(epsilon),
  $
  we have at $T -> 0$
  $
    Pi_0^"AF" = 1 / N sum_(vb(k)) 1 / abs(epsilon_vb(k))
  $

  In two dimensions at half filling the square lattice is perfectly nested.
  The nesting vector is
  $
    vb(Q) = (pi, pi),
  $
  and it satisfies
  $
    epsilon_(vb(k) + vb(Q)) = - epsilon_vb(k).
  $
  Therefore the antiferromagnetic particle-hole bubble diverges at $T = 0$.
  In RPA this means that
  $
    chi_"RPA"^"AF"
    =
    hbar^2 / 4 Pi_0^"AF" / (1 - U Pi_0^"AF")
  $
  becomes unstable when
  $
    1 - U Pi_0^"AF" = 0.
  $
  Since $Pi_0^"AF"$ diverges for $T -> 0$, this instability occurs for
  arbitrarily small repulsive $U > 0$.

  The ferromagnetic susceptibility is also enhanced because the two-dimensional
  square lattice has a van-Hove singularity at half filling. However, the
  antiferromagnetic channel is the dominant one because it is additionally
  enhanced by perfect nesting.

  Thus, within RPA, the half-filled two-dimensional Hubbard model has a
  dominant tendency towards antiferromagnetic order at $T = 0$.
]

