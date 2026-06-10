#import "../exercise-style.typ": *
#import "@preview/unify:0.7.1": num, numrange, qty, qtyrange
#import "@preview/simple-plot:0.3.0": plot
// #import "@preview/inknertia:0.1.0": feynman
// #import feynman: *
#import "feynman-preamble.typ": *

#show: exercise-sheet.with(
  "QFT for Many-Body Systems",
  4,
  author: "Samuel Badr",
  semester: "Sommersemester 2026",
  tutorial: "TUTORIUM: Friday, 8.05.2026.",
  title-suffix: "Exercise Sheet",
)

#let start = 7
#counter(heading).update(start - 1)

#set math.equation(numbering: "(1)")

= Linked-cluster theorem

#problem[
  As it has already been discussed in the Lecture, only _connected_ Feynman diagrams have to be considered when calculating the one-particle Green's function.
  Starting from the perturbation expansion of the Green's function at $T > 0$, show that the time-ordered average for a given order $n$ of perturbation theory decomposes into a product of connected and disconnected diagrams.
  Prove that the disconnected factor cancels exactly the denominator $Z = expval(S(beta))_0$.

  _Hint: Consider the $n$-th order term in the perturbation expansion of the numerator of the Green's function ($~ expval(T c(tau) c^dagger (0) H_V (tau_1) dots.h.c H_V (tau_n))_0$).
  According to Wick's theorem this can be written in terms of connected ($~ expval(T c(tau) c^dagger (0) H_V (tau_1) dots.h.c H_V (tau_m))_0$) and disconnected ($~ expval(T H_V (tau_(m + 1)) dots.h.c H_V (tau_n))_0$) contractions, with $m = 1, dots.h, n$._
]

#solution[
  We start with writing out the numerator for $n = 1$ (omitting the integrals etc.):

  $
    expval(cal(T) c_k (tau) c_k^dagger (0) H_V (tau_1))_0
  $

  and plug in (again omitting integrals)

  $
    H_V = 1 / (2 pi)^9 integral dd(k) integral dd(k') integral dd(q) c_(k + q)^dagger c_(k' - q)^dagger V_q / 2 c_(k') c_(k)
  $

  to get

  $
    expval(cal(T) c_k (tau) c_k^dagger (0) c_(k' + q)^dagger (tau_1) c_(k'' - q)^dagger (tau_1) V_q / 2 c_(k'') (tau_1) c_(k') (tau_1))_0.
  $

  Wick's theorem then yields $3! = 6$ terms

  $
    -[&+ delta_(k, k) && delta_(k', k'+q) && delta_(k'', k''-q) && G_0 (k, tau - 0) && G_0 (k', tau_1 - tau_1) && G_0 (k'', tau_1 - tau_1) \
      &- delta_(k, k) && delta_(k', k''-q) && delta_(k'', k'+q) && G_0 (k, tau - 0) && G_0 (k', tau_1 - tau_1) && G_0 (k'', tau_1 - tau_1) \
      &+ delta_(k, k'+q) && delta_(k', k''-q) && delta_(k'', k) && G_0 (k, tau - tau_1) && G_0 (k', tau_1 - tau_1) && G_0 (k'', tau_1 - 0) \
      &- delta_(k, k'+q) && delta_(k', k) && delta_(k'', k''-q) && G_0 (k, tau - tau_1) && G_0 (k', tau_1 - 0) && G_0 (k'', tau_1 - tau_1) \
      &+ delta_(k, k''-q) && delta_(k', k) && delta_(k'', k'+q) && G_0 (k, tau - tau_1) && G_0 (k', tau_1 - 0) && G_0 (k'', tau_1 - tau_1) \
      &- delta_(k, k''-q) && delta_(k', k'+q) && delta_(k'', k) && G_0 (k, tau - tau_1) && G_0 (k', tau_1 - tau_1) && G_0 (k'', tau_1 - 0)] \
    & times V_q / 2 \
    =
    - 1/2 [&+ sum_(k',k'') V_0 && G_0 (k, tau) && n_(k') && n_(k'') \
      &- sum_(k',k'') V_(k'' - k') && G_0 (k, tau) && n_(k') && n_(k'') \
      &+ sum_(k') V_(k - k') && G_0 (k, tau - tau_1) && n_(k') && G_0 (k, tau_1) \
      &- sum_(k'') V_0 && G_0 (k, tau - tau_1) && G_0 (k, tau_1) && n_(k'') \
      &+ sum_(k'') V_(k'' - k) && G_0 (k, tau - tau_1) && G_0 (k, tau_1) && n_(k'') \
      &- sum_(k') V_0 && G_0 (k, tau - tau_1) && n_(k') && G_0 (k, tau_1)]
  $
  Writing now $n equiv sum_(k') n_(k')$, we get
  $
    n G_0 (k, tau - tau_1) [ - G_0 (k, tau_1 - tau) + G_0 (k, tau_1)]
  $

  // $
  //   expval(cal(T) c_k (tau) c_k^dagger (0) H_V (tau_1) H_V (tau_2))_0
  // $
  // and plug in (again omitting integrals)
  // $
  //   H_V = 1 / (2 pi)^9 integral dd(k) integral dd(k') integral dd(q) c_(k + q)^dagger c_(k' - q)^dagger V_q / 2 c_(k') c_(k)
  // $
  // to get
  // $
  //   expval(cal(T) c_k (tau) c_k^dagger (0) c_(k' + q)^dagger (tau_1) c_(k'' - q)^dagger (tau_1) V_q / 2 c_(k'') (tau_1) c_(k') (tau_1) c_(k''' + q')^dagger (tau_2) c_(k'''' - q')^dagger (tau_2) V_(q') / 2 c_(k'''') (tau_2) c_(k''') (tau_2))_0
  // $
]

