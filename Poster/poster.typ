#import "@local/superTemplate:0.3.0": *
#import "./template.typ": *
#import "./colors.typ": *
#import "@preview/cetz:0.3.0": canvas, draw
#import "@preview/mannot:0.3.0": *
#import math_mod: *

#show: poster.with(
  "Basic Construction of Coxeter Groups",
  "Nate Annau and Jesse Cobb",
  "Benedict Lee",
  "University of California, Santa Barbara"
)

#set par(justify: true)
#set text(
  size: 24pt,
)
#show math.equation: set text(font: "New Computer Modern Math")



#let geom_pt(coords, label, fill_color, anchor, filled: true) = {
  let label_text
  if filled {
    label_text = markhl(text(label, fill: fill_color), fill: bgcolor1.transparentize(20%))
  } else {
    label_text = text(fill: fill_color)[#label]
  }

  draw.on-layer(
    0,
    draw.circle(coords, radius: (0.05, 0.05), fill: fill_color)
  )
  draw.on-layer(
    1,
    draw.content(
      coords,
      label_text,
      anchor: anchor,
      padding: .15,
      name: "text"
    )
  )
  draw.content(coords, [], anchor: anchor, padding: .1)
}

#let K_0(pos, refx: false, refy: false, label: []) = {
  import draw: *

  return group({
    let (x, y) = pos
    translate(x: x, y: y)
    if(refx) {
      scale(x: -1)
      rotate(calc.pi/2)
    }
    if(refy) {
      scale(y: -1)
      rotate(calc.pi/2)
    }
    let (s0, s1, s2, s3) = ((-1/2, -1/2), (1/2, -1/2), (1/2, 1/2), (-1/2, 1/2))
    let (s01, s12, s23, s30) = ((0, -1), (1, 0), (0, 1), (-1, 0))
    let eset = (0, 0)

    merge-path(fill: cfill, {
      line(s0, s01)
      line(s01, s1)
      line(s1, s12)
      line(s12, s2)
      line(s2, s23)
      line(s23, s3)
      line(s30, s0)
    })

    line(eset, s0)
    line(eset, s01)
    line(eset, s1)
    line(eset, s12)
    line(eset, s2)
    line(eset, s23)
    line(eset, s3)
    line(eset, s30)
    line(eset, s0)

    line(s30, s01, stroke: ccolor0 + 0.1em)
    line(s01, s12, stroke: ccolor1 + 0.1em)
    line(s12, s23, stroke: ccolor2 + 0.1em)
    line(s23, s30, stroke: ccolor3 + 0.1em)

    geom_pt(s0, [], ccolor0, "north-east")
    geom_pt(s1, [], ccolor1, "north-west")
    geom_pt(s2, [], ccolor2, "south-west")
    geom_pt(s3, [], ccolor3, "south-east")

    geom_pt(s01, [], black, "north")
    geom_pt(s12, [], black, "west")
    geom_pt(s23, [], black, "south")
    geom_pt(s30, [], black, "east")

    geom_pt(eset, label, black, "center")
  })
}

#let K_1(pos, rad, reflect: false, label: []) = {
  import draw: *

  let label_anchor = "south"
  let inc = calc.pi / 8
  if(inc <= rad and rad < 3 * inc) {
    label_anchor = "south-east"
  } else if(3 * inc <= rad and rad < 5 * inc) {
    label_anchor = "east"
  } else if(5 * inc <= rad and rad < 7 * inc) {
    label_anchor = "north-east"
  } else if(7 * inc <= rad and rad < 9 * inc) {
    label_anchor = "north"
  } else if(9 * inc <= rad and rad < 11 * inc) {
    label_anchor = "north-west"
  } else if(11 * inc <= rad and rad < 13 * inc) {
    label_anchor = "west"
  } else if(13 * inc <= rad and rad < 15 * inc) {
    label_anchor = "south-west"
  }

  let height = calc.sqrt(3)/2

  return group({
    let (x, y) = pos
    translate(x: x, y: y)
    rotate(rad)
    if(reflect) {
      scale(x: -1)
    }

    let (s, t, u) = ((1/2, height), (- 1/2, height), (0, 2 * height))
    let st = (0, 0)
    let eset = (0, height)

    merge-path(fill: cfill, {
      line(s, st)
      line(st, t)
      line(t, eset)
      line(eset, s)
    })

    line(eset, u)
    line(eset, st)

    line(s, st, stroke: ccolor0 + 0.1em)
    line(t, st, stroke: ccolor1 + 0.1em)

    geom_pt(s, [], ccolor0, "south-east")
    geom_pt(t, [], ccolor1, "south-west")
    geom_pt(u, [], ccolor2, "north")

    geom_pt(st, [], black, "south")
    geom_pt(eset, label, black, label_anchor)
  })
}

