#import "@local/superTemplate:0.3.0": *
#import "@local/superTheorems:0.1.0": *
#import math_mod: *
#thmS-init.with(colors: "gruvbox_dark")
#show: notes.with("Coxeter Groups Notes", "Nate Annau")

= Introduction

== Geometric Reflection Groups

#notation([
  - The unit sphere is $SS^n$
  - Euclidean space is $EE^n$
  - Hyberbolic space is $HH^n$

  In general we denote these by $XX^n$.
])

#defn([Riemannian Manifold], [
  A geometric space on which notions like distance, angles, length, volume, and curvature are defined.

  Formally, let $M$ be a smooth manifold.
  For each point $p in M$, there is an associated space $T_p M$ called the tangent space of $M$ at $p$ (can be thought of as vectors tangent to $M$ at $p$.)
  However, we don't automatically have an inner product if we do this, so we put a Riemannian metric $g$ on $M$, which is a positive definite inner product $ g_p : T_p M times T_p M -> RR $ such that there is some smoothness property.
  A smooth manifold together with a Riemannian metric $g$ is a Riemannian manifold $(M, g)$.
])

#defn([Sectional Curvature], [
  Given a Riemannian manifold and linearly independent tangent vectors at the same point $u$ and $v$, define
  $
    K (u, v) = ip(R(u, v)v, u) / (ip(u, u) ip(v, v) - ip(u, v)^2)
  $
  where $R$ is the Riemann curvature tensor.
])

#defn([Totally Geodesic Submanifold], [
  A submanifold $M$ of a Riemannian manifold $(overline(M), overline(g))$ is called *totally geodesic* if any geodesic on the submanifold $M$ with its induced Riemannian metric $g$ is also a geodesic on the Riemannian manifold $(overline(M), overline(g))$.
])

#defn([Codimension], [
  If $M$ is a submanifold of a Riemannian manifold $overline(M)$, then the codimension is the different between dimensions:
  $
    codim (M) = dim (M) - dim (overline(M)).
  $
])

#defn([Connected Components], [
  The maximal connected subsets of a nonempty topological space are called the *connected components* of that space.
])

#example[
  $SS^n, EE^n$ and $HH^n$ are Riemannian manifolds, distinguished by their constant sectional curvatures of 1, 0, and -1 respectively.
  These spaces are notable as the only symmetric spaces to have totally geodesic codimension 1 submanifolds (called *hyperplanes*).
  Any hyperplane $cal(H) subset XX^n$ separates $XX^n$ into two connected components (*open half-spaces*).
  The union of a hyperplane $cal(H)$ with one of the open half spaces determining it is called a *closed half space*.

  Associated to each hyperplane $cal(H) subset XX^n$ there is an isometric reflection which fixes $cal(H)$ pointwise and exchanges the two half-spaces.
]

#defn[Tesselation][
  The tiling of a surface with no overlaps and no gaps.
]

#example(name: [Finite Dihedral Groups], [
  Consider $SS^1$ centered at the origin with two lines $ell_1$ and $ell_2$ meeting at a dihedral angle $pi / m$ for some $m >= 2$.

  For $i = 1, 2$ let $s_i$ be the isometric reflection about $ell_i$.
  Then the composition of reflections $s_1 s_2$ is rotation by $(2pi) / m$ about the origin, so $gen(s_1 s_2) iso C_m$ (the cyclic group of order $m$).

  The group $W = gen(s_1\, s_2)$ generated by $s_1$ and $s_2$ is the dihedral group of order $2m$, denoted by
  $
    W = D_(2 m) = gen(s_1\, s_2 | s_1^2 = s_2^2 = (s_1 s_2)^m = 1).
  $
  #note([
    Note that this is equivalent to the standard definiton of dihedral groups
    $
      D_(2n) &= gen(r\, s | r^n = s^2 = 1\, s r inv(s) = inv(r)) \
      &= gen(r\, s | r^n = s^2 = (s r)^2 = 1)
    $
    with $t = s r$.
  ])

  We think of $W = D_(2 m)$ as acting on $SS^1$.
  This induces a tessellation of $SS^1$ by $2m$ closed intervals which are in bijection with the elements of $W$.

  We can also think of $W$ as acting on $EE^2$, inducing a tessellation of the plane by $2m$ unbounded sectors.

  Another point of view is to see $W$ as the isometry group of a regular Euclidean $m$-gon embedded in the Euclidean plane, with a start vertex $v$ on line $ell_1$ and the midpoint of a line containing $v$ on $ell_2$.
  Then by taking the barycentric subdivision of the embedding of the polygon and projecting it to the sphere, we get the same result.
])

