% Torsors and Their Classification III

# Interlude on constructions with torsors #

## Twisting with torsors ##

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
a left $H'$--action. The process of twisting has some exactness properties:

<thm>
The functor $P\times^G{-}\colon\objl{G}\to\ca C$ preserves colimits and finite products.
</thm>

<proof>
Regarding preservation of colimits, we can in fact construct a right adjoint to
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
</proof>

Preservation of finite products in particular implies that $P\times^G{-}$ sends
group objects in $\objl{G}$ to group objects in $\ca C$. This allows the
following construction.

<thm>
When endowed with the conjugation action of $G$ on itself, $G$ becomes a group
object in $\objl{G}$. In particular, ${}^P G\coloneqq P\times^G G$ is naturally
a group object in $\ca C$.
</thm>
<proof>
It is enough to check that the structure maps $e\colon *\to G$, $m\colon G\times
G\to G$ and $i\colon G\to G$ are equivariant with respect to conjugation. This
can be checked on generalized elements where it reduces to the corresponding
statement about genuine groups. There, it is a simple calculation.
</proof>

More generally, if $G$ acts on itself via automorphisms, then the twist
$P\times^G G$ with respect to this action becomes a new group object. Sometimes,
this is called a *form* of $G$. This construction let's us refine the process of
twisting a little bit. It turns out that the twisted object $P\times^G X$ comes
naturally equipped with a left group action by ${}^P G$.

## The Borel construction ##

## Constructing torsors from cocycles ##

## Constructing cocycles from torsors ##
