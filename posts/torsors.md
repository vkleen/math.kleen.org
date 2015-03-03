% Torsors and Their Classification

Let $\ca C$ be some Grothendieck topos, that is a category of sheaves on some
Grothendieck topology. This text will look at some properties of *torsors* in
$\ca C$ and how they might be classified using cohomology and homotopy
theory. For this we will first need to define group objects. Torsors will then
be associated to those.

<defn> A *group object* in a category $\ca C$ is an object $G\in\ca C$ such that
the associated Yoneda functor $\hom(\_,G)\colon \op{\ca C}\to\Set$ actually
takes values in the category $\Grp$ of groups.  </defn>

A trivial kind of example would be just a group considered as an object in
$\Set$. A more involved example would be a *group scheme* $G$ over some base
$S$. Such a thing is essentially defined as a group object in the category
$\sch[S]$. If we have any subcanonical topology on $\sch[S]$, then $G$ defines a
sheaf on the associated site and we obtain in this way a group object in the
corresponding topos on $S$.

Let's now assume we have a group object $G$ in a Grothendieck topos $\ca
C$. Then we can define torsors over $G$ as follows:

<defn> A *trivial torsor* over $G$ is an object $X$ with a left $G$--action
which is isomorphic to $G$ itself with the action given by left
multiplication. A *torsor* over $G$ is an object $X\in\ca C$ with a left
$G$--action which is locally isomorphic to a trivial torsor; that is, there is
an epimorphism $U\to *$ such that $U\times X$ is a trivial torsor in $\ca C/U$
over $U \times G$.  </defn>