#example(name: [Infinite Dihedral Group], [
  Consider the real line $EE^1$.
  Let $s_1$ and $s_2$ be reflections of the line over the points 0 and 1 respectively.
  Notice $s_1 s_2$ is a translation by 2 units to the left, so $gen(s_1 s_2) iso ZZ$ is infinite cyclic.

  This group is called the infinite dihedral group and has presenttation
  $
    W = D_infty = gen(s_1\, s_2 | s_1^2 = s_2^2)
  $
  Notationally, we can say $(s_i s_j)^infty = 1$ means the product $s_i s_j$ has finite order, so we can put the condition $(s_1 s_2)^infty = 1$ as well.

  The action of this group on $EE^1$ induces a tesselation of the line by closed intervals which are in bijection with the elements of $W$.
])

#defn([Simplex], [
  A generalization of the notion of a triangle or tetrahedron to arbitrary dimensions.
  In particular, it is a  $k$ dimensional polytope that is the convex hull of its $k + 1$ vertices.
])

#defn([Polytope and Link], [
  A *convex polytope* $P = P subset.eq XX^n$ is a convex, compact intersection of a finite number of closed half spaces in $XX^n$, with nonempty interior.

  The *link* of a vertex $v$ of $P$, denoted $"link"(v)$, is the $(n - 1)$ dimensional spherical polytope obtained by intersecting $P$ with a small sphere centered at $v$.

  A convex polytope $P$ is called *simple* if, for every vertex $v$ of $P$, $"link"(v)$ is a simplex.
])

#thm([
  Let $P = P^n$ be a simple convex polytop in $XX^n$, where $n >= 2$.
  Let ${F_i}_(i in I)$ be the collection of codimension-1 faces of $P^n$, with each face $F_i$ supported by the hyperplane $cal(H)_i$.

  Suppose that $forall i != j, F_i sect F_j != emptyset ==>$ the dihedral angle between $F_i$ and $F_j$ is $pi / (m_(i j)) fs m_(i j) >= 2$.

  For each $i in I$, let $s_i$ be the isometric reflection of $XX^n$ across the hyperplane $cal(H)_i$.
  Let $W$ be the group generated by the set of reflections ${s_i}_(i in I)$.
  Then
  1. The group has presentation $ W = gen(s_i | (s_i s_j)^(m_(i j)) = 1 forall i\, j in I) $
  2. The group $W$ is a discrete subgroup of $Isom(XX^n)$
  3. The convex polytope $P$ is a strict fundamental domain for the action of $W$ on $XX^n$, and the action of $W$ induces a tessellation of $XX^n$ by copies of $P$
], [
  To be discussed later.
])

== Coxeter Groups

#defn([Coxeter Group / Coxeter System], [
  Let $I$ be a finite indexing set and let $S = {s_i}_(i in I)$.
  Let $M = (m_(i j)_(i, j in I)$ be a matrix such that
  - $m_(i i) = 1 forall i in I$
  - $m_(i j) = m_(j i) forall i, j in I$
  - $m_(i j) in {2, 3, 4, dots} union {infty}$ for all distinct $i, j in I$

  Then $M$ is called a _Coxeter matrix_.
  The associated _Coxeter group_ $W = W_M$ is defined by the presentation $ W = gen(S | (s_i s_j)^(m_(i j)) = 1 forall i\, j in I) $ or equivalently, $ W = gen(S | s_i^2 = 1 forall i in I "and" (s_i s_j)^(m_(i j)) = 1 forall "distinct" i\, j in I) $

  The pair $(W, S)$ is a _Coxeter system_ and the set $S$ is a _Coxeter generating set_ for $W$.
])