#let threetree(n) = {
  import draw: *

  let colors_list = (
    none, interp1, interp2, interp3, ccolor1
  )

  let color = colors_list.at(n)

  let inner_ring_base_angle = calc.pi / (3 * calc.pow(2, n - 1))
  let inner_ring_inc_angle = 2 * calc.pi / (3 * calc.pow(2, n - 1))
  let outer_ring_base_angle = calc.pi / (3 * calc.pow(2, n))
  let outer_ring_inc_angle = 2 * calc.pi / (3 * calc.pow(2, n))

  for x in std.range(0, 3 * calc.pow(2, n - 1)) {
    let inner = (
      n * calc.cos(inner_ring_base_angle + inner_ring_inc_angle * x),
      n * calc.sin(inner_ring_base_angle + inner_ring_inc_angle * x)
    )
    let outer1 = (
      (n + 1) * calc.cos(outer_ring_base_angle + outer_ring_inc_angle * (2 * x)),
      (n + 1) * calc.sin(outer_ring_base_angle + outer_ring_inc_angle * (2 * x))
    )
    let outer2 = (
      (n + 1) * calc.cos(outer_ring_base_angle + outer_ring_inc_angle * (2 * x + 1)),
      (n + 1) * calc.sin(outer_ring_base_angle + outer_ring_inc_angle * (2 * x + 1))
    )

    on-layer(
      0, {
        line(inner, outer1, stroke: color + 0.15em)
        line(inner, outer2, stroke: color + 0.15em)
      }
    )

    on-layer(
      1, {
        circle(inner, radius: (0.1, 0.1), fill: color, stroke: none)

        // double add just to make things easier for last layer
        circle(outer1, radius: (0.1, 0.1), fill: color, stroke: none)
        circle(outer2, radius: (0.1, 0.1), fill: color, stroke: none)
      }
    )
  }
}



