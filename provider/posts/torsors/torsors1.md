---
title: Torsors and Their Classification I
tags: Torsors and Their Classification
published: 2015-03-05
---

## Torsors in Grothendieck Toposes

Let $\ca C$ be some Grothendieck topos, that is a category of sheaves on some
Grothendieck topology. This text will look at some properties of *torsors* in
$\ca C$ and how they might be classified using cohomology and homotopy
theory. For this we will first need to define group objects. Torsors will then
be associated to those.

Definition. A *group object* in a category $\ca C$ is an object $G\in\ca C$ such that
the associated Yoneda functor $\hom(\_,G)\colon \op{\ca C}\to\Set$ actually
takes values in the category $\Grp$ of groups.

A trivial kind of example would be just a group considered as an object in
$\Set$. A more involved example would be a *group scheme* $G$ over some base
$S$. Such a thing is essentially defined as a group object in the category
$\sch[S]$. If we have any subcanonical topology on $\sch[S]$, then $G$ defines a
sheaf on the associated site and we obtain in this way a group object in the
corresponding topos on $S$.

Let's now assume we have a group object $G$ in a Grothendieck topos $\ca
C$. Then we can define torsors over $G$ as follows:

Definition. A *trivial $G$--torsor* is an object $X$ with a left $G$--action which is
isomorphic to $G$ itself with the action given by left multiplication.

Definition. A *$G$--torsor* is an object $X\in\ca C$ with a left $G$--action which is
locally isomorphic to a trivial torsor; that is, there is an epimorphism $U\to
*$ such that $U\times X$ is a trivial torsor in $\ca C/U$ over $U \times G$.

I want to show that for any $G$--torsor $X$ according to this definition the
left action of $G$ on $X$ is free and transitive, that is the map
$$ f\colon G\times X \to X\times X $$
given (on generalized elements) by $f(g, x) = (gx, x)$ is an isomorphism. This
is going to be some relatively elementary category theory but I think it's worth
writing it up. First a few facts about isomorphisms in toposes, they can be
found for example in Sheaves in Geometry and Logic.[^1]

Lemma. Epimorphisms in a topos are stable under pullback.

Lemma. In a topos every morphism $f\colon X\to Y$ has a functorial factorization $f =
m\circ e$ with $m$ a monomorphism and $e$ and epimorphism.

Lemma. A morphism $f$ is an isomorphism if and only if $f$ is both monic and epic.

Now, let $f\colon A\to B$ be a *local monomorphism*, i.e. there is an epimorphism
$U\to *$ such that the pullback $f\times U$ of $f$ to $U$ is a
monomorphism. Then, since epimorphisms are stable under pullback, it follows that
in the commutative square
$$
\begin{tikzcd}
A\times U \ar[into, r, "f\times U"] \ar[onto, d] & B\times U \ar[onto, d] \\
A \ar[r, "f"'] & B
\end{tikzcd}
$$
both vertical maps are epimorphisms. Now let $\varphi,\psi\colon T\to A$ be a pair of morphisms
such that $f\varphi = f\psi$. Then, denoting by $\varphi_U$ and $\psi_U$ the
pullbacks to $U$, we have $f_U\varphi_U = f_U\psi_U$. but $f_U$ is a
monomorphism by assumption, so $\varphi_U = \psi_U$. So we have a commutative
diagram
$$
\begin{tikzcd}
T\times U \ar[r, "\varphi_U = \psi_U"] \ar[onto, d] & A\times U \ar[onto, d] \\
T \ar[r, "\varphi", shift left] \ar[r, "\psi"', shift right] & A
\end{tikzcd}
$$
in which the vertical maps are epimorphisms. It follows that $\varphi =
\psi$.

Now, if $f$ is a local epimorphism, then again we have the diagram
$$
\begin{tikzcd}
A\times U \ar[onto, r, "f\times U"] \ar[onto, d] & B\times U \ar[onto, d] \\
A \ar[r, "f"'] & B
\end{tikzcd}
$$
and it is immediate that $f$ is an epimorphism. In summary:

Proposition. In a topos, any local epimorphism is an epimorphism, any local monomorphism is a
monomorphism, and any local isomorphism is an isomorphism.

Now, let's check that $G$--torsors $X$ as defined above are free and
transitive. Take an epimorphism $U\onto *$ such that $X\times U$ is trivial in
$\ca C/U$. The action of $G$ on itself by left multiplication is plainly free
and transitive, so in $\ca C/U$ we have the isomorphism
$$(G\times U)\times_U (X\times U) \iso (X\times U)
\times_U (X\times U)$$
and $(G\times U)\times_U(X\times U) = (G\times X)\times U$ and $(X\times
U)\times_U (X\times U) = (X\times X)\times U$ because pullback preserves products. So, $G\times X\to
X\times X$ is a local isomorphism, hence an isomorphism.

[^1]: Saunders Mac Lane, Ieke Moerdijk. Sheaves in geometry and logic. Springer, 1994. ISBN: 0-387-97710-4
