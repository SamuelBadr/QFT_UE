#import "../exercise-style.typ": *
#import "./figures-src/phase-space-constraints.typ": phase-space-constraints-figure

#show: exercise-sheet.with(
  "QFT for Many-Body Systems",
  2,
  author: "Samuel Badr",
  semester: "Sommersemester 2026",
  tutorial: "TUTORIUM: Friday, 17.04.2026.",
  title-suffix: "Exercise Sheet",
)

#let start = 3
#counter(heading).update(start - 1)

= Decay of an electron close to the Fermi sea

#problem[
  The possibility of treating a many-electron system in terms of independent excitations (the so-called "quasi-particles") relies on the fact that for metallic systems the electronic scattering between two particles at the Fermi energy $epsilon_"F"$ is vanishing. Specifically, it is possible to show this by means of a phase-space argument: Consider the following elastic scattering process at $T = 0$. An incoming electron with fixed momentum $vb(k)_1$ and energy $epsilon_1 > epsilon_"F"$ is scattered by one of the electrons of the metallic system (i.e., with momentum $vb(k)_2$ and energy $epsilon_2 < epsilon_"F"$). If the scattering takes place, one will observe two outgoing particles with energies $epsilon_3, epsilon_4 > epsilon_"F"$. The corresponding "decay" probability for the incoming electron can be estimated as

  $
    gamma &prop integral dd(k_2, [d]) dd(k_3, [d]) dd(k_4, [d]) delta(vb(k)_1 + vb(k)_2 - vb(k)_3 - vb(k)_4) delta(epsilon_1 + epsilon_2 - epsilon_3 - epsilon_4) \
    &= integral dd(k_2, [d]) dd(k_3, [d]) delta(epsilon_1 + epsilon_2 - epsilon_3 - epsilon_4),
  $

  where the delta functions ensure the energy and momentum conservation in the process. The formally correct way of evaluating $gamma$ would be to perform the relatively cumbersome integrals over the momenta $vb(k)_2$, $vb(k)_3$ taking into account that $epsilon_4$ is a function of their lengths $k_2$, $k_3$ and of the angle between them.
]

==

#problem[
  A much simpler way to evaluate the "decay" probability $gamma$ in $d > 2$, is to rewrite Eq. (1) as

  $
    gamma tilde.op integral dd(epsilon_2) dd(epsilon_3)
  $

  and use the delta function only as a constraint to set the limits of the two energy integrals. Using Eq. (2) evaluate $gamma$ as a function of $epsilon_1$, $epsilon_"F"$ and interpret the results in terms of the Fermi-liquid theory.
]

#solution[
  #two_panel[
    To determine the integration limits, note that

    $
      epsilon_1 & > epsilon_"F" \
      epsilon_2 & < epsilon_"F" \
      epsilon_3 & > epsilon_"F" \
      epsilon_4 & > epsilon_"F"
    $

    and

    $
      epsilon_1 + epsilon_2 = epsilon_3 + epsilon_4.
    $
  ][
    #phase-space-constraints-figure()
  ]

  Therefore, we have integration limits

  $
                epsilon_2 & < epsilon_"F" \
                epsilon_3 & > epsilon_"F" \
    epsilon_2 - epsilon_3 & > epsilon_"F" - epsilon_1
  $

  which bound a triangle, leading to

  $
    gamma prop 1/2 (epsilon_"F" - (2epsilon_"F" - epsilon_1)) (epsilon_1 - epsilon_"F") = 1/2 (epsilon_1 - epsilon_"F")^2,
  $

  showing that excitations near the Fermi surface have long lifetimes

  $
    tau = 1 / gamma prop 1 / (epsilon_1 - epsilon_"F")^2
  $

  which diverge as $epsilon_1 arrow epsilon_"F"$. This shows that excitations near the Fermi surface are long-lived and can be identified with Landau quasi-particles, one of the central results of Fermi-liquid theory.
]

