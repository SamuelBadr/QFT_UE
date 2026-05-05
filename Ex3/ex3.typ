#import "../exercise-style.typ": *
#import "@preview/unify:0.7.1": num, numrange, qty, qtyrange
#import "@preview/simple-plot:0.3.0": plot

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

#solution[
  #image("figures/siw_plot.pdf")
]

==

#problem[
  For cases one to three numerically extract the quasiparticle weight $Z$, the effective mass $m^* / m$ and $Gamma$.
  What is the difference between these cases and how could one interpret those? _Hint: In principle one would have to analytically continue the self-energy from the Matsubara to the real frequency axis ($ii omega_n -> omega + ii delta$).
  Show that these parameters can also be approximately obtained directly from values at Matsubara frequencies as follows:_

  $
    Z = [1 - evaluated(pdv(Im Sigma(ii omega_n), omega_n))_(omega_n -> 0^+)]^(-1),
    quad
    Gamma = -evaluated(Im Sigma(ii omega_n))_(omega_n -> 0^+)
  $
]

#solution[
  Assuming that $Sigma(z)$ is analytic near $z = 0$, we expand
  $
    Sigma(z) = Sigma(0) + z Sigma'(0) + cal(O)(abs(z)^2).
  $

  On the real-frequency axis, $z = omega$, hence
  $
    Sigma(omega) = Sigma(0) + omega Sigma'(0) + cal(O)(omega^2),
  $
  so
  $
    Re Sigma(omega) = Re Sigma(0) + omega Re Sigma'(0) + cal(O)(omega^2),
  $
  and therefore
  $
    evaluated(pdv(Re Sigma(omega), omega))_(omega -> 0) = Re Sigma'(0).
  $

  On the Matsubara axis, $z = ii omega_n$, hence
  $
    Sigma(ii omega_n) = Sigma(0) + ii omega_n Sigma'(0) + cal(O)(omega_n^2),
  $
  which implies
  $
    Im Sigma(ii omega_n) = Im Sigma(0) + omega_n Re Sigma'(0) + cal(O)(omega_n^2).
  $
  Thus,
  $
    evaluated(pdv(Im Sigma(ii omega_n), omega_n))_(omega_n -> 0^+)
    = Re Sigma'(0)
    = evaluated(pdv(Re Sigma(omega), omega))_(omega -> 0).
  $

  Inserting this into Eq.~@eq:qpweight gives
  $
    Z = [1 - evaluated(pdv(Im Sigma(ii omega_n), omega_n))_(omega_n -> 0^+)]^(-1).
  $

  Moreover, taking $omega_n -> 0^+$ yields
  $
    evaluated(Im Sigma(ii omega_n))_(omega_n -> 0^+) = Im Sigma(0),
  $
  so, using
  $
    Gamma = evaluated(-Im Sigma(omega))_(omega -> 0),
  $
  one obtains the Matsubara estimate
  $
    Gamma approx -evaluated(Im Sigma(ii omega_n))_(omega_n -> 0^+).
  $

  Hence, if the first Matsubara frequencies already lie in the low-frequency regime, both $Z$ and $Gamma$ can be extracted approximately directly from Matsubara data.

  === Extraction from the data

  To compute $Z$, we have to extract

  $
    evaluated(pdv(Im Sigma(ii omega_n), omega_n))_(omega_n -> 0^+)
  $

  from the data. We use the estimator
  #footnote[
    Several more sophisticated methods were tried, such as fitting a polynomial like $Im Sigma(ii omega_n) ~ A omega_n + B omega_n^3$ (visually poor fit) or $Im Sigma(ii omega_n) ~ A omega_n log(omega_n) + B omega_n$ (excellent fit, but yields divergent derivative, and so $Z = 0$).
  ]

  $
    evaluated((Im Sigma(ii omega_n)) / omega_n)_(omega_n -> 0^+) approx (Im Sigma(ii omega_1)) / omega_1,
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
  Show that the partition function at inverse temperature $beta$ is given as $cal(Z) = tr ee^(-beta H) = 2 (1 + ee^(beta frac(U, 2, style: "horizontal")))$.
]