#let coxeter_systems = [
  *Dihedral groups*#h(-0.3em), well known from elementary group theory, encode the symmetries of regular polygons.
  For example, the square admits eight fundamental symmetries: reflections through its horizontal and vertical axes and two diagonals, and rotations through 90, 180, and 270 degrees.

  #align(center + horizon)[
    #grid(
      columns: 3,
      gutter: 2em,
      canvas(length: 3cm, {
        import draw: *

        let (s0, s1, s2, s3) = ((0, 0), (1, 0), (1, 1), (0, 1))

        merge-path(stroke: 1.5pt, {
          line(s0, s1)
          line(s1, s2)
          line(s2, s3)
          line(s3, s0)
        })

        line((0.5, -0.25), (0.5, 1.25), stroke: (dash: "dashed", thickness: 2pt))
        line((-0.25, 0.5), (1.25, 0.5), stroke: (dash: "dashed", thickness: 2pt))
        line((-0.25, -0.25), (1.25, 1.25), stroke: (dash: "dashed", thickness: 2pt))
        line((-0.25, 1.25), (1.25, -0.25), stroke: (dash: "dashed", thickness: 2pt))

        arc-through((1.5, 0.7), (1.4, 0.85), (1.4, 0.8), mark: (end: "stealth", fill: black))
        arc-through((-0.5, 0.7), (-0.4, 0.85), (-0.4, 0.8), mark: (end: "stealth", fill: black))
      }),
      [
        $D_8 = gen(r\, s | r^4 = s^2 = (s r)^2 = 1)$
      ],
      canvas(length: 2cm, {
        import draw: *

        let base_angle = 0
        let inc_angle = calc.pi / 4
        let pos(n) = (
          { (calc.cos(base_angle + inc_angle * n), calc.sin(base_angle + inc_angle * n)) }
        )

        let nums = std.range(0, 8)
        let (s0, s1, s2, s3, s4, s5, s6, s7) = nums.map(pos)

        line(s0, s1, stroke: ccolor0 + 3pt)
        line(s1, s2, stroke: ccolor1 + 3pt)
        line(s2, s3, stroke: ccolor0 + 3pt)
        line(s3, s4, stroke: ccolor1 + 3pt)
        line(s4, s5, stroke: ccolor0 + 3pt)
        line(s5, s6, stroke: ccolor1 + 3pt)
        line(s6, s7, stroke: ccolor0 + 3pt)
        line(s7, s0, stroke: ccolor1 + 3pt)

        geom_pt(s0, $t s$, ccolor0, "west", filled: false)
        geom_pt(s1, $t$, ccolor0, "west", filled: false)
        geom_pt(s2, $e$, ccolor0, "south-west", filled: false)
        geom_pt(s3, $s$, ccolor0, "south-east", filled: false)
        geom_pt(s4, $s t$, ccolor0, "south-east", filled: false)
        geom_pt(s5, $s t s$, ccolor0, "east", filled: false)
        geom_pt(s6, $s t s t = t s t s$, ccolor0, "north", filled: false)
        geom_pt(s7, $t s t$, ccolor0, "west", filled: false)
      })
    )
  ]

  Through the transformation $t := s r$, we can describe this group purely in terms of reflections, which gives rise to the notion of a *geometric reflection group*#h(-0.27em)---#h(0em)a more generic group generated by reflections across a particular set of hyperplanes $cal(H)_i$ acting on Euclidean, hyperbolic, or spherical spaces.
  Abstracting this further, beyond purely geometric considerations, produces the *Coxeter group*#h(-0.3em), defined by the presentation
  $
    W = gen(s_1\, s_2\, dots\, s_n | (s_i s_j)^(m_(i j)) = 1)
  $
  where $m_(i i) = 1$ and $m_(i j) = m_(j i) in {2, 3, dots} union {infty}$ for all distinct $i, j$.
  // Observe this definition implies each generator $s_i$ is an involution and thus corresponds to a reflection.

  Denoting the indexing set ${s_i}$ by $S$, we define a *Coxeter System* as the pair $(W, S)$.

  Importantly, for some $T subset.eq S$, define the *parabolic subgroup* $W_T$ of $W$ by $W_T = gen(T)$; it is easy to show that $(W_T, T)$ is a Coxeter System as well.
]

