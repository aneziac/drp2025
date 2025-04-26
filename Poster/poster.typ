#import "@local/superTemplate:0.3.0": *
#import "./template.typ": *
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

#let introduction = [
  A *pre-reflection system* for a group $G$ is a pair $(X, R)$, where $X$ is a connected simple graph on which $G$ acts by graph automorphisms, and $R$ is a subset of $G st$
  1. Each $r in R$ is an involution
  2. $R$ is closed under conjugation, that is, $forall g in G$ and $r in R$, we have $g r inv(g) in R$
  3. $R$ generates $G$
  4. For every edge $e in X exiuni r_e in R st r_e$ swaps the endpoints of $e$
  5. For every $r in R exists e in X$ which is flipped by $r$

  For each $r in R$, the *wall* $H_r$ is the set of midpoints of edges which are flipped by $r$.

  Let $I$ be a finite indexing set, let $S = {s_i}_(i in I)$ and let $M = {m_(i j)}_(i, j in I)$ be a Coxeter matrix.
  Let $ W = gen(S : (s_i s_j)^(m_(i j)) = 1 forall i\, j in I) $ be the associated Coxeter group.
  Then there is a faithful representation (called the *Tits representation*) $ rho : W -> GL_n (RR) $ where $n = |S| = |I| st$
  - for each $i in I, rho(s_i) = sigma_i$ is a linear involution with fixed set a hyperplane
  - for all $i != j$, the product $sigma_i sigma_j$ has order $m_(i j)$

  Now define a symmetric bilinear form $B$ on $V$ by $ B(e_i, e_j) = cases(-cos(pi / m_(i j)) &"if" m_(i j) "is finite" \ -1 &"if" m_(i j) = infty) $
  Note that $B(e_i, e_j) = 1$ and $B(e_i, e_j) <= 0$ if $i != j$.
  Consider the hyperplane $H_i = {v in V : B(e_i, v) = 0}$ and the map $sigma_i : V -> V$ given by $ sigma_i (v) = v - 2 B(e_i, v) e_i. $
]

#let second_section = [
  An *abstract simplicial complex* consists of a set $V$, possibly infinite, called the *vertex set*, and a collection $X$ of finite subsets of $V$, such that
  1. ${v} in X forall v in V$
  2. if $Delta in X$ and $Delta' subset.eq Delta$, then $Delta' in X$

  An element of $X$ is called a *simplex*.
  If $Delta$ is a simplex and $Delta' subset.neq Delta$, then $Delta'$ is a *face* of $Delta$.

  Note a 0-simplex is a *vertex* and a 1-simplex is an *edge*.

  Let $(W, S)$ be a Coxeter system.
  1. The pair $(W_T, T)$ is a Coxeter system for each $T subset.eq S$.
  2. For all $T subset.eq S$ and $w in W_T$ we have $ell_T (w) = ell_s (w)$, and any reduced expression for $w$ only uses letters in $T$.
  Hence $Cay(W_T, T)$ embeds isometrically as a convex subgraph of $Cay(W, S)$.
]

#let basic_construction = [
  We define the basic construction $cal(U)(W, X)$ of a geometric realization for a Coxeter system $(W, S)$.

  Let $(W, S)$ be any Coxeter system and let $X$ be a connected, Hausdorff topological space.
  A *mirror structure* on $X$ over $S$ is a collection $(X_s)_(s in S)$ where each $X_s$ is a nonempty, closed subset of $X$.
  For each $s in S$, we call $X_s$ the $s$-mirror of $X$.

  1. $X$ is the cone on $|S|$ vertices, ${sigma_s : s in S}$ (i.e., $X$ is the star graph of valence $|S|$).
    Then $X_s = {sigma_s}$.

  2. Let $X$ be the $n$ simplex where $|S| = n + 1$, with set of codimension 1 faces ${Delta_s : s in S}$.
    Set $X_s = Delta_s$.
    For example if $|S| = 3$ then $X$ is the equilateral triangle which tiles the plane.

  From now on, $X$ represents a connected, Hausdorff topological space with mirror structure $(X_s)_(s in S)$.
  To avoid degeneracy assume $exists x in X st x in.not X_s forall s in S$.
  For each point $x in X$, define $S(x) subset.eq S$ by $ S(x) = {s in S : x in X_s} $ and note this is empty for some $x in X$.

  Define a relation $sim$ on $W times X$ by $ (w, x) sim (w', x') iff x = x' "and" inv(w) w' in W_(S(x)). $

  The *basic construction* is the quotient $cal(U)(W, X) = W times X \/ sim$ equipped with the quotient topology.

  We write $[w, x]$ for the equivalence class of $(w, x)$ in $cal(U)(W, X)$.
  For example, if $x in X_s$ then $[w, x]$ contains at least $(w, x)$ and $(w s, x)$.
  Denote by $w X$ the image of ${w} times X$ in $cal(U)(W, X)$.
  A subset $w X$ of $cal(U)(W, X)$ is called a *chamber*.

  #align(center)[
    #image("assets/placeholder_diagram.png")
  ]

  We say $cal(U)(W, X)$ is *locally finite* if for every $[w, x] in cal(U)(W, X)$, there is an open neighborhood of $[w, x]$ which meets only finitely many chambers.

  The following are equivalent:
  1. The basic construction $cal(U)(W, X)$ is locally finite.
  2. For all $x in X$, the special subgroup $W_(S(x))$ is finite.
  3. For all $T subset.eq S st W_T$ is infinite, $sect_(x in T) X_t = emptyset$.
]

