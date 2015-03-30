% Torsors and Their Classification IV

# Homotopy Groups of $BG$ #

Recall that last time I wrote up a proof of the following theorem.

<thm>
There is a functorial construction of a simplicial object $BG$ in $\ca C$ and a
functorial bijection $\tors[G] \isom [*,BG]$ between the set of $G$--torsors
$\tors[G]$ and the set of simplicial homotopy classes of morphisms $*\to BG$.
</thm>

This post will be about computing the homotopy groups of $BG$ at every
basepoint. The theorem gives us a nice labeling of the path components of $BG$
in terms of $G$--torsors over $*$ in our ambient Grothendieck topos $\ca
C$. Let's first compute the homotopy groups at the trivial torsor.

Let $\triv\colon *\to BG$ be a morphism corresponding to the trivial
$G$--torsor. Recall that we have a homotopy pullback square
$$
\begin{tikzcd}
G \arrow[r] \arrow[d] & * \arrow[d, "\triv"] \\
* \arrow[r, "\triv"'] & BG
\end{tikzcd}
$$
which immediately gives the relation $\pi_n(BG,\triv) \isom \pi_{n-1}(G,e)$ for $n\geq
1$ for the homotopy sheaves of $BG$. Using that $G$ is assumed to be
simplicially discrete and  the theorem from last time we get a complete
computation of $\pi_n(BG,\triv)$ as follows:
$$
\pi_n(BG,\triv) = \begin{cases}
\tors[G] & n=0 \\
G & n=1 \\
0 & n>1
\end{cases}
$$

Now, let $P\in\tors[G]$ be some other $G$--torsor.