#let chambers_and_nerves = [
  #pad(bottom: 0.2cm)[
  Let $(W, S)$ be a Coxeter system. Let $
    W^((0))
      &= angle.l s_0, s_1, s_2, s_3 bar.v s_i^2 = (s_i s_(i + 1))^2 = 1, forall i in ZZ_4 angle.r \
    W^((1))
      &= angle.l s, t, u bar.v s^2 = t^2 = u^2 = 1; (s t)^3 = 1 angle.r iso D_6 * C_2.
  $]
  #grid(
    columns: 2,
    [
      - An *abstract simplicial complex* is a set $V$, called the _vertex set_, and a collection $X$ of finite subsets of $V$ such that ${v} in X forall v in V$, and when $Delta in X "with" Delta' subset.eq Delta, "we have" Delta' in X$

      - The *nerve* of $(W, S)$, denoted $L = L(W, S)$, is the simplicial complex with a simplex $sigma_T$ for each $T subset.eq S$ such that $T eq.not emptyset$ and $W_T$ is finite

      - Let $L'$ be the *barycentric subdivision* of $L$

      - The *chamber* $K$ is the cone on the $L'$. For each $s in S$, we can define the closed star in $L'$ of the vertex $s$ to be $K_s subset.eq K$

      - The point added by the cone is the empty set $emptyset$ in the simplicial complex
    ],
    gutter: 2em,
    align(center + horizon)[#grid(
      columns: 2,
      row-gutter: 0.7cm,
      column-gutter: 1cm,
      canvas(length: 2cm, {
        import draw: *
        let (s0, s1, s2, s3) = ((0, 0), (1, 0), (1, 1), (0, 1))

        merge-path(fill: none, {
          line(s0, s1)
          line(s1, s2)
          line(s2, s3)
          line(s3, s0)
        })

        geom_pt(s0, $s_0$, ccolor0, "north-east")
        geom_pt(s1, $s_1$, ccolor1, "north-west")
        geom_pt(s2, $s_2$, ccolor2, "south-west")
        geom_pt(s3, $s_3$, ccolor3, "south-east")
      }),
      canvas(length: 2cm, {
        import draw: *
        let val = calc.sqrt(3)/2
        let (s, t, u) = ((-1/2, val), (1/2, val), (0, 0))

        merge-path(fill: none, {
          line(s, t)
        })

        geom_pt(s, $s$, ccolor0, "south-east")
        geom_pt(t, $t$, ccolor1, "south-west")
        geom_pt(u, $u$, ccolor2, "north")
      }),
      [$L(W^((0)))$], [$L(W^((1)))$],
      canvas(length: 2cm, {
        import draw: *
        let (s0, s1, s2, s3) = ((0, 0), (1, 0), (1, 1), (0, 1))
        let (s01, s12, s23, s30) = ((1/2, -1/2), (1 + 1/2, 1/2), (1/2, 1 + 1/2), (- 1/2, 1/2))

        merge-path(fill: none, {
          line(s0, s01)
          line(s01, s1)
          line(s1, s12)
          line(s12, s2)
          line(s2, s23)
          line(s23, s3)
          line(s30, s0)
        })

        geom_pt(s0, $s_0$, ccolor0, "north-east")
        geom_pt(s1, $s_1$, ccolor1, "north-west")
        geom_pt(s2, $s_2$, ccolor2, "south-west")
        geom_pt(s3, $s_3$, ccolor3, "south-east")

        geom_pt(s01, ${s_0, s_1}$, ccolor4, "north")
        geom_pt(s12, ${s_1, s_2}$, ccolor5, "west")
        geom_pt(s23, ${s_2, s_3}$, ccolor6, "south")
        geom_pt(s30, ${s_0, s_3}$, ccolor7, "east")
      }),
      canvas(length: 2cm, {
        import draw: *
        let val = calc.sqrt(3)/2
        let (s, t, u) = ((-1/2, val), (1/2, val), (0, 0))
        let st = (0, 2 * val)

        merge-path(fill: none, {
          line(s, st)
          line(st, t)
        })

        geom_pt(s, $s$, ccolor0, "south-east")
        geom_pt(t, $t$, ccolor1, "south-west")
        geom_pt(u, $u$, ccolor2, "north")

        geom_pt(st, ${s, t}$, ccolor4, "south")
      }),
      [$L'(W^((0)))$], [$L'(W^((1)))$],
      canvas(length: 2cm, {
        import draw: *
        let (s0, s1, s2, s3) = ((0, 0), (1, 0), (1, 1), (0, 1))
        let (s01, s12, s23, s30) = ((1/2, -1/2), (1 + 1/2, 1/2), (1/2, 1 + 1/2), (- 1/2, 1/2))
        let eset = (1/2, 1/2)

        merge-path(fill: cfill, {
          line(s0, s01)
          line(s01, s1)
          line(s1, s12)
          line(s12, s2)
          line(s2, s23)
          line(s23, s3)
          line(s30, s0)
        })

        line(eset, s0)
        line(eset, s01)
        line(eset, s1)
        line(eset, s12)
        line(eset, s2)
        line(eset, s23)
        line(eset, s3)
        line(eset, s30)
        line(eset, s0)

        line(s30, s01, stroke: ccolor0 + 0.1em)
        line(s01, s12, stroke: ccolor1 + 0.1em)
        line(s12, s23, stroke: ccolor2 + 0.1em)
        line(s23, s30, stroke: ccolor3 + 0.1em)

        geom_pt(s0, $K_(s_0)$, ccolor0, "north-east")
        geom_pt(s1, $K_(s_1)$, ccolor1, "north-west")
        geom_pt(s2, $K_(s_2)$, ccolor2, "south-west")
        geom_pt(s3, $K_(s_3)$, ccolor3, "south-east")

        geom_pt(s01, [], black, "north")
        geom_pt(s12, [], black, "west")
        geom_pt(s23, [], black, "south")
        geom_pt(s30, [], black, "east")

        geom_pt(eset, $emptyset$, black, "north-west")
      }),
      canvas(length: 2cm, {
        import draw: *
        let val = calc.sqrt(3)/2
        let (s, t, u) = ((-1/2, val), (1/2, val), (0, 0))
        let st = (0, 2 * val)
        let eset = (0, val)

        merge-path(fill: cfill, {
          line(s, st)
          line(st, t)
          line(t, eset)
          line(eset, s)
        })

        line(eset, u)
        line(eset, st)

        line(s, st, stroke: ccolor0 + 0.1em)
        line(t, st, stroke: ccolor1 + 0.1em)

        geom_pt(s, $K_s$, ccolor0, "south-east")
        geom_pt(t, $K_t$, ccolor1, "south-west")
        geom_pt(u, $K_u$, ccolor2, "north")

        geom_pt(st, [], black, "south")
        geom_pt(eset, $emptyset$, black, "north-west")
      }),
      [$K(W^((0)))$], [$K(W^((1)))$],
    )]
  )
]