==

#problem[
  (Bonus points) How would Eq. (1) change in the case $T > 0$? And how would the estimate of 4a) for $gamma$ change, assuming that for $T > 0$ the incoming electron with energy $epsilon_1$ is a thermally activated particle?
]

#solution[
  The original integral in Eq. (1) for $T=0$ implicitly includes step functions

  $
    gamma &prop integral dd(k_2, [d]) dd(k_3, [d]) delta(epsilon_1 + epsilon_2 - epsilon_3 - epsilon_4) theta(epsilon_"F" - epsilon_2) theta(epsilon_3 - epsilon_"F") theta(epsilon_4 - epsilon_"F")
  $


  which in the case of $T > 0$ are replaced by Fermi functions $theta(epsilon - epsilon_"F") arrow 1 - n_"F" (epsilon)$ with $n_"F" (epsilon) = (1 + ee^(frac((epsilon - epsilon_"F"), k_"B" T, style: "horizontal")))^(-1)$, leading to

  $
    gamma &prop integral dd(k_2, [d]) dd(k_3, [d]) delta(epsilon_1 + epsilon_2 - epsilon_3 - epsilon_4) n_"F" (epsilon_2) [1 - n_"F" (epsilon_3)] [1 - n_"F" (epsilon_4)].
  $

  The counterpart to (2) then is

  $
    gamma tilde integral dd(epsilon_2) dd(epsilon_3) n_"F" (epsilon_2) [1 - n_"F" (epsilon_3)] [1 - n_"F" (epsilon_1 + epsilon_2 - epsilon_3)]
  $

  which is equal to

  $
    gamma tilde 1/2 1/(1 + ee^(-frac((epsilon_1 - epsilon_"F"), k_"B" T, style: "horizontal"))) [(epsilon_1 - epsilon_"F")^2 + pi^2 (k_"B" T)^2].
  $

  (Checked with Mathematica and also numerical integration.)
]

= How to sum over Matsubara frequencies

#problem[
  As it was discussed in the Lecture, the fermionic Green's function in imaginary time reads

  $
    G(vb(k), tau) = -1 / Z op("Tr"){ee^(-beta H) cal(T)[c_vb(k) (tau) c_vb(k)^dagger (0)]},
  $

  where $Z = op("Tr") ee^(-beta H)$ is the partition function, $beta$ the inverse temperature and $cal(T)$ is the imaginary-time ordering operator. When transforming this expression to frequency space

  $
    G(vb(k), tau) = 1 / beta sum_n ee^(-ii omega_n tau) G(vb(k), ii omega_n)
  $

  and using the cyclic properties of the trace, one can immediately deduce that the sum in Eq. (4) has to be performed only over the discrete so-called fermionic Matsubara frequencies $omega_n = pi / beta (2 n + 1)$. When performing the explicit evaluation of Feynman diagrams in terms of physical quantities, a typical intermediate step consists exactly of this evaluation of sums over Matsubara frequencies. We will consider here the simplest cases, which represent, however, the basis for performing more complicated calculations occurring in realistic situations.

  The particle density $chevron.l n chevron.r$ of an electronic system can be expressed in terms of the Green's function as follows

  $
    chevron.l n chevron.r = 1 / L^d sum_vb(k) chevron.l c_vb(k)^dagger c_vb(k) chevron.r &= 1 / L^d sum_vb(k) G(vb(k), tau = 0^-) \
    &= 1 / (L^d) sum_vb(k) 1 / beta sum_n ee^(-ii omega_n 0^-) G(vb(k), ii omega_n)
  $
]

==