#solution[
  // Setting $mu = U / 2$ in the Hamiltonian, we have

  // $
  //   H_"at" = U [n_arrow.t n_arrow.b - 1 / 2 (n_arrow.t + n_arrow.b)] = -U/2 [n_arrow.t - n_arrow.b]^2
  // $

  // because $n_sigma^2 = n_sigma$.
  // Furthermore,
  There holds

  $
                  n_sigma ket(0) & = 0 \
              n_sigma ket(sigma) & = ket(sigma) \
             n_sigma ket(-sigma) & = 0 \
    n_sigma ket(arrow.t arrow.b) & = ket(arrow.t arrow.b)
  $

  and so

  $
    H_"at" ket(0) & = [U n_arrow.t n_arrow.b - mu (n_arrow.t + n_arrow.b)] ket(0) = 0 \
    H_"at" ket(arrow.t) & = [U n_arrow.t n_arrow.b - mu (n_arrow.t + n_arrow.b)] ket(arrow.t) = -mu ket(arrow.t) \
    H_"at" ket(arrow.b) & = [U n_arrow.t n_arrow.b - mu (n_arrow.t + n_arrow.b)] ket(arrow.b) = -mu ket(arrow.b) \
    H_"at" ket(arrow.t arrow.b) & = [U n_arrow.t n_arrow.b - mu (n_arrow.t + n_arrow.b)] ket(arrow.t arrow.b) = (U - 2 mu) ket(arrow.t arrow.b),
  $

  showing that the given states are indeed eigenstates of $H_"at"$.

  The partition function is

  $
    cal(Z) & = tr ee^(-beta H) \
           & = sum_n expval(ee^(-beta H), n) \
           & = sum_n ee^(-beta E_n) \
           & = ee^0 + ee^(beta mu) + ee^(beta mu) + ee^(-beta (U - 2 mu))
  $

  and at half-filling $mu = U/2$

  $
    cal(Z) = 2 (1 + ee^(beta frac(U, 2, style: "horizontal"))).
  $
]

==

#problem[
  Try to express the creation and annihilation operators $hat(c)^dagger_sigma$ and $hat(c)_sigma$ as $4 times 4$ matrices in the above basis.
  Show that the imaginary-time Green's function is given by:

  $
    G_sigma (tau)
    = -expval(T_tau hat(c)_sigma (tau) hat(c)^dagger_sigma)
    = -1 / cal(Z) tr[ee^(-beta H) hat(c)_sigma (tau) hat(c)^dagger_sigma]
    = -(ee^(U/2 tau) + ee^((beta - tau) U / 2)) / cal(Z),
  $

  where $sigma$ stands for the spin orientation $arrow.t$ (or $arrow.b$).
]