#let basic_construction = [
  We wish to realize a Coxeter group, returning it to its geometric origins.
  This is the idea behind the *basic construction* $cal(U)(W, X)$.

  We begin with some additional definitions.
  If $(W, S)$ is a Coxeter system and $X$ is a connected and Hausdorff topological space, define a *mirror structure* on $X$ over $S$ by a collection $(X_s)_(s in S)$, where each $X_s$ is a nonempty, closed subset of $X$.
  Call each $X_s$ the $s$-mirror of $X$.
  The idea is to "glue" copies of $X$ along the mirrors.

  For each point $x in X$, define $S(x) subset.eq S$ by $S(x) := {s in S : x in X_s}$.
  Define a relation $sim$ on $W times X$ by
  $
    (w, x) sim (w', x') "if and only if" x = x' "and" inv(w) w' in W_(S(x)).
  $
  Now the basic construction is the quotient
  $
    cal(U)(W, X) = W times X \/ sim
  $
  equipped with the quotient topology.
  We then define the *Davis complex* $Sigma(W, S)$ as $
    Sigma(W, S)
      &= cal(U) (W, K)
  $ where $K$ is a chamber with the mirror structures $(K_s)_(s in S)$ as defined previously.

  #align(center + horizon)[#grid(
    columns: (1fr, 1fr),
    row-gutter: 1cm,
    [#canvas(length: 2cm, {
      import draw: *

      let pos = (0, 0)
      let d = 1
      K_0(pos, label: $K$)

      let pos = (- d, - d)
      K_0(pos, refy: true, label: $s_0 K$)

      let pos = (d, - d)
      K_0(pos, refx: true, label: $s_1 K$)

      let pos = (d, d)
      K_0(pos, refy: true, label: $s_2 K$)

      let pos = (- d, d)
      K_0(pos, refx: true, label: $s_3 K$)

      let pos = (0, - 2 * d)
      K_0(pos, refx: true, refy: true, label: $s_0 s_1 K$)

      let pos = (2 * d, 0)
      K_0(pos, refx: true, refy: true, label: $s_1 s_2 K$)

      let pos = (2 * d, - 2 * d)
      K_0(pos, label: $s_1 s_3 K$)
    })],
    [#canvas(length: 2cm, {
      import draw: *

      let height = calc.sqrt(3)/2
      let rot = calc.pi/3
      let pos_finder(itr) = (calc.sin(itr * rot) * 4 * height, calc.cos(itr * rot) * 4 * height)

      let pos = (0, 0)
      K_1(pos, 0 * rot, label: $K$)
      K_1(pos, 1 * rot, reflect: true, label: $t K$)
      K_1(pos, 2 * rot, label: $t s K$)
      K_1(pos, 3 * rot, reflect: true, label: $t s t K$)
      K_1(pos, 4 * rot, label: $s t K$)
      K_1(pos, 5 * rot, reflect: true, label: $s K$)

      let pos = pos_finder(0)
      K_1(pos, 2 * rot)
      K_1(pos, 3 * rot, reflect: true)
      K_1(pos, 4 * rot)

      let pos = pos_finder(1)
      K_1(pos, 2 * rot)

      let pos = pos_finder(2)
      K_1(pos, 1 * rot, reflect: true)

      let pos = pos_finder(3)
      K_1(pos, 5 * rot, reflect: true)
      K_1(pos, 0 * rot)
      K_1(pos, 1 * rot, reflect: true)

      let pos = pos_finder(4)
      K_1(pos, 5 * rot, reflect: true)

      let pos = pos_finder(5)
      K_1(pos, 4 * rot)
    })],
    [$cal(U) (W^((0)), K(W^((0))))$],
    [$cal(U) (W^((1)), K(W^((1))))$]
  )]
]

#let tits_representation = [
  A key result due to Jacques Tits gives a faithful linear representation for $(W, S)$
  $
    rho : W -> GL_n (RR),
  $
  with $n = |S|$, such that
  - for each $i$, $rho(s_i) = sigma_i$ is a linear involution with fixed set a hyperplane
  - $forall i != j$, the product $sigma_i sigma_j$ has order $m_(i j)$

  To construct this, consider the real vector space $V$ with basis ${e_1, dots, e_n}$, and define a symmetric bilinear form $B$ on $V$ by
  $
    B(e_i, e_j) = cases(
      -cos(pi / m_(i j)) &"if" m_(i j) "is finite" \
      -1 &"if" m_(i j) = infty.
    )
  $
  Then we define $H_i = {v in V : B (e_i, v) = 0}$ and $sigma_i (v) = v - 2B(e_i, v) e_i$.
]

#let Davis_complex_CAT0 = [
  Let $(X, d)$ be a *geodesic space* (every pair of points in $X$ is connected by a geodesic) and let $[x y]$ represent the geodesic segment from $x$ to $y$.
  Given a *geodesic triangle* $Delta = [x_1 x_2] cup [x_2 x_3] cup [x_3 x_1]$ in $X$ and a *comparison triangle* $overline(Delta) = [overline(x)_1 overline(x)_2] cup [overline(x)_2 overline(x)_3] cup [overline(x)_3 overline(x)_1]$ in $EE^2$ such that $d_X (x_i, x_j) = d_(EE^2) (overline(x)_i, overline(x)_j)$, we call $(X, d)$ *$"CAT"(0)$* if for every geodesic triangle $Delta subset.eq X$, and all points $p, q in Delta$ we have $
    d_X (p, q)
      &lt.eq d_(EE^2) (overline(p), overline(q)).
  $

  We choose a collection $d = (d_s)_(s in S)$ for which $d_s > 0$ for any $s in S$.
  For finite $W_T$, we let $C_T$
  // $
  //   C_T
  //     &= {x in RR^n bar.v ip(x, e_t) gt.eq 0, forall t in T}
  // $
  be a chamber in $RR^n$ generated by the hyperplanes $H_t$ for $t in T$ as in the *Tits Representation*#h(-0.3em).
  Then we can define the unique point $x_T$ in the interior of $C_T$ such that $d(x_T, H_t) = d_t$ for all $t in T$.
  We then metrize each cell of $Sigma(W, S)$, $w W_T$, as a copy of the polytope generated by the $W_T$-orbit of $x_T$.

  Using this metric, it follows that the Davis complex is a complete $"CAT"(0)$ space.
  // This leads us to the important result that $Sigma(W, S)$ is contractible and that the *word problem* (if two words represent the same element) and *conjugacy problem* (if two words represent conjugate elements) are solvable for $W$.
]

#let buildings = [
  Let $(W, S)$ be a Coxeter system.
  If $X$ is a simplex with codimension-1 faces ${Delta_s | s in S}$ and mirror structure $(X_s)_(s in S) = Delta_s$, then we call the basic construction $cal(U)(W, X)$ the *Coxeter complex*#h(-0.3em).

  A *building of type* $(W, S)$ is a simplicial complex $Delta$ which is a union of subcomplexes called *apartments*#h(-0.4em), where each apartment is a copy of the Coxeter complex for $(W, S)$.
  With _chambers_ defined to be the maximal simplices in $Delta$, the following hold:
  1. Any two chambers are contained in a common apartment
  2. If $A$ and $A'$ are two arbitrary apartments, then there is an isomorphism $A -> A'$ which fixes $A sect A'$ pointwise

  For example, take the infinite dihedral group
  $
    W = gen(s\, t | s^2 = t^2 = 1) iso D_infty.
  $

  We claim that the 3-regular tree $T_3$, shown below, is a building of type $(W, S)$, when we take the system of apartments to be the collection of all bi-infinite lines in $T_3$.

  #align(center)[#canvas(length: 5%, {
    import draw: *

    draw.on-layer(
      0, {
        line(
          (0, 0),
          (calc.cos(calc.pi / 3), calc.sin(calc.pi / 3)),
          stroke: ccolor0 + 0.15em
        )
        line(
          (0, 0),
          (calc.cos(calc.pi), calc.sin(calc.pi)),
          stroke: ccolor0 + 0.15em
        )
        line(
          (0, 0),
          (calc.cos(-calc.pi / 3), calc.sin(-calc.pi / 3)),
          stroke: ccolor0 + 0.15em
        )
      }
    )

    draw.on-layer(
      1,
      circle((0, 0), radius: (0.1, 0.1), fill: ccolor0, stroke: none)
    )

    threetree(1)
    threetree(2)
    threetree(3)
    threetree(4)
  })]

  Observe that the first condition is satisfied since any two edges in the tree are contained in a common line.
  The second condition follows because the isomorphism $A -> A'$ does not have to be the restriction of a map $Delta -> Delta$ (although it usually will be).
  Thus $T_3$ is a building of type $(W, S)$.
]

#let acknowledgements = [
  We would like to thank our mentor, Benedict Lee, for his guidance and support in our readings.
  We also want to thank the Directed Reading Program at UCSB for this opportunity.
  Finally, we would like to thank the contributors to the open source typesetting language Typst for making this poster a joy to create.
]

#let references = [
  #bibliography("./books.bib", title: [], full: true)
]

#pad(
  grid(
    columns: 3,
    inset: 0.5in,
    gutter: 30pt,
    [
      #poster_section("Coxeter Systems", coxeter_systems)
      #poster_section("Chambers and Nerves", chambers_and_nerves, fill: true)
    ],
    [
      #poster_section("The Davis Complex as a Basic Construction", basic_construction, fill: true)
      // #poster_section("Tits Representation", tits_representation)
      #poster_section([The Davis Complex is _CAT(0)_], Davis_complex_CAT0)
    ],
    [
      #poster_section("Buildings", buildings)
      #poster_section("Acknowledgements", acknowledgements, fill: true)
      #poster_section("References", references)
    ]
  ),
  top: 0.5in,
  x: 1in,
)