#problem[
  Perform the Matsubara sum in (6) for the case of non-interacting electrons with energy dispersion $epsilon_vb(k)$, whose Green's function is given by $G(vb(k), ii omega_n) = 1 / (ii omega_n - epsilon_vb(k))$. #hint[note that $ii omega_n$ are exactly the simple poles of the Fermi distribution function in the complex plane with residue $-beta^(-1)$. This means that the Matsubara sum can be written as an integral over a contour enclosing all Matsubara frequencies. Note also that the Green's function is analytic in the lower/upper complex half-plane. Exploiting these analytic properties of the integrand, it is convenient to further transform this contour into two disconnected contours extending in the whole complex plane.]
]

#solution[
  We want to compute

  $
    1 / beta sum_n ee^(-ii omega_n 0^-) G(vb(k), ii omega_n)
  $


  for $G(vb(k), ii omega_n) = 1 / (ii omega_n - epsilon_vb(k))$.
  We will start by noting that the Matsubara frequencies $ii omega_n$ are the poles of

  $
    n_"F" (z) = 1 / (1 + ee^(beta z)),
  $

  with residue $-beta^(-1)$, so we can make use of the residue theorem

  $"F"
  integral.cont_gamma dd(z) g(z) n_"F" (z) = 2pi ii sum_n op("Res")(g n_, ii omega_n) = -2pi ii 1/beta sum_n g(ii omega_n)$

  where $gamma$ is a curve enclosing all the poles of $n_"F" (z)$ and $g(z)$ is a function holomorphic in the region enclosed by $gamma$.

  In our case, we take $g(z) = e^(z tau) G(vb(k), z)$ with $tau > 0$. Hence the Matsubara sum is equal to

  $
    1 / beta sum_n ee^(-ii omega_n 0^-) G(vb(k), ii omega_n) = lim_(tau arrow 0^+) -1 / (2pi ii) integral.cont_gamma dd(z) ee^(z tau) G(vb(k), z) n_"F" (z)
  $

  where $gamma$ cannot enclose $z = epsilon_vb(k)$.

  As a surrogate, we now evaluate the integral over the circle $C_n$ which consists of points $z = R_n ee^(ii phi)$ with $R_n = (2 pi n) / beta$ (to avoid the poles)

  $
    I_n & = integral.cont_(C_n) dd(z) ee^(z tau) G(vb(k), z) n_"F" (z) \
        & = integral_0^(2pi) dd(phi) thin ii z ee^(z tau) 1 / (z - epsilon_vb(k)) 1 / (1 + ee^(z beta))
  $

  and take its absolute value
  $
    abs(I_n) & lt.eq integral_0^(2pi) dd(phi) abs(z ee^(z tau) 1 / (z - epsilon_vb(k)) 1 / (1 + ee^(z beta))) \
             & = integral_0^(2pi) dd(phi) abs(z/(z - epsilon_vb(k))) abs(ee^(z tau) / (1 + ee^(z beta))).
  $

  For large enough $R_n$ (i.e. $R_n > 2 abs(epsilon_vb(k))$), we have

  $
    abs(z/(z - epsilon_vb(k))) < 2
  $

  so

  $
    abs(I_n) lt.eq 2 integral_0^(2pi) dd(phi) abs(ee^(z tau) / (1 + ee^(z beta))).
  $

  Now we split up into the left and right semi-circles:
  - Left $Re z < 0$:

  $
    abs(ee^(z tau) / (1 + ee^(z beta))) lt.eq ee^(-abs(Re z) tau) / (1 - ee^(-abs(Re z) beta)) approx e^(-abs(Re z) tau)
  $

  - Right $Re z > 0$:

  $
    abs(ee^(z tau) / (1 + ee^(z beta))) lt.eq ee^(-abs(Re z) (beta - tau))
  $

  So, for any $z$

  $
    abs(ee^(z tau) / (1 + ee^(z beta))) lt.tilde ee^(-abs(Re z) min(tau, beta - tau)) = ee^(-R_n abs(cos phi) min(tau, beta - tau)) --> 0
  $

  and we conclude

  $
    I equiv lim_(n -> infinity) I_n = 0.
  $

  On the other hand the integrand features one pole at $z = epsilon_vb(k)$. Hence, by the residue theorem

  $
    I & = 2 pi ii op("Res")(G n_"F", epsilon_vb(k)) + 2 pi ii sum_n op("Res")(e^(-z 0^-) G(vb(k), z) n_"F" (z), ii omega_n) \
      & = 2 pi ii n_"F" (epsilon_vb(k)) - 2 pi ii 1/beta sum_n ee^(-ii omega_n 0^-) G(vb(k), ii omega_n).
  $

  Taking both facts together, we can conclude

  $
    1 / beta sum_n ee^(-ii omega_n 0^-) G(vb(k), ii omega_n) = n_"F" (epsilon_vb(k)).
  $
]