#solution[
  We take

  $
    ket(arrow.t arrow.b) equiv hat(c)_arrow.t^dagger hat(c)_arrow.b^dagger ket(0)
  $

  and then get

  $
    hat(c)_sigma^dagger ket(0) & = ket(sigma) & wide
    hat(c)_sigma ket(0) & = 0 \
    hat(c)_sigma^dagger ket(sigma) & = 0 & wide
    hat(c)_sigma ket(sigma) & = ket(0) \
    hat(c)_sigma^dagger ket(arrow.t arrow.b) & = 0 & wide
    hat(c)_sigma ket(-sigma) & = 0 \
    hat(c)_arrow.t^dagger ket(arrow.b) &= ket(arrow.t arrow.b) & wide
    hat(c)_arrow.t ket(arrow.t arrow.b) & = ket(arrow.b) \
    hat(c)_arrow.b^dagger ket(arrow.t) &= -ket(arrow.t arrow.b) & wide
    hat(c)_arrow.b ket(arrow.t arrow.b) & = -ket(arrow.t)
  $

  In the ordered basis

  $
    (ket(0), ket(arrow.t), ket(arrow.b), ket(arrow.t arrow.b))
  $

  we get the representation (with the matrix $O$ representing the operator $hat(O)$ given by $O_(m n) = mel(m, hat(O), n)$)

  $
    hat(c)_arrow.t^dagger & <--> mat(
                              dot, dot, dot, dot;
                              1, dot, dot, dot;
                              dot, dot, dot, dot;
                              dot, dot, 1, dot
                            ) & wide
                                hat(c)_arrow.b^dagger & <--> mat(
                                                          dot, dot, dot, dot;
                                                          dot, dot, dot, dot;
                                                          1, dot, dot, dot;
                                                          dot, -1, dot, dot
                                                        ) \
           hat(c)_arrow.t & <--> mat(
                              dot, 1, dot, dot;
                              dot, dot, dot, dot;
                              dot, dot, dot, 1;
                              dot, dot, dot, dot
                            ) &        wide
                                       hat(c)_arrow.b & <--> mat(
                                                          dot, dot, 1, dot;
                                                          dot, dot, dot, -1;
                                                          dot, dot, dot, dot;
                                                          dot, dot, dot, dot
                                                        )
  $

  Bonus:

  $
    n_arrow.t = hat(c)_arrow.t^dagger hat(c)_arrow.t & <--> mat(
                                                         dot, dot, dot, dot;
                                                         dot, 1, dot, dot;
                                                         dot, dot, dot, dot;
                                                         dot, dot, dot, 1
                                                       )
                                                       wide
                                                       n_arrow.b = hat(c)_arrow.b^dagger hat(c)_arrow.b & <--> mat(
                                                                                                            dot, dot, dot, dot;
                                                                                                            dot, dot, dot, dot;
                                                                                                            dot, dot, 1, dot;
                                                                                                            dot, dot, dot, 1
                                                                                                          )
  $

  $
    H = U n_arrow.t n_arrow.b - mu (n_arrow.t + n_arrow.b) & <--> mat(
                                                               dot, dot, dot, dot;
                                                               dot, -mu, dot, dot;
                                                               dot, dot, -mu, dot;
                                                               dot, dot, dot, U - 2 mu
                                                             )
  $

  $
    ee^(tau H) <--> mat(
      1, dot, dot, dot;
      dot, ee^(-mu tau), dot, dot;
      dot, dot, ee^(-mu tau), dot;
      dot, dot, dot, ee^((U - 2 mu) tau)
    )
  $

  $
    hat(c)_arrow.t (tau) & = ee^(tau H) hat(c)_arrow.t ee^(-tau H) <--> mat(
                             dot, ee^(mu tau), dot, dot;
                             dot, dot, dot, ee^((-U + mu) tau);
                             dot, dot, dot, dot;
                             dot, dot, dot, dot
                           ) \
    hat(c)_arrow.b (tau) & = ee^(tau H) hat(c)_arrow.b ee^(-tau H) <--> mat(
                             dot, ee^(mu tau), dot, dot;
                             dot, dot, dot, -ee^((-U + mu) tau);
                             dot, dot, dot, dot;
                             dot, dot, dot, dot
                           )
  $

  $
    ee^(-beta H) hat(c)_arrow.t (tau) hat(c)^dagger_arrow.t & <--> mat(
                                                                ee^(mu tau), dot, dot, dot;
                                                                dot, dot, dot, dot;
                                                                dot, dot, ee^(-U tau + mu (beta + tau)), dot;
                                                                dot, dot, dot, dot
                                                              ) \
    ee^(-beta H) hat(c)_arrow.b (tau) hat(c)^dagger_arrow.b & <--> mat(
                                                                ee^(mu tau), dot, dot, dot;
                                                                dot, ee^(-U tau + mu (beta + tau)), dot, dot;
                                                                dot, dot, dot, dot;
                                                                dot, dot, dot, dot
                                                              )
  $

  The Green's function then is

  $
    G_sigma (tau) & = -expval(T_tau hat(c)_sigma (tau) hat(c)^dagger_sigma) \
                  & = -1 / cal(Z) tr[ee^(-beta H) hat(c)_sigma (tau) hat(c)^dagger_sigma] \
                  & = -1 / cal(Z) (ee^(mu tau) + ee^(-U tau + mu (beta + tau))) \
                  & = - (ee^(mu tau) + ee^(-U tau + mu (beta + tau))) / (1 + 2 ee^(beta mu) + ee^(beta (-U + 2 mu)))
  $

  and in half-filling $mu = U / 2$ this simplifies to

  $
    G_sigma (tau) = - (ee^(U/2 tau) + ee^((beta - tau) U / 2)) / cal(Z) = - (ee^(U/2 tau) + ee^((beta - tau) U / 2)) / (2 (1 + ee^(beta U / 2))).
  $

  #let G(u) = x => {
    -calc.cosh(u * (x - 0.5) / 2.0) / (2.0 * calc.cosh(u / 4.0))
  }

  #figure(
    plot(
      width: 8,
      height: 5,

      xmin: 0.0,
      xmax: 1.1,
      ymin: -0.51,
      ymax: 0.05,

      axis-x-extend: (0, 0),
      axis-y-extend: (0, 0),

      xlabel: $tau$,
      ylabel: $G(tau)$,

      xtick: (0, 1),
      xtick-labels: ($0$, $beta$),
      ytick: (-0.5, 0),
      ytick-labels: ($-1/2$, $0$),

      // show-grid: "major",

      // Avoid extended arrow axes
      axes: "box",

      // Put legend inside the plot
      legend: "north-east",

      (
        fn: G(1),
        stroke: blue + 1.2pt,
        label: $beta U = 1$,
        label-pos: 0.5,
        label-side: "above",
        samples: 300,
        domain: (0, 1),
      ),
      (
        fn: G(10),
        stroke: red + 1.2pt,
        label: $beta U = 10$,
        label-pos: 0.5,
        label-side: "above",
        samples: 300,
        domain: (0, 1),
      ),
      (
        fn: G(100),
        stroke: green + 1.2pt,
        label: $beta U = 100$,
        label-pos: 0.5,
        label-side: "above",
        samples: 300,
        domain: (0, 1),
      ),
    ),
    caption: [
      Green's function $G(tau)$ plotted against $tau$
      for several values of $beta U$.
    ],
  )

  // $
  //   G_sigma (tau) &= -expval(T_tau hat(c)_sigma (tau) hat(c)^dagger_sigma) \
  //   & = -1 / cal(Z) tr[ee^(-beta H) hat(c)_sigma (tau) hat(c)^dagger_sigma] \
  //   & = -1 / cal(Z) sum_n expval(ee^(-beta H) hat(c)_sigma (tau) hat(c)^dagger_sigma, n) \
  //   & = -1 / cal(Z) sum_n expval(ee^(-beta H) ee^(tau H) hat(c)_sigma ee^(-tau H) hat(c)^dagger_sigma, n) \
  //   & = -1 / cal(Z) sum_(n, m) ee^((tau - beta) E_n) mel(n, hat(c)_sigma ee^(-tau H), m) mel(m, hat(c)^dagger_sigma, n) \
  //   & = -1 / cal(Z) sum_(n, m) ee^((tau - beta) E_n) ee^(-tau E_m) mel(n, hat(c)_sigma, m) mel(m, hat(c)^dagger_sigma, n) \
  // $
]

