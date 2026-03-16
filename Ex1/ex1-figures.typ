#import "@preview/simple-plot:0.3.0": line-plot, plot
#import "../exercise-style.typ": accent, plot-gray, soft

#let load-curve(path) = {
  let rows = csv(path, row-type: dictionary)
  rows.map(r => (
    float(r.at("x")),
    float(r.at("rho")),
  ))
}

#let continuum_dos_plot() = align(center)[
  #plot(
    width: 6,
    height: 4,
    xmin: 0.0,
    xmax: 4.0,
    ymin: 0.0,
    ymax: 2.4,
    show-grid: "none",
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

#let lattice_dos_plot() = {
  let c1 = load-curve("dos-data/dos_1d.csv")
  let c2 = load-curve("dos-data/dos_2d.csv")
  let c3 = load-curve("dos-data/dos_3d.csv")

  align(center)[
    #plot(
      width: 7.7,
      height: 4.7,
      xmin: -6.7,
      xmax: 6.7,
      ymin: 0,
      ymax: 0.28,
      xtick: (-6, -4, -2, 0, 2, 4, 6),
      xtick-labels: ($-6$, $-4$, $-2$, $0$, $2$, $4$, $6$),
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
        label-pos: 0.9,
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
}

#let half_filled_fermi_surface_pair() = grid(
  columns: (1fr, 1fr),
  gutter: 1.1em,

  block(width: 100%, height: 170pt)[
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
  ],

  block(width: 100%, height: 170pt)[
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
          (
            (0.0, calc.pi),
            (calc.pi, 0.0),
            (0.0, -calc.pi),
            (-calc.pi, 0.0),
            (0.0, calc.pi),
          ),
          stroke: accent,
          mark: "none",
        ),
      )
    ]
  ],
)