#remark([
  1. Notice that each $s_i$ has order 2 and each $s_i s_j$ has order $m_(i j)$.

  2. The presentations for dihedral groups together with Theorem imply that all geometric reflection groups are Coxeter groups.
])

== Right-angled Coxeter Groups

#defn[Right-angled Coxeter Group][
  Let $(W, S)$ be a Coxeter system with associated Coxeter matrix $M = (m_(i j))_(i, j in I)$.
  The Coxeter system $(W, S)$ is *right-angled*, and $W$ is a *righ-angled Coxeter group* if, for distinct $i, j in I$, we have $m_(i j) in {2, infty}$.
]

= Combinatorial Theory

== Word metrics and Cayley Graphs

#defn([Word length], [
  The *word length* of $g in G wrt S$ is $ ell_S (g) = min {n in N : exists s_1, dots, s_n in S st g = s_1 cdots s_n}. $
  By definition, $ell_S (1) = 0$.
  If $ell_S (g) = n >= 1$ and $g = s_1 cdots s_n$ then the corresponding word $(s_1, dots, s_n)$ is variously called a *reduced expression*, a *reduced word* or a *minimal word* for $g$.

  The *word metric* on $G wrt S$ is given for $g, h in G$ by $ d_S (g, h) = ell_S (inv(g) h). $
])

#defn([Cayley Graph], [
  The *Cayley Graph* $Cay(G, S)$ of $G wrt S$ is the graph with vertex set $G$ and directed edges given by ${(g, g s) : g in G, s in S}$.
  However, if $s in S$ is an involution, we put a single undirected edge between $g in G$ and $g s = g inv(s)$ and denote it by ${g, g s}$.

  Since $S$ generates $G$, the graph $Cay(G, S)$ is connected.
  Note that if $s$ is an involution, $g s inv(g)$ is the unique group element swapping the edges in the Cayley graph.

  Note a minimal length path in the Cayley graph corresponds to a reduced expression.
])

#ex([
  Note if we have a geometric reflection group, $Cay(W, S)$ is the dual graph to the tessellation of $XX^n$ induced by the action of $W$.
])

== Cayley Graphs of Coxeter Systems

#defn([Epimorphism], [
  An *epimorphism* is a morphism $f : X -> Y$ that is rightr cancellative, ie $forall Z$ and morphisms $g_1, g_2 : Y -> Z$,
  $
    g_1 comp f = g_2 comp f ==> g_1 = g_2.
  $
])

#lemma([
  There is an epimorphism $epsilon : W -> ZZ \/ 2 ZZ$ induced by $epsilon(s) = 1 forall s in S$.
], [])

#cor([
  Each $s in S$ is an involution in the group $W$.
], [])

#defn([Even Coxeter System], [
  A Coxeter System ($W$, $S$) is _even_ if for all distinct $i, j in I$ with $m_(i j)$ finite, the integer $m_(i j)$ is finite.
  For example, right-angled Coxeter systems are even.
])

#lemma([
  If $(W, S)$ is even, then for each $i in I$, there is an epimorphism $epsilon_i : W -> ZZ \/ 2 ZZ$ induced by $epsilon(s_i) = 1$ and $epsilon(s) = 0 forall s in S \\ {s_i}$.
], [])

#cor( [
  In a Coxeter system $(W, S)$, the elements of $S$ are pairwise distinct involutions in $W$.
], [])

== Reflection Systems

#defn([Pre Reflection System], [
  A *pre-reflection system* for a group $G$ is a pair $(X, R)$, where $X$ is a connected simple graph on which $G$ acts by graph automorphisms, and $R$ is a subset of $G st$
  1. Each $r in R$ is an involution
  2. $R$ is closed under conjugation, that is, $forall g in G$ and $r in R$, we have $g r inv(g) in R$
  3. $R$ generates $G$
  4. For every edge $e in X exiuni r_e in R st r_e$ swaps the endpoints of $e$
  5. For every $r in R exists e in X$ which is flipped by $r$

  For each $r in R$, the *wall* $H_r$ is the set of midpoints of edges which are flipped by $r$.
])

