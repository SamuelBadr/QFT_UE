#import "../exercise-style.typ": *
#import "@preview/unify:0.7.1": num, numrange, qty, qtyrange
#import "@preview/simple-plot:0.3.0": plot

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

#problem[
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
]

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
      e^(-beta hat(H))
      hat(c)_(vb(k) sigma) (tau) hat(c)_(vb(k) sigma)^dagger
    ],
    quad beta >= tau >= 0,
  $ <eq:g-tau>

  of the Green's function.
  The partition function is defined as $Z = tr[e^(-beta hat(H))]$.

  _Hint: Use the Lehmann representation, i.e. perform the trace over the basis of the eigenvalues and insert the completeness relation, where needed._
]

==

#problem[
  Continue the result obtained above for $G_sigma (vb(k), tau)$ to real times by the inverse Wick-rotation $tau -> ii t$.
  Give a physical interpretation for the result.
]

==

#problem[
  Calculate the Green's function $G_sigma (vb(k), ii omega_n)$ in Matsubara frequency space by performing the Fourier-transform

  $
    G_sigma (vb(k), ii omega_n)
    = integral_0^beta dif tau e^(ii omega_n tau) G_sigma (vb(k), tau),
  $ <eq:g-matsu>

  where $omega_n = pi / beta (2 n + 1)$, $n in ZZ$ is a fermionic Matsubara frequency.
  Then continue the results on the real frequency axis and calculate the corresponding spectral function $A(vb(k), omega)$.
]

==

#problem[
  Now, consider the opposite limit where the kinetic energy appearing in the Hamiltonian in @eq:hubbard is negligible compared to the interaction, i.e., $epsilon_vb(k) = 0$ (atomic limit).
]

==

#problem[
  The local Green's function for site $i$, $G_(i sigma) (tau)$, is defined as

  $
    G_(i sigma) (tau)
    = - expval(T_tau hat(c)_(i sigma) (tau) hat(c)_(i sigma)^dagger)
    = -1 / Z tr [
      e^(-beta hat(H))
      hat(c)_(i sigma) (tau) hat(c)_(i sigma)^dagger
    ],
    quad beta >= tau >= 0.
  $ <eq:g-local>

  Note that the different atoms are completely independent in this case and the local Green's function is thus the same as already calculated in Problem 6 of Exercise 3.
  From its Fourier transform $G_(i sigma) (ii omega_n)$, extract the corresponding expression for the self-energy $Sigma_(i sigma) (ii omega_n)$.
  Is the atomic-limit expression derivable within conventional perturbation theory?
]

==

#problem[
  Calculate, analogously as above, the local magnetic (spin) $chi^s_i (tau) = expval(T_tau S^z_i (tau) S^z_i)$ and density (charge) $chi^c_i (tau) = expval(T_tau n_i (tau) n_i)$ susceptibilities in the atomic limit of the Hubbard model (with $S^z_i = n_(i arrow.t) - n_(i arrow.b)$ and $n_i = n_(i arrow.t) + n_(i arrow.b)$), as well as their Fourier transform to Matsubara frequencies.
  Then, analytically continue the expressions to real frequencies.
  What can you say about the temperature dependence?
]

= RPA for the Hubbard model

#problem[
  In the Hubbard model (Hamiltonian in @eq:hubbard), the interaction is purely local and penalizes double occupations: $U sum_i n_(i arrow.t) n_(i arrow.b)$.
  Therefore, the interaction only couples electrons with opposite spin.
]

==

#problem[
  Then also susceptibilities can acquire a spin-dependence: $chi_(sigma sigma')$.

  Remembering that momentum, energy and spin need to be conserved at each vertex.
]

==

#problem[
  Draw the bubble diagram of the free susceptibility $chi_0^(sigma sigma') (vb(q), omega)$ and say which spin-combinations are possible.
]

==

#problem[
  Draw the random phase approximation (RPA) series for $chi_("RPA")^(arrow.t arrow.t)$ and $chi_("RPA")^(arrow.t arrow.b)$.
  What can you say about the allowed powers of $U$ in both series?
  Translate the diagrams into formulas and rewrite them using the geometric series.
  In all of this you can omit the labels for momentum and frequency.
]

==

#problem[
  The charge and spin susceptibilities (the local versions of which were already introduced above) are given by

  $
    chi^c = chi^(arrow.t arrow.t) + chi^(arrow.t arrow.b),
    quad
    chi^s = chi^(arrow.t arrow.t) - chi^(arrow.t arrow.b).
  $

  Using the result from above give expressions for these susceptibilities in the RPA.
  Which of the two $chi$s was discussed in the lecture in the context of screening?
]

==

#problem[
  _(Bonus points)_ Using the results of Problem 11 of Exercise 5, consider the electronic system for $d = 2$ in presence of the Hubbard interaction $U > 0$, and calculate within the RPA the two (ferromagnetic and antiferromagnetic) spin susceptibilities.
  On the basis of your RPA calculations, make your final considerations about the tendency of the system towards a given magnetic order at $T = 0$.
]
