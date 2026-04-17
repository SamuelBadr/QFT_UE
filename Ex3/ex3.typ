#import "../exercise-style.typ": *
#import "@preview/unify:0.7.1": num, numrange, qty, qtyrange

#show: exercise-sheet.with(
  "QFT for Many-Body Systems",
  3,
  author: "Samuel Badr",
  semester: "Sommersemester 2026",
  tutorial: "TUTORIUM: Friday, 8.05.2026.",
  title-suffix: "Exercise Sheet",
)

#let start = 5
#counter(heading).update(start - 1)

#set math.equation(numbering: "(1)")

= Fermi liquid (FL) parameters from a microscopic theory

#problem[
  In interacting microscopic theories one of the most important quantities is the self-energy $Sigma(vb(k), omega)$.
  In the lecture it was shown that for a metal one can connect values extracted out of a Taylor expansion of the self-energy around the Fermi level to the phenomenological parameters of the Landau Fermi liquid theory.

  In particular, if the self-energy out of the microscopic theory considered (e.g. dynamical mean-field theory) is purely local [i.e., not $vb(k)$-dependent: $Sigma(vb(k), omega) = Sigma(omega)$], one obtains the following relations:

  $
    Z = [1 - evaluated(pdv(Re Sigma(omega), omega))_(omega -> 0)]^(-1),
    quad
    m^* / m = Z^(-1),
    quad
    Gamma = evaluated(-Im Sigma(omega))_(omega -> 0)
  $ <eq:qpweight>

  where $Z$ is the quasiparticle weight, $m^*$ the effective mass, $m$ is the bare mass, and $Gamma$ defines the quasiparticle scattering rate so that the quasiparticle lifetime is $tau = (2 Z Gamma)^(-1)$.

  Now consider the file `siw.txt` (to be downloaded from TISS).
  It contains local fermionic self-energies for positive Matsubara frequencies $Sigma_l (ii omega_n)$ for four different physical cases $l = 1, 2, 3, 4$ at the inverse temperature $1/T equiv beta = qty("50", "/eV")$.
  The columns of the file contain the following: $omega_n$ | $Re Sigma_1 (ii omega_n)$ | $Im Sigma_1 (ii omega_n)$ | $Re Sigma_2 (ii omega_n)$ ...
]

==

#problem[
  Plot the real and imaginary parts of the self-energies in all cases, respectively.
]

==

#problem[
  For cases one to three numerically extract the quasiparticle weight $Z$, the effective mass $m^* / m$ and $Gamma$.
  What is the difference between these cases an how could one interpret those? _Hint: In principle one would have to analytically continue the self-energy from the Matsubara to the real frequency axis ($ii omega_n -> omega + ii delta$).
  Show that these parameters can also be approximately obtained directly from values at Matsubara frequencies as follows:_

  $
    Z = [1 - evaluated(pdv(Im Sigma(ii omega_n), omega_n))_(omega_n -> 0^+)]^(-1),
    quad
    Gamma = -evaluated(Im Sigma(ii omega_n -> 0^+))_(omega_n -> 0^+)
  $
]

==

#problem[
  What about the fourth case? See also exercise 6.
]

= A simple model with strong correlations

#problem[
  Landau FL theory, as a theory for metals, reproduces many qualitative features of the non-interacting Fermi gases.
  In such systems, the screened Coulomb energy is much smaller than the electronic kinetic energy.
  As a result, the electron-electron interactions are effectively small perturbations to the motion of electrons at the Fermi level.

  In another limit, i.e. when Coulomb energy is much stronger than the electronic kinetic energy, FL theory does not hold anymore.
  An intuitive, yet simple, example for understanding the complete disappearance of quasiparticles due to the strong electron-electron correlations is the Hubbard model at the atomic limit, where it reads:

  $
    H_"at" = U n_arrow.t n_arrow.b - mu (n_arrow.t + n_arrow.b)
  $

  Let us consider here the half-filling case, i.e. one electron per site, obtained for chemical potential $mu = U / 2$ which we absorb in the Hamiltonian.
  We observe that there is only one energy scale in this model, the local Coulomb repulsion $U$.
  As the particle numbers $n_arrow.t$ and $n_arrow.b$ are good quantum numbers of this Hamiltonian, the basis of the problem can be simply taken as the particle number basis:

  $
    ket(0), quad ket(arrow.t), quad ket(arrow.b), quad ket(arrow.t arrow.b),
  $ <eq:basis>

  which represents the empty, singly occupied (up/down) and doubly occupied states, correspondingly.
]

==

#problem[
  Show that the states in @eq:basis are also the eigenstates of $H_"at"$ and find the corresponding eigenenergies.
  Show that the partition function at inverse temperature $beta$ is given as $cal(Z) = tr e^(-beta H) = 2 (1 + e^(beta U / 2))$.
]

==

#problem[
  Try to express the creation and annihilation operators $hat(c)^dagger_sigma$ and $hat(c)_sigma$ as $4 times 4$ matrices in the above basis.
  Show that the imaginary-time Green's function is given by:

  $
    G_sigma (tau)
    = -expval(T_tau hat(c)_sigma (tau) hat(c)^dagger_sigma)
    = -1 / cal(Z) tr[e^(-beta H) hat(c)_sigma (tau) hat(c)^dagger_sigma]
    = -(e^(U/2 tau) + e^((beta - tau) U / 2)) / cal(Z),
  $

  where $sigma$ stands for the spin orientation $arrow.t$ (or $arrow.b$).
]

==

#problem[
  Fourier transform the imaginary-time Green's function $G_sigma (tau)$ to Matsubara space to get $G_sigma (ii omega_n) = integral_0^beta G_sigma (tau) e^(ii omega_n tau) dd(tau)$ and determine the corresponding spectral function $A_sigma (omega)$ and the self-energy $Sigma_sigma (omega)$.
  [_Hint: to get $A_sigma (omega)$ at real frequency axis, an analytical continuation $ii omega_n -> omega + ii delta$ is required._]
  Does the system have an energy gap, and if so how large is it?
  Do we have well-defined quasiparticles in this case?
  [_Hint:_ try to determine the quasiparticle weight $Z$, effective mass $m^*$ and scattering rate $Gamma$ as defined in @eq:qpweight.]
]