==

#problem[
  Fourier transform the imaginary-time Green's function $G_sigma (tau)$ to Matsubara space to get $G_sigma (ii omega_n) = integral_0^beta G_sigma (tau) ee^(ii omega_n tau) dd(tau)$ and determine the corresponding spectral function $A_sigma (omega)$ and the self-energy $Sigma_sigma (omega)$.
  [_Hint: to get $A_sigma (omega)$ at real frequency axis, an analytical continuation $ii omega_n -> omega + ii delta$ is required._]
  Does the system have an energy gap, and if so how large is it?
  Do we have well-defined quasiparticles in this case?
  [_Hint:_ try to determine the quasiparticle weight $Z$, effective mass $m^*$ and scattering rate $Gamma$ as defined in @eq:qpweight.]
]

#solution[
  With

  $
    n equiv expval(n_sigma) = frac(ee^(beta mu) + ee^(beta (-U + 2 mu)), 1 + 2 ee^(beta mu) + ee^(beta (-U + 2 mu)))
  $

  the Matsubara Green's function reads

  $
    G_sigma (ii omega_n) & = integral_0^beta G_sigma (tau) ee^(ii omega_n tau) dd(tau) \
                         & = frac(n, ii omega_n + mu - U) + frac(1 - n, ii omega_n + mu) \
                         & = frac(1, ii omega_n + mu - Sigma_sigma (ii omega_n))
  $

  with the self-energy

  $
    Sigma_sigma (ii omega_n) = n U + frac(n (1 - n) U^2, ii omega_n + mu - (1 - n) U).
  $

  At half-filling $mu = U/2$, $n = 1/2$, and the Green's function simplifies to

  $
    G_sigma (ii omega_n) = frac(1/2, ii omega_n - U/2) + frac(1/2, ii omega_n + U/2) = 1 / (ii omega_n - U^2 / (4 ii omega_n))
  $

  with self-energy

  $
    Sigma_sigma (ii omega_n) = U/2 + frac(U^2, 4 ii omega_n).
  $

  The spectral function is

  $
    A_sigma (omega) & = -1 / pi Im G_sigma (omega + ii delta) \
                    & = n L_(U - mu)(omega) + (1 - n) L_(-mu)(omega),
  $

  with the Lorentzian

  $
    L_(x_0)(x) = 1 / pi frac(delta, (x - x_0)^2 + delta^2).
  $


  #let lorentzian(x0, delta) = x => (
    1 / calc.pi * delta / (calc.pow(x - x0, 2) + calc.pow(delta, 2))
  )

  #let particlenumber(U, mu) = (
    (
      calc.exp(mu) + calc.exp(-U + 2 * mu)
    )
      / (
        1 + 2 * calc.exp(mu) + calc.exp(-U + 2 * mu)
      )
  )

  #let spectral(U, dm, delta) = {
    let mu = dm + U / 2
    let n = particlenumber(U, mu)
    omega => (
      n * lorentzian(U - mu, delta)(omega) + (1 - n) * lorentzian(-mu, delta)(omega)
    )
  }

  For plots, we use $Delta mu = mu - U/2$ and set $beta U = 1$ and $beta delta = 10^(-9)$.

  #figure(
    plot(
      width: 8,
      height: 5,

      xmin: -4.0,
      xmax: 4.0,
      ymin: 0.0,
      ymax: 350000000.0,

      // axis-x-extend: (0, 0),
      // axis-y-extend: (0, 0),

      xlabel: $beta omega$,
      ylabel: $beta^(-1) A_sigma (omega)$,

      // xtick: (0, 1),
      // xtick-labels: ($0$, $beta$),
      ytick: (-0.5, 0),
      // ytick-labels: ($-1/2$, $0$),

      // let n = particlenumber(1, -4 + 1/2),

      (
        fn: spectral(1, -3, 0.000000001),
        stroke: blue + 1.2pt,
        label: $beta Delta mu = -3$,
        label-pos: 0.96,
        label-side: "above",
        samples: 1000,
        domain: (-5, 5),
      ),
      (
        fn: spectral(1, 0, 0.000000001),
        stroke: red + 1.2pt,
        label: $beta Delta mu = 0$,
        label-pos: 0.5,
        label-side: "above",
        samples: 1000,
        domain: (-5, 5),
      ),
      (
        fn: spectral(1, 3, 0.000000001),
        stroke: green + 1.2pt,
        label: $beta Delta mu = 3$,
        label-pos: 0.05,
        label-side: "above",
        samples: 1000,
        domain: (-5, 5),
      ),
    ),
    caption: [
      Spectral function $A_sigma (omega)$ plotted against $omega$ for several values of $beta Delta mu$.
    ],
  )

  The self-energy in real frequency is

  $
    Sigma_sigma (omega) = n U + frac(n (1 - n) U^2, omega + ii delta + mu - (1 - n) U)
  $

  #let reselfenergy(U, dm, delta) = {
    let mu = dm + U / 2
    let n = particlenumber(U, mu)
    omega => {
      let redenom = omega + mu - (1 - n) * U
      let imdenom = delta
      n * U + (n * (1 - n) * calc.pow(U, 2)) * redenom / (calc.pow(redenom, 2) + calc.pow(imdenom, 2))
    }
  }

  #let imselfenergy(U, dm, delta) = {
    let mu = dm + U / 2
    let n = particlenumber(U, mu)
    omega => {
      let redenom = omega + mu - (1 - n) * U
      let imdenom = delta
      (n * (1 - n) * calc.pow(U, 2)) * (-imdenom) / (calc.pow(redenom, 2) + calc.pow(imdenom, 2))
    }
  }

  #figure(
    plot(
      width: 8,
      height: 5,

      xmin: -4.0,
      xmax: 4.0,
      ymin: -1.0,
      ymax: 2.0,

      // axis-x-extend: (0, 0),
      // axis-y-extend: (0, 0),

      xlabel: $beta omega$,
      ylabel: $beta Re Sigma_sigma (omega)$,

      // xtick: (0, 1),
      // xtick-labels: ($0$, $beta$),
      // ytick: (-0.5, 0),
      // ytick-labels: ($-1/2$, $0$),

      (
        fn: reselfenergy(1, -3, 0.000000001),
        stroke: blue + 1.2pt,
        label: $beta Delta mu = -3$,
        label-pos: 0.96,
        label-side: "above",
        samples: 1000,
        domain: (-5, 5),
      ),
      (
        fn: reselfenergy(1, 0, 0.000000001),
        stroke: red + 1.2pt,
        label: $beta Delta mu = 0$,
        label-pos: 0.5,
        label-side: "above",
        samples: 1000,
        domain: (-5, 5),
      ),
      (
        fn: reselfenergy(1, 3, 0.000000001),
        stroke: green + 1.2pt,
        label: $beta Delta mu = 3$,
        label-pos: 0.04,
        label-side: "above",
        samples: 1000,
        domain: (-5, 5),
      ),
    ),
    caption: [
      Real part of the self-energy $Re Sigma_sigma (omega)$ plotted against $omega$ for several values of $beta Delta mu$.
    ],
  )

  #figure(
    plot(
      width: 8,
      height: 5,

      xmin: -4.0,
      xmax: 4.0,
      ymin: -0.9,
      ymax: 0.1,

      // axis-x-extend: (0, 0),
      axis-y-extend: (0, 0),

      xlabel: $beta omega$,
      ylabel: $beta Im Sigma_sigma (omega)$,

      // xtick: (0, 1),
      // xtick-labels: ($0$, $beta$),
      // ytick: (-0.5, 0),
      // ytick-labels: ($-1/2$, $0$),

      (
        fn: imselfenergy(1, -3, 0.0001),
        stroke: blue + 1.2pt,
        label: $beta Delta mu = -3$,
        label-pos: 0.9,
        label-side: "above",
        samples: 1000,
        domain: (-5, 5),
      ),
      (
        fn: imselfenergy(1, 0, 0.0001),
        stroke: red + 1.2pt,
        label: $beta Delta mu = 0$,
        label-pos: 0.5,
        label-side: "left",
        samples: 1000,
        domain: (-5, 5),
      ),
      (
        fn: imselfenergy(1, 3, 0.0001),
        stroke: green + 1.2pt,
        label: $beta Delta mu = 3$,
        label-pos: 0.1,
        label-side: "above",
        samples: 1000,
        domain: (-5, 5),
      ),
    ),
    caption: [
      Imaginary part of the self-energy $Im Sigma_sigma (omega)$ plotted against $omega$ for several values of $beta Delta mu$.
    ],
  )

  In the limit $delta -> 0^+$, the Lorentzians become delta distributions.
  For $0 < mu < U$, the Fermi level lies in the gap between the two Hubbard peaks.
  The full spectral gap between the two delta peaks is

  $
    Delta_"gap" = U,
  $

  but the distance from the Fermi level to the nearest spectral excitation is

  $
    Delta_"exc" = min(mu, U - mu).
  $

  Without broadening, $Re Sigma(omega) = n U + (n (1 - n) U^2) / (omega + mu - (1 - n) U)$ and we get quasiparticle weight

  $
    Z & = [1 - evaluated(pdv(Re Sigma(omega), omega))_(omega -> 0)]^(-1) \
      & = (mu - (1 - n) U)^2 / (mu^2 - 2 mu (1 - n) U + (1 - n) U^2).
  $

  Also without broadening, $Im Sigma (omega) = - pi (1 - n) n U^2 delta(omega + mu - (1 - n) U)$, so the quasiparticle scattering rate is

  $
    Gamma & = evaluated(-Im Sigma(omega))_(omega -> 0) \
          & = pi (1 - n) n U^2 delta(mu - (1 - n) U).
  $

  At half-filling, $mu = U / 2$ and $n = 1/2$, so

  $
    Z = 0
    wide "and" wide
    m^* / m = Z^(-1) -> infinity
    wide "and" wide
    Gamma -> infinity
  $

  and the system is a gapped atomic-limit Mott insulator with no well-defined quasiparticles.
]