==

#problem[
  Think about a possible numerical implementation of Eq. (6), e.g. suppose one knows the value of $G(vb(k), ii omega_n)$ for a finite set of frequencies (say from $-ii omega_M$ to $ii omega_M$). What would be wrong with a "straightforward" numerical evaluation of such expression (i.e., just summing up all values available)? Suggest possible tricks to correct the problems encountered and to get reliable numerical results.
]

#solution[
  Typically, the Green's function will have a structure similar to

  $
    G(vb(k), ii omega_n) = 1 / (ii omega_n) + (a_1(vb(k))) / (ii omega_n)^2 + (a_2(vb(k))) / (ii omega_n)^3 + dots,
  $

  so truncating the Matsubara sum at $abs(n) lt.eq M$ leaves a tail that decays unreliably.
  To correct this, one may write

  $
    G(vb(k), ii omega_n) = 1 / (ii omega_n) + (G(vb(k), ii omega_n) - 1 / (ii omega_n)).
  $

  The second term decays as $1 / (ii omega_n)^2$, so the sum is much better behaved and the first term can (and must!) be handled analytically, giving

  $
    1 / beta sum_n ee^(-ii omega_n 0^-) G(vb(k), ii omega_n) = 1/2 + 1 / beta sum_(n = -M)^M (G(vb(k), ii omega_n) - 1 / (ii omega_n)) + cal(O)(1 / (omega_M)).
  $
]

==

#problem[
  In QFT one often has to calculate so-called "bubble" diagrams of the form

  $
    1 / (L^d) sum_vb(k) 1 / beta sum_n G(vb(k), ii omega_n) G(vb(k) + vb(q), ii omega_n + ii Omega_m),
  $

  where $Omega_m$ is an "external" bosonic Matsubara frequency given by $Omega_m = 2 m pi / beta$. Using the free particle case again, calculate the expression (7) analytically, and discuss explicitly the results for the two limiting cases (i) $Omega_m = 0$, $vb(q) -> 0$ ("static limit"), and (ii) $vb(q) = 0$, $Omega_m -> 0$ ("dynamic limit"). #hint[a convenient way of proceeding is to use a partial fraction decomposition.]
]

