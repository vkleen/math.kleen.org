% Torsors and Their Classification II

# Classifying Torsors using Homotopy Theory #

Let again $\ca C$ be some Grothendieck topos and $G$ a group object in $\ca
C$. I want to give a proof of the following theorem.

<thm>
There is a functorial construction of a simplicial object $BG$ in $\ca C$ and a
functorial bijection $\tors[G] \isom [*,BG]$ between the set of $G$--torsors
$\tors[G]$ and the set of simplicial homotopy classes of morphisms $*\to BG$.
</thm>

To show this we will follow an approach which was presented in the
paper/preprint ["Cocyle Categories"](http://www.math.uiuc.edu/K-theory/0782/) by
Rick Jardine. The point is that proving our theorem comes down to computing
homsets between objects of $\ca C$ in the homotopy category. Generally, in any
model category $\ca M$ (and $\ca C$ embeds into the local model structure on the
category ${\ca C}^{\op{\Simp}}$ of simplicial objects in $\ca C$) we can
"calculate" homsets from $X$ to $Y$ in the homotopy category by taking a
cofibrant replacement $X'$ of $X$ and a fibrant replacement $Y'$ of $Y$ and
taking honest homotopy classes of maps from $X'$ to $Y'$ in $\ca M$.

However, computing homsets like that tends to be quite difficult because,
typically, cofibrant and fibrant replacement are hard to write down explicitly
(at least in a form that one can work with). Jardine came up with the following
work--around.

<defn>
Let $\ca M$ be a category with weak equivalences and let $X$ and $Y$ be objects
in $\ca M$. Define a category $\coc(X,Y)$ of *cocycles* from $X$ to $Y$ whose
objects are diagrams
$$
\begin{tikzcd}[column sep=2ex, row sep=1ex]
& Z \arrow[ld, "\sim"'{sloped,pos=-.1}] \arrow[rd] & \\
X & & Y
\end{tikzcd}
$$
with $Z\iso X$ a weak equivalence and whose morphisms are the obvious commuting
diagrams.
</defn>