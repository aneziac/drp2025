#import "@local/superTemplate:0.3.0": *
#import "./template.typ": *
#import "@preview/cetz:0.3.0": canvas, draw
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

#let geom_pt(coords, label, fill_color, anchor) = {
  draw.circle(coords, radius: (0.05, 0.05), fill: fill_color)
  draw.content(coords, [#text(fill: fill_color)[#label]], anchor: anchor, padding: .1)
}

#let ccolor0 = orange
#let ccolor1 = maroon
#let ccolor2 = eastern
#let ccolor3 = olive

#let ccolor4 = ccolor0
#let ccolor5 = ccolor1
#let ccolor6 = ccolor2
#let ccolor7 = ccolor3

#let cfill   = olive


#let coxeter_systems = [
  #lorem(225)
]

#let chambers_and_nerves = [
  For the following $(W, S)$ is a *Coxeter system* as defined above. For the diagrams/examples we let $
    W^((0))
      &= angle.l s_0, s_1, s_2, s_3 bar.v s_i^2 = (s_i s_(i + 1))^2 = 1, forall i in ZZ_4 angle.r \
    W^((1))
      &= angle.l s, t, u bar.v s^2 = t^2 = u^2 = 1, (s t)^3 angle.r iso D_6 * C_2.
  $
  #grid(
    columns: 2,
    [
      - A *nerve* of a $(W, S)$, $L = L(W, S)$, is the simplicial complex with a simplex $sigma_T$ for each $T subset.eq S$ such that $T eq.not emptyset$ and $W_T$ is finite.
      - Let $L'$ be the *barycentric subdivision* of $L$.
      - The *chamber* $K$ is the cone on the $L'$. For each $s in S$ we can define the closed star in $L$ of the vertex $s$ to be $K_s subset.eq K$.
        - Since all simplices are represented by a nonempty set of generators we let the point added when constructing the cone to be represented by the empty set, $emptyset$.
    ],
    align(center + horizon)[#grid(
      columns: 2,
      rows: 3,
      gutter: 1em,
      [$L(W^((0)))$#canvas(length: 2cm, {
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
      })],
      [$L(W^((1)))$#canvas(length: 2cm, {
        import draw: *
        let val = calc.sqrt(3)/2
        let (s, t, u) = ((-1/2, val), (1/2, val), (0, 0))

        merge-path(fill: none, {
          line(s, t)
        })

        geom_pt(s, $s$, ccolor0, "south-east")
        geom_pt(t, $t$, ccolor1, "south-west")
        geom_pt(u, $u$, ccolor2, "north")
      })],
      [$L'(W^((0)))$#canvas(length: 2cm, {
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
      })],
      [$L'(W^((0)))$#canvas(length: 2cm, {
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
      })],
      [$K(W^((0)))$#canvas(length: 2cm, {
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

        geom_pt(s0, $K_(s_0)$, ccolor0, "north-east")
        geom_pt(s1, $K_(s_1)$, ccolor1, "north-west")
        geom_pt(s2, $K_(s_2)$, ccolor2, "south-west")
        geom_pt(s3, $K_(s_3)$, ccolor3, "south-east")

        geom_pt(s01, [], ccolor4, "north")
        geom_pt(s12, [], ccolor5, "west")
        geom_pt(s23, [], ccolor6, "south")
        geom_pt(s30, [], ccolor7, "east")

        geom_pt(eset, $emptyset$, black, "north-west")
      })],
      [$K(W^((1)))$#canvas(length: 2cm, {
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

        geom_pt(s, $K_s$, ccolor0, "south-east")
        geom_pt(t, $K_t$, ccolor1, "south-west")
        geom_pt(u, $K_u$, ccolor2, "north")

        geom_pt(st, [], ccolor4, "south")
        geom_pt(eset, $emptyset$, black, "north-west")
      })],
    )]
  )
]

#let basic_construction = [
  #lorem(600)
]

#let Davis_complex_CAT0 = [
  #lorem(400)
]

#let acknowledgements = [
  #lorem(25)
]

#let references = [
  #lorem(25)
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
      #poster_section("Basic Construction", basic_construction)
    ],
    [
      #poster_section([The Davis Complex is $"CAT"(0)$], Davis_complex_CAT0, fill: true)
      #poster_section("Acknowledgements", acknowledgements)
      #poster_section("References", references, fill: true)
    ]
  ),
  top: 0.5in,
  x: 1in,
)