#solution[
  $
    S(vb(k), vb(q), ii Omega_m) &= 1 / beta sum_n G(vb(k), ii omega_n) G(vb(k) + vb(q), ii omega_n + ii Omega_m) \
    &= 1 / beta sum_n 1 / (ii omega_n - epsilon_vb(k)) 1 / (ii omega_n + ii Omega_m - epsilon_(vb(k) + vb(q))) \
    &= - 1/(2 pi ii) integral.cont_gamma dd(z) 1 / (z - epsilon_vb(k)) 1 / (z - (epsilon_(vb(k) + vb(q)) - ii Omega_m)) n_"F" (z)
  $

  where $gamma$ encloses the imaginary axis but not the poles of the Green's functions

  $
    z_1 = epsilon_vb(k) quad "and" quad z_2 = epsilon_(vb(k) + vb(q)) - ii Omega_m.
  $

  This time, the big circle integral vanishes trivially.

  We now have to distinguish two cases:
  - $z_1 eq.not z_2$: 2 poles of order 1

  $
    S(vb(k), vb(q), ii Omega_m) &= sum_(i=1)^2 op("Res")(1 / ((z - z_1)(z - z_2)) n_"F" (z), z_i) \
    &= (n_"F" (z_1)) / (z_1 - z_2) + (n_"F" (z_2)) / (z_2 - z_1) \
    &= (n_"F" (epsilon_vb(k)) - n_"F" (epsilon_(vb(k) + vb(q)))) / (epsilon_vb(k) - epsilon_(vb(k) + vb(q)) + ii Omega_m)
  $

  - $z_1 eq z_2$: 1 pole of order 2
  $
    S(vb(k), vb(q), ii Omega_m) & = op("Res")(1 / (z - z_1)^2 n_"F" (z), z_1) \
                                & = lim_(z -> z_1) dv(, z) n_"F" (z) \
                                & = n'_"F" (epsilon_vb(k)).
  $

  === Limiting cases

  - Static limit $Omega_m = 0$, $vb(q) -> 0$:

  $
    lim_(vb(q) -> 0) S(vb(k), vb(q), 0) = lim_(vb(q) -> 0) (n_"F" (epsilon_vb(k)) - n_"F" (epsilon_(vb(k) + vb(q)))) / (epsilon_vb(k) - epsilon_(vb(k) + vb(q))) = lim_(b -> a) (n_"F" (a) - n_"F" (b)) / (a - b) = n'_"F" (epsilon_vb(k)).
  $

  - Dynamic limit $vb(q) = 0$, $Omega_m -> 0$:

  $
    lim_(Omega_m -> 0) S(vb(k), 0, ii Omega_m) = lim_(Omega_m -> 0) (n_"F" (epsilon_vb(k)) - n_"F" (epsilon_(vb(k)))) / (epsilon_vb(k) - epsilon_(vb(k)) + ii Omega_m) = lim_(Omega_m -> 0) 0 / (ii Omega_m) = 0.
  $


]

==

#problem[
  (Bonus points) Consider again the Matsubara summation of 5a), but now for an interacting electronic system, whose Green function can be written as $G(vb(k), ii omega_n) = 1 / (ii omega_n - epsilon_vb(k) - Sigma(vb(k), ii omega_n))$, where $Sigma(vb(k), ii omega_n)$ is the electronic self-energy. While the Matsubara summation of (6) cannot be performed exactly any longer, it is possible to express it in terms of the Fermi function $f(omega)$ and of the spectral function $A(vb(k), omega) = -1 / pi op("Im") G^"R" (vb(k), omega)$. Derive such an expression for the Matsubara summation of (6), and verify that it reproduces the explicit results of 5a) in the case of a non-interacting system (i.e., when $Sigma(vb(k), ii omega_n) = 0$).
]

#solution[
  We write

  $
    G(vb(k), z) = integral_(bb(R)) dd(omega) A(vb(k), omega) / (z - omega)
  $

  and plug in to get

  $
    1/beta sum_n ee^(ii omega_n 0^-) G(vb(k), ii omega_n) &= 1/beta sum_n ee^(-ii omega_n 0^-) integral_(bb(R)) dd(omega) A(vb(k), omega) / (ii omega_n - omega) \
    &= integral_(bb(R)) dd(omega) A(vb(k), omega) 1/beta sum_n ee^(-ii omega_n 0^-) 1 / (ii omega_n - omega) \
    &= integral_(bb(R)) dd(omega) A(vb(k), omega) n_"F" (omega).
  $

  Non-interacting limit $Sigma = 0$:
  $
    A(vb(k), omega) = -1 / pi op("Im") 1 / (omega + ii 0^+ - epsilon_vb(k)) = delta(omega - epsilon_vb(k))
  $
  and
  $
    integral_(bb(R)) dd(omega) A(vb(k), omega) n_"F" (omega) = n_"F" (epsilon_vb(k)).
  $
]
