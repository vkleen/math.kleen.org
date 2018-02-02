---
title: Torsors and Their Classification III
tags: Torsors and Their Classification
published: 2015-03-07
---

## Interlude on constructions with torsors

Let $P$ be a right torsor for some group object $G$. Twisting with $P$ will be a
functor $\objl{G}\to \ca C$ from objects with a left $G$--action to
objects in $\ca C$.

Let $X$ be an object with a left $G$--action. The *twist* $P\times^G X$ is
defined as the quotient of $P\times X$ by the diagonal action of $G$, that is,
it is the coequalizer
$$
\begin{tikzcd}
G\times P\times X \arrow[r,shift left=.5ex, "\act"]
\arrow[r, shift right=.5ex, "\proj"'] & P\times X \arrow[onto,r] & P\times^G X
\end{tikzcd}
$$
where $\act(g, p, x) = (p g^{-1}, gx)$ on generalized elements. If $X$
additionally carries a right action by some group object $H$, then evidently the
twist $P\times^G X$ also carries a right $H$--action; similarly, if the torsor
$P$ carries a left action by some group object $H'$, then the twist also carries
a left $H'$--action.

Let's introduce some notation for the action of the epimorphism $P\times X\onto
P\times^G X$ on generalized elements. Namely, given a generalized element
$(p,x)\colon T\to P\times X$, I will write $[p,x]$ for the composition $T\to
P\times X\to P\times^G X$. Because $P\times X\onto P\times^G X$ is an
epimorphism, to check some relation between generalized elements downstairs it
will be enough to check it on generalized elements of the form
$[p,x]$. Furthermore, if $(p,x)$ actually comes from a generalized element
$(g,p,x)\colon T\to (G,P,X)$ via projection, then by the coequalizer property we
find $[p,x] = [p g^{-1}, g x]$.

The process of twisting has some exactness properties:

Theorem. The functor $P\times^G{-}\colon\objl{G}\to\ca C$ preserves colimits and finite products.

Proof. Regarding preservation of colimits, we can in fact construct a right adjoint to
$P\times^G{-}$. It is given by the functor $({-})^P$ which sends $T$ to the
function object $T^P$ whose $G$--action is given by precomposing with the action
on $P$. This won't be particularly important in what follows, so I'll skip the
detailed calculation.

Showing that binary products are preserved is a little more difficult. Let's
first observe that the functor $G\times^G{-}$ is naturally isomorphic to the
identity functor: Consider the commutative diagram
$$
\begin{tikzcd}
G\times X & X \arrow[l, "e\times{\id}"'] \\
G\times G\times X \arrow[u, shift left=.5ex, "\proj"]
\arrow[u, shift right=.5ex, "\act"'] & X \arrow[l, "e\times e\times{\id}"]
\ar[u, shift left=.5ex, "{\id}"] \ar[u, shift right=.5ex, "{\id}"']
\end{tikzcd}
$$
This induces a natural transformation ${\id}\to G\times^G{-}$ which is easily
checked to be an isomorphism on generalized elements.

Now, choose a trivializing cover $U\onto *$ of the torsor $P$. Because pullback
in a topos commutes with colimits and limits, it will then be enough to check
that, for any $X$ and $Y$, the natural morphism
$$
P\times^G (X\times Y)\to (P\times^G X) \times (P\times^G Y)
$$
after pulling back to the corresponding natural morphism in $\ca C/U$ becomes an
isomorphism. Since there is a $G\times U$--equivariant isomorphism $P\times
U\isom G\times U$, the functors $P\times U\times^{G\times U}{-}$ and $G\times
U\times^{G\times U}{-} \isom \id$ are naturally isomorphic; in particular
$P\times U\times^{G\times U}{-}$ preserves products, which is exactly what we
needed to show.

QED.

Preservation of finite products in particular implies that $P\times^G{-}$ sends
group objects in $\objl{G}$ to group objects in $\ca C$. This allows the
following construction.

Theorem. When endowed with the conjugation action of $G$ on itself, $G$ becomes a group
object in $\objl{G}$. In particular, ${}^P G\coloneqq P\times^G G$ is naturally
a group object in $\ca C$.

Proof. It is enough to check that the structure maps $e\colon *\to G$, $m\colon G\times
G\to G$ and $i\colon G\to G$ are equivariant with respect to conjugation. This
can be checked on generalized elements where it reduces to the corresponding
statement about genuine groups. There, it is a simple calculation.

QED.

More generally, if $G$ acts on itself via automorphisms, then the twist
$P\times^G G$ with respect to this action becomes a new group object. Sometimes,
this is called a *form* of $G$. This construction let's us refine the process of
twisting a little bit. It turns out that the twisted object $P\times^G X$ comes
naturally equipped with a left group action by ${}^P G$. In fact, $P$ itself
carries a natural left action by ${}^P G$. Recall that, since $P$ is a righ
$G$--torsor, the map $P\times G\to P\times P$ given by $(p,g)\mapsto (p, pg)$ on
generalized elements is an isomorphism. Let's denote the inverse map by
$$
(p, q) \mapsto (p, \tdiv{p}{q})
$$
on generalized elements. Then we can construct a commutative diagram
$$
\begin{tikzcd}
P\times G \times P\arrow[r, "\varphi"] & P \arrow[d, equal] \\
G\times P\times G\times P\arrow[u, shift left=.5ex]\arrow[u, shift right=.5ex]
\arrow[r, "\psi"'] & P
\end{tikzcd}
$$
where, on generalized elements, $\varphi(p,g,q) = p\cdot g \tdiv{p}{q}$ and
$\psi(h,p,g,q) = \varphi(p,g,q)$. The commutativity follows from the following
calculation:
$$
\varphi(ph^{-1}, hgh^{-1}, q) = ph^{-1}\cdot hgh^{-1} \tdiv{ph^{-1}}{q} = p\cdot g
h^{-1} h \tdiv{p}{q} = \varphi(p,g,q).
$$
Hence, because colimits commute with products in toposes, we have a morphism
${}^P G\times P\to P$ where the axioms for a left action can be checked by
direct calculation.

Theorem. This action makes $P$ into a left ${}^P G$--torsor.

Proof. Take an epimorphism $U\onto *$ which trivializes $P$. Then it will be enough to
check that there is a ${}^P G$--equivariant isomorphism $P\times U\iso {}^P
G\times U$. Since everything in sight commutes with pullbacks, we might as well
assume that $P$ is isomorphic to the trivial right $G$--torsor and check that
then it is ${}^P G$--isomorphic to the trivial left ${}^P G$--torsor.

We first need to produce an isomorphism $P\iso {}^P G$ given a $G$--isomorphism
$\varphi\colon P\iso G$. I claim that the composition
$$
G \to[g\mapsto(e,g)] G\times G\onto G\times^G G
$$
is an isomorphism. The inverse map is defined by the commutative[^1] diagram
$$
\begin{tikzcd}
G\times G \arrow[r, "\conj"] & G \arrow[d, equal] \\
G\times G\times G \arrow[u, shift left=.5ex]\arrow[u, shift right=.5ex]  \arrow[r, "\conj\circ\proj"'] & G
\end{tikzcd}
$$
where $\conj$ denotes the conjugation action. Hence, we get a chain of isomorphisms[^2]
$$
\begin{tikzcd}
P \arrow[r,"\varphi"] & G \arrow[r, "{g\mapsto(e,g)}"] & G\times^G G
\arrow[r, "\varphi^{-1}_*"] & P\times^G G = {}^P G.
\end{tikzcd}
$$
The last thing to check is that this isomorphism $P\iso {}^P G$ is in fact ${}^P
G$--equivariant, that is, we need to check that the diagram
$$
\begin{tikzcd}
{}^P G\times P \arrow[r, "\act"] \arrow[d] & P \arrow[d] \\
{}^P G\times G \arrow[d] & G \arrow[d] \\
{}^P G\times (G\times^G G) \arrow[d] & G\times^G G \arrow[d] \\
{}^P G\times {}^P G \arrow[r, "m"'] & {}^P G
\end{tikzcd}
$$
commutes. On generalized elements, the top composition gives
$$
[p, g], q \mapsto [\varphi^{-1}(e), \varphi(p) g \varphi(p)^{-1}\varphi(q)]
$$
while the bottom composition is
$$
[p,q], q\mapsto
[p, g\cdot\tdiv{\varphi^{-1}(e)}{p}\varphi(q)\tdiv{p}{\varphi^{-1}(e)}] = [p, g\varphi(p)^{-1}\varphi(q)\varphi(p)]
$$
But this is equal to
$$
[\varphi^{-1}(e), \varphi(p) g\varphi(p)^{-1}\varphi(q)\varphi(p)\varphi(p)^{-1}]
$$
which proves the required commutativity.

QED.

A consequence of this theorem is that the twisting functor $P\times^G{-}$ may be
considered as a functor $\objl{G}\to\objl{{}^P G}$. Furthermore, if $Q$ is a
left $G$--torsor, then we can choose an epimorphism $U\onto *$ which trivializes
both $Q$ and $P$. Then, because twisting commutes with products, we find
$$
(P\times^G Q)\times U\isom G\times U \times^{G\times U} G\times U\isom G\times
U\isom {}^P G\times U
$$
similarly to the proof of the theorem. Hence, twisting restricts to a functor
$$
P\times^G{-}\colon \Tors[G]\to\Tors[{}^P G]
$$
from the category of left $G$ torsors to the category of left ${}^P G$
torsors. Furthermore, if $Q$ is a left $K$--torsor and a right $H$--torsor, $P$
a left $H$--torsor and a right $G$--torsor then there is a natural isomorphism
$$
Q\times^H (P\times^G{-})\isom (Q\times^H P)\times^G{-}
$$
which follows from the fact that colimits commute with colimits and with binary
products in toposes.

Theorem. If $P$ is a right $G$--torsor and hence a left ${}^P G$--torsor, let $\op{P}$
denote the right ${}^P G$--torsor with action given by $p\cdot g = g^{-1}\cdot
p$ on generalized elements. Then  $\op{P}\times^{{}^P G} P$ is a trivial right
$G$--torsor. Furthermore, ${}^{\op{P}}({}^P G)\isom G$ as group objects and
along this identification $P\times^G \op{P}$ is a trivial right ${}^P
G$--torsor. It follows that
$$
P\times^G{-}\colon \Tors[G]\to\Tors[{}^P G]
$$
is an equivalence of categories with weak inverse
$$
\op{P}\times^{{}^P G}{-}\colon\Tors[{}^P G]\to\Tors[G].
$$

Proof. Let's first produce an isomorphism ${}^{\op{P}}({}^P G)\iso G$. Let
$\varphi\colon P\times P\times G\to G$
be such that $\varphi(p,q,g) = \tdiv{q}{p} \cdot g \cdot \tdiv{p}{q}$ on
generalized elements. It is straightforward, albeit tedious, to check that
$\varphi$ descends to a group homomorphism
$$
\op{P}\times^{{}^P G} (P\times^G G) = {}^{\op{P}}({}^P G)\to G.
$$
I claim that this is an isomorphism. To verify this claim, it will be enough to
pull back along an epimorphism $U\onto *$ which trivializes both the right
$G$--torsor $P$ and the right ${}^P G$--torsor $\op{P}$, that is, we can assume
that $P$ is trivial.[^3] So let $\psi\colon G\iso P$ be a $G$--equivariant
isomorphism. We can then set $\widetilde\varphi\colon G\to {}^{\op{P}}({}^P G)$
to be the morphism such that $\widetilde\varphi(g) = [\psi(e), [\psi(e), g]]$ on
generalized elements. Computing the compositions $\varphi\circ\widetilde\varphi$
and $\widetilde\varphi\circ\varphi$ on generalized elements, we find
$$
\varphi(\widetilde\varphi(g)) = \varphi([\psi(e), [\psi(e), g]]) = g
$$
and
$$\widetilde\varphi(\varphi([p, [q, g]])) =
[\psi(e), [\psi(e), \tdiv{q}{p}\cdot g\cdot \tdiv{p}{q}]].
$$
Noticing that
$$
[p, [q, g]] = [p_0, [p_0, \tdiv{p_0}{p}]\,
 [p_0, \tdiv{q}{p_0}\cdot g\cdot \tdiv{p_0}{q}]\,
 [p_0, \tdiv{p}{p_0}]]
$$
where $p_0 = \psi(e)$ finishes the proof of ${}^{\op{P}}({}^P G)\isom G$.

Next, let's check that $\op{P}\times^{{}^P G} P$ is a trivial right
$G$--torsor. Let $P\to P\times P\onto \op{P}\times^{{}^P G} P$ be the diagonal
composed with the canonical projection. I claim that this map descends to the
quotient $P/G\isom *$ which will provide a global section of $\op{P}\times^{{}^P
G} P$. This will then imply the claim. The calculation
$$
[pg, pg] = [p, [p, g^{-1}]\cdot(pg)] = [p, p g g^{-1}] = [p,p]
$$
shows that the diagonal is $P\to \op{P}\times^{{}^P G} P$ is invariant under the
right action of $G$ which proves the claim. The last assertion of the theorem is
proven in a completely analogous way.

QED.

In summary, we have found that twisting with a right torsor $P$ is an invertible
operation up to isomorphism. This will become essential in the computation of
the homotopy groups of $BG$ at any basepoint.

[^1]: Remember that in $G\times^G G$ the $G$ on the left is the trivial right
      torsor and the $G$ on the right is taken with the conjugation action.

[^2]: Note that $\varphi^{-1}_*$ denotes the morphism induced by the
      $G$--equivariant isomorphism $\varphi^{-1}\colon G\to P$, using the fact
      that twisting is functorial with respect to $G$--equivariant morphisms in
      both factors.

[^3]: By the proof of the previous theorem, this also implies that $\op{P}$ is trivial.