= The Tits Representation

== Tits Theorem

#thm[
  Let $I$ be a finite indexing set, let $S = {s_i}_(i in I)$ and let $M = {m_(i j)}_(i, j in I)$ be a Coxeter matrix.
  Let $ W = gen(S : (s_i s_j)^(m_(i j)) = 1 forall i\, j in I) $ be the associated Coxeter group.
  Then there is a faithful representation (called the *Tits representation*) $ rho : W -> GL_n (RR) $ where $n = |S| = |I| st$
  - for each $i in I, rho(s_i) = sigma_i$ is a linear involution with fixed set a hyperplane
  - for all $i != j$, the product $sigma_i sigma_j$ has order $m_(i j)$
][]

== Construction

We construct the homomorphism $rho : W -> GL_n (RR)$ and make deductions based on its properties as follows.
$Wlog$ let $I = {1, ..., n}$.
Let $V$ be a vector space over $RR$ with basis ${e_1, ..., e_n} st GL(V) iso GL_n (RR)$.

#defn[Bilinear Form][
  A *bilinear* form is a bilinear map $B : V times V -> K$ on a vector space $V$ over a field $K$.
  Note they are a strict superset of inner products.
  A bilinear form is called *symmetric* if $B(vtr(v), vtr(u)) = B(vtr(u), vtr(v)) forall vtr(u), vtr(v) in V$.
]

Now define a symmetric bilinear form $B$ on $V$ by $ B(e_i, e_j) = cases(-cos(pi / m_(i j)) &"if" m_(i j) "is finite" \ -1 &"if" m_(i j) = infty) $
Note that $B(e_i, e_j) = 1$ and $B(e_i, e_j) <= 0$ if $i != j$.
Consider the hyperplane $H_i = {v in V : B(e_i, v) = 0}$ and the map $sigma_i : V -> V$ given by $ sigma_i (v) = v - 2 B(e_i, v) e_i. $

== Geometric Realizations of Finite and Affine Coxeter Groups

#defn[Irreducible][
  A Coxeter system $(W, S)$ is *reducible* if $S = S' union.sq S''$ with $S'$ and $S''$ nonempty, such that $m_(i j) = 2 forall s_i in S'$ and $s_j in S''$.
  A Coxeter system $(W, S)$ is *irreducible* if it is not reducible.
]

== Special Subgroups

Let $(W, S)$ be a Coxeter System.

#defn[Special Subgroup][
  For each $T subset.eq S$, the *special subgroup* $W_T$ of $W$ is $W_T = gen(T)$.
  If $T = emptyset$, we define $W_emptyset$ to be the trivial group.
]

#thm[
  Let $(W, S)$ be a Coxeter system.
  1. THe pair $(W_T, T)$ is a Coxeter system for each $T subset.eq S$.
  2. For all $T subset.eq S$ and $w in W_T$ we have $ell_T (w) = ell_s (w)$, and any reduced expression for $w$ only uses letters in $T$.
  Hence $Cay(W_T, T)$ embeds isometrically as a convex subgraph of $Cay(W, S)$.
][]

= Geometric Realization

== Simplicial Complexes

#defn[Abstract Simplicial Complex][
  An *abstract simplicial complex* consists of a set $V$, possibly infinite, called the *vertex set*, and a collection $X$ of finite subsets of $V$, such that
  1. ${v} in X forall v in V$
  2. if $Delta in X$ and $Delta' subset.eq Delta$, then $Delta' in X$

  An element of $X$ is called a *simplex*.
  If $Delta$ is a simplex and $Delta' subset.neq Delta$, then $Delta'$ is a *face* of $Delta$.

  Note a 0-simplex is a *vertex* and a 1-simplex is an *edge*.
]

== Basic Construction

We define the basic construction $cal(U)(W, X)$ of a geometric realization for a Coxeter system $(W, S)$.

#defn[Mirror Structure][
  Let $(W, S)$ be any Coxeter system and let $X$ be a connected, Hausdorff topological space.
  A *mirror structure* on $X$ over $S$ is a collection $(X_s)_(s in S)$ where each $X_s$ is a nonempty, closed subset of $X$.
  For each $s in S$, we call $X_s$ the $s$-mirror of $X$.
]