= Feynman diagram quiz

#problem[
  Consider the following eight Feynman diagrams (for the Green's function of an interacting electronic system):

  #figure(
    {
      grid(
        columns: (3.95cm, 4.45cm, 2.40cm, 2.90cm),
        column-gutter: 0.0cm,
        row-gutter: 0.7cm,
        align: top,

        diagram-a, diagram-b, diagram-c, diagram-d,
      )

      v(0.35cm)

      grid(
        columns: (3.95cm, 2.40cm, 4.20cm, 4.15cm),
        column-gutter: 0.0cm,
        align: top,

        diagram-e, diagram-f, diagram-g, diagram-h,
      )
    },
    caption: [
      Eight Feynman diagrams of second and higher orders.
    ],
  ) <fig:eight-diagrams>
]

==

#problem[
  Classify the eight diagrams as _reducible_ or _irreducible_, specifying if they are _non-skeleton_, or _skeleton_ diagrams.
  #footnote[
    As suggested by their name, the "skeleton" diagrams are diagrams, which do not contain any self-energy insertion in the internal lines.
  ]
  Afterwards draw a new irreducible skeleton diagram of third order different from any of those appearing in @fig:eight-diagrams.
]

==

#problem[
  Are any of the diagrams shown in @fig:eight-diagrams topologically equivalent?
  If yes, which ones?
]

==

#problem[
  Calculate the numerical prefactor of all the eight diagrams shown in @fig:eight-diagrams, according to the standard Feynman rules.
]

= Second-order self-energy diagram

#problem[
  #figure(
    diagram-second-order,
    caption: [
      A second order diagram for the self-energy,
      $Sigma^((2))(bold(k), i omega_n)$.
      For the calculation consider that the incoming line has a definite spin,
      say $sigma = arrow.t$.
    ],
  ) <fig:second-order-diagram>
]

==

#problem[
  Write the explicit expression of the second-order self-energy diagram shown in @fig:second-order-diagram at $T > 0$ in terms of the Green functions on the Matsubara axis.
]

==

#problem[
  Evaluate the diagram by performing the two internal Matsubara sums.
  Discuss what is the difference between considering a generic two-particle interaction $cal(H)_V = 1 / (2 L^d) sum_(vb(k) vb(k)' vb(q) sigma sigma') V(vb(q)) c_(vb(k) + vb(q) sigma)^dagger c_(vb(k)' - vb(q) sigma')^dagger c_(vb(k)' sigma') c_(vb(k) sigma)$ and a local Hubbard interaction of the form $cal(H)_V = U sum_i n_(i arrow.t) n_(i arrow.b)$ where the sum over $i$ runs over all lattice sites and $n_(i sigma) = c_(i sigma)^dagger c_(i sigma)$.
]

==

#problem[
  Give a possible physical interpretation of the diagram.

  _Hint: this diagram may be seen as the first one of a specific "series" of diagrams, whose second term is the diagram (e) of @fig:eight-diagrams. _
]

==

#problem[
  (Bonus points)
  Calculate the imaginary part of the diagram on the real axis (in the case of the Hubbard interaction).
  From the low-$T$ and small-$omega$ limit of this quantity one can provide an estimate of the quasiparticle lifetime.
  Determine the frequency dependence of $Im Sigma^((2))$ in the low-$T$ and small-$omega$ limit.

  _Remark: The Fermi and Bose functions can be rearanged in such a way that the scattering process can be described by two terms one of which can be obtained from the other by simply reverting all momenta involved in the scattering process (particle-hole transformation).
  In this way one can identify the contributions to the scattering of electron-like and of hole-like quasiparticles._
]