#let buildings = [
  A subset $T subset.eq S$ is *spherical* if the special subgroup $W_T$ is finite, in which case we say $W_T$ is a *spherical special subgroup*.

  For $s in S$, clearly $|W_{s}| = 2$ so ${s}$ is spherical, and further $W_{s} iso C_2$.
  Note since $W_emptyset$ is trivial the empty set is also spherical.

  The reason we call it "spherical" is that if $(W, S)$ is an irreducible Coxeter system with $W$ finite, then $W$ acts naturally on the sphere.

  Now consider $ {T subset.eq S : T != emptyset "and" T "is spherical"} $

  The *nerve* of $(W, S)$, denoted $L = L(W, S)$, is the simplicial complex with a simplex $sigma_T$ for each $T subset.eq S st T != emptyset$ and $W_T$ is finite.

  1. The group $W$ is finite iff the simplices in the nerve $L = L(W, S)$ are in bijection with the nonempty subsets of $S$.
    Then $L$ is just the simplex with vertex set $S$.

  2. If we have a finite dihedral group $W = gen(s\, t)$ then $L$ is an edge with vertices $s$ and $t$. If $W$ is an infinite dihedral group then $L$ consists only the vertices.

  The *chamber* $K$ is the cone on the barycentric subdivision $L'$ of the nerve $L = L(W, S)$.
  For each $s in S$, define $K_s subset K$ to be the closed star in $L'$ of the vertex $s$.

  Fix a simple system $Delta$. Let $w = s_1 dots.h.c s_r$ be any expression of $w in W$ as a product of simple reflections ($s_i = s_(alpha_i)$ with repetitions permitted). Suppose $n(w) < r$. Then there exist indices $1 lt.eq i < j lt.eq r$ satisfying:
  1. $alpha_i = (s_(i + 1) dots.h.c s_(j - 1)) alpha_j$;
  2. $s_(i + 1) s_(i + 2) dots.h.c s_j = s_i s_(i + 1) dots.h.c s_(j - 1)$;
  3. $w = s_1 dots.h.c hat(s_i) dots.h.c hat(s_j) dots.h.c s_r$ where hat denotes omission (*deletion condition*).

  Let $Pi(w) := Pi cap w^(-1) (- Pi)$ and let $
    beta_i
      &:= s_r s_(r - 1) dots.h.c s_(i + 1) (alpha_i), quad
    beta_r
      &:= alpha_r
  $ where $w = s_1 dots.h.c s_r$ is a reduced expression and $s_i = s_(alpha_i)$. Then $Pi(w) = {beta_1, ..., beta_r}$ where $beta_i$ is distinct.

  Let $w = s_1 dots.h.c s_r$, where each $s_i$ is a simple reflection. If $ell(w s) < ell(w)$ for some simple reflection $s = s_alpha$, then there exists an index $i$ for which $w s = s_1 dots.h.c hat(s_i) dots.h.c s_r$. In particular, $w$ has a reduced expression ending in $s$ if and only if $ell(w s) < ell(w)$.

  For a given simple system $Delta$ let $S$ be the set of simple reflections $s_alpha, alpha in Delta$. For any subset $I subset.eq S$ define $W_I$ to be the subgroup of $W$ generated by all $s_alpha in I$ and let $Delta_I := {alpha in Delta | s_alpha in I}$. $W_I$ is called a *parabolic subgroup*.

  Note that $Delta -> w Delta$ then we have $W_I -> w W_I w^(-1)$.

  Fix a simple system $Delta$ and the corresponding set $S$ of simple reflections. Let $I subset.eq S$, and define $Phi_I$ to be the intersection of $Phi$ with the $RR$-span $V_I$ of $Delta_I$ in $V$.
  1. $Phi_I$ is a root system in $V$ (resp. $V_I$) with simplie system $Delta_I$ and with corresponding reflection group $W_I$ (resp $W_I$ restricted to $V_I$).
  2. Viewing $W_I$ as a reflection group, with length function $ell_I$ relative to the simple system $Delta_I$, we have $ell = ell_I$ on $W_I$.
  3. Define $W^I := {w in W | ell(w s) > ell(w) "for all" s in I}$. Given $w in W$, there is a unique $u in W^I$ and a unique $v in W_I$ such that $w = u v$. Their lengths satisfy $ell(w) = ell(u) + ell(v)$. Moreover, $u$ is the unique element of smallest length in the coset $w W_I$.
]

#pad(
  grid(
    columns: 3,
    inset: 0.5in,
    gutter: 30pt,
    [
      #poster_section("Introduction", introduction)
      #v(3em)
      #poster_section("Second Section", second_section, fill: true)
    ],
    [
      #poster_section("Basic Construction", basic_construction)
    ],
    [
      #poster_section("Buildings", buildings, fill: true)
    ]
  ),
  top: 0.5in,
  x: 1in,
)
