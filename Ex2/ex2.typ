#import "../exercise-style.typ": *

#show: exercise-sheet.with(
  "QFT for Many-Body Systems",
  2,
  author: "Samuel Badr",
  semester: "Sommersemester 2026",
  tutorial: "TUTORIUM: Friday, 17.04.2026.",
  title-suffix: "Exercise Sheet",
)

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

==

#problem[
  (Bonus points) How would Eq. (1) change in the case $T > 0$? And how would the estimate of 4a) for $gamma$ change, assuming that for $T > 0$ the incoming electron with energy $epsilon_1$ is a thermally activated particle?
]

= How to sum over Matsubara frequencies

#problem[
  As it was discussed in the Lecture, the fermionic Green's function in imaginary time reads

  $
    G(vb(k), tau) = -1 / Z op("Tr"){ee^(-beta H) T[c_vb(k) (tau) c_vb(k)^dagger (0)]},
  $

  where $Z = op("Tr") ee^(-beta H)$ is the partition function, $beta$ the inverse temperature and $T$ is the imaginary-time ordering operator. When transforming this expression to frequency space

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
  Perform the Matsubara sum in (6) for the case of non-interacting electrons with energy dispersion $epsilon_k$, whose Green's function is given by $G(vb(k), ii omega_n) = 1 / (ii omega_n - epsilon_k)$. #hint[note that $ii omega_n$ are exactly the simple poles of the Fermi distribution function in the complex plane with residue $-beta^(-1)$. This means that the Matsubara sum can be written as an integral over a contour enclosing all Matsubara frequencies. Note also that the Green's function is analytic in the lower/upper complex half-plane. Exploiting these analytic properties of the integrand, it is convenient to further transform this contour into two disconnected contours extending in the whole complex plane.]
]

==

#problem[
  Think about a possible numerical implementation of Eq. (6), e.g. suppose one knows the value of $G(vb(k), ii omega_n)$ for a finite set of frequencies (say from $-ii omega_M$ to $ii omega_M$). What would be wrong with a "straightforward" numerical evaluation of such expression (i.e., just summing up all values available)? Suggest possible tricks to correct the problems encountered and to get reliable numerical results.
]

==

#problem[
  In QFT one often has to calculate so-called "bubble" diagrams of the form

  $
    1 / (L^d) sum_vb(k) 1 / beta sum_n G(vb(k), ii omega_n) G(vb(k) + vb(q), ii omega_n + ii Omega_m),
  $

  where $Omega_m$ is an "external" bosonic Matsubara frequency given by $Omega_m = 2 m pi / beta$. Using the free particle case again, calculate the expression (7) analytically, and discuss explicitly the results for the two limiting cases (i) $Omega_m = 0$, $vb(q) arrow.r 0$ ("static limit"), and (ii) $vb(q) = 0$, $Omega_m arrow.r 0$ ("dynamic limit"). #hint[a convenient way of proceeding is to use a partial fraction decomposition.]
]

==

#problem[
  (Bonus points) Consider again the Matsubara summation of 5a), but now for an interacting electronic system, whose Green function can be written as $G(vb(k), ii omega_n) = 1 / (ii omega_n - epsilon_vb(k) - Sigma(vb(k), ii omega_n))$, where $Sigma(vb(k), ii omega_n)$ is the electronic self-energy. While the Matsubara summation of (6) cannot be performed exactly any longer, it is possible to express it in terms of the Fermi function $f(omega)$ and of the spectral function $A(vb(k), omega) = -1 / pi op("Im") G^"R" (vb(k), omega)$. Derive such an expression for the Matsubara summation of (6), and verify that it reproduces the explicit results of 5a) in the case of a non-interacting system (i.e., when $Sigma(vb(k), ii omega_n) = 0$).
]