#ex[
  1. $X$ is the cone on $|S|$ vertices, ${sigma_s : s in S}$ (i.e., $X$ is the star graph of valence $|S|$).
    Then $X_s = {sigma_s}$.

  2. Let $X$ be the $n$ simplex where $|S| = n + 1$, with set of codimension 1 faces ${Delta_s : s in S}$.
    Set $X_s = Delta_s$.
    For example if $|S| = 3$ then $X$ is the equilateral triangle which tiles the plane.
]

From now on, $X$ represents a connected, Hausdorff topological space with mirror structure $(X_s)_(s in S)$.
To avoid degeneracy assume $exists x in X st x in.not X_s forall s in S$.
For each point $x in X$, define $S(x) subset.eq S$ by $ S(x) = {s in S : x in X_s} $ and note this is empty for some $x in X$.

Define a relation $sim$ on $W times X$ by $ (w, x) sim (w', x') iff x = x' "and" inv(w) w' in W_(S(x)). $

#defn[Basic Construction][
  The *basic construction* is the quotient $cal(U)(W, X) = W times X \/ sim$ equipped with the quotient topology.

  We write $[w, x]$ for the equivalence class of $(w, x)$ in $cal(U)(W, X)$.
  For example, if $x in X_s$ then $[w, x]$ contains at least $(w, x)$ and $(w s, x)$.
  Denote by $w X$ the image of ${w} times X$ in $cal(U)(W, X)$.
  A subset $w X$ of $cal(U)(W, X)$ is called a *chamber*.
]

== Basic Construction Properties

#lemma[$cal(U)(W, X)$ is a connected topological space.][]

#defn[Locally Finite][
  We say $cal(U)(W, X)$ is *locally finite* if for every $[w, x] in cal(U)(W, X)$, there is an open neighborhood of $[w, x]$ which meets only finitely many chambers.
]

#lemma[
  The following are equivalent:
  1. The basic construction $cal(U)(W, X)$ is locally finite.
  2. For all $x in X$, the special subgroup $W_(S(x))$ is finite.
  3. For all $T subset.eq S st W_T$ is infinite, $sect_(x in T) X_t = emptyset$.
][]

= The Davis Complex

Let $(W, S)$ be a Coxeter system.
We will show some definitions of the Davis complex $Sigma = Sigma(W, S)$.

== Spherical special subgroups and the nerve

#defn[Spherical][
  A subset $T subset.eq S$ is *spherical* if the special subgroup $W_T$ is finite, in which case we say $W_T$ is a *spherical special subgroup*.
]

#ex[
  For $s in S$, clearly $|W_{s}| = 2$ so ${s}$ is spherical, and further $W_{s} iso C_2$.
  Note since $W_emptyset$ is trivial the empty set is also spherical.
]

#note[
  The reason we call it "spherical" is that if $(W, S)$ is an irreducible Coxeter system with $W$ finite, then $W$ acts naturally on the sphere. (???)
]

Now consider $ {T subset.eq S : T != emptyset "and" T "is spherical"} $

#defn[Nerve][
  The *nerve* of $(W, S)$, denoted $L = L(W, S)$, is the simplicial complex with a simplex $sigma_T$ for each $T subset.eq S st T != emptyset$ and $W_T$ is finite.
]

#ex[
  1. The group $W$ is finite iff the simplices in the nerve $L = L(W, S)$ are in bijection with the nonempty subsets of $S$.
    Then $L$ is just the simplex with vertex set $S$.

  2. If we have a finite dihedral group $W = gen(s\, t)$ then $L$ is an edge with vertices $s$ and $t$. If $W$ is an infinite dihedral group then $L$ consists only the vertices.
]

== Davis Complex as a Basic Construction

#defn[Chamber][
  The *chamber* $K$ is the cone on the barycentric subdivision $L'$ of the nerve $L = L(W, S)$.
  For each $s in S$, define $K_s subset K$ to be the closed star in $L'$ of the vertex $s$.
]
