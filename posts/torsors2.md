% Torsors and Their Classification II

# Computing Homotopy Classes in Model Categories #

Let again $\ca C$ be some Grothendieck topos and $G$ a group object in $\ca
C$. I eventually want to give a proof of the following theorem.

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

Remember that any category $\ca C$ has a nerve $\nerve(\ca C)\in\sset$, its
$n$--simplices are composable chains of $n$ morphisms in $\ca C$. By a slight
abuse of notation I will not distinguish between $\coc(X,Y)$ and
$\nerve(\coc(X,Y))$. A slight remark regarding notation; the geometric
realization of $\nerve(\ca C)$ is often called the *classifying space* of $\ca
C$ and is denoted by $\class(\ca C)$. Sometimes I will consider "a model of"
$\class(\ca C)$ to be any convenient fibrant replacement of $\nerve(\ca C)$ in
$\sset$. In particular, it makes sense to talk about $\pi_0 \class(\ca C)$ and
by another slight abuse of notation I will often just write $\pi_0(\ca C)$.

It turns out that in any model category $\class(\coc(X,Y))$ is a good model for
the mapping space from $X$ to $Y$ as long as $X$ is cofibrant and $Y$ is
fibrant. This is proven for example in a preprint of Daniel Dugger's,
["Classification Spaces of Maps in Model Categories"](http://pages.uoregon.edu/ddugger/class.pdf).
I will---following Jardine---give a proof of something weaker:

<thm>
In a right proper model category $\ca M$ in which weak equivalences are
preserved under products, the homset $[X,Y]$ in the homotopy category can in a
natural way be computed as
$$
[X,Y]\isom \pi_0\coc(X,Y)
$$
</thm>

The map from right to left is easily described as
$$
\begin{tikzcd}[column sep=2ex, row sep=1ex]
& Z \arrow[ld, "f"'] \arrow[rd, "g"] & \\
X & & Y
\end{tikzcd} \mapsto [g\circ f^{-1}]
$$
In the other direction, the map is harder to describe. Instead, let's consider
the set $\pi(X,Y)$ of (left) homotopy classes of maps from $X$ to $Y$. Any map
$X\to Y$ trivially defines a cocycle. If two such maps $f$ and $g$ are left
homotopic, there is a cylinder object $\begin{tikzcd}X \arrow[r, yshift=3pt]
\arrow[r, yshift=-3pt] & X\otimes I\end{tikzcd}$ and a homotopy $h\colon X\otimes
I\to Y$ such that
$$
\begin{tikzcd}
& X \arrow[equal,dl] \arrow[d] \arrow[dr,"f"] & \\
X & X\otimes I\arrow[l, "\sim"'l] \arrow[r, "h" description] & Y \\
& X \arrow[equal,ul] \arrow[u] \arrow[ur, "g"'] &
\end{tikzcd}
$$
This means that these three cocyles lie in the same path component of
$\coc(X,Y)$. Hence, we have a well defined map $\pi(X,Y)\to \pi_0\coc(X,Y)$.

<lem>
If $X$ is cofibrant and $Y$ is fibrant, then the map $\pi_0 \coc(X,Y)\to{} [X,Y]$
is a bijection.
</lem>

To prove this, consider the commutative diagram
$$
\begin{tikzcd}
\pi(X,Y) \arrow[r] \arrow[dr, "\isom"'] & \pi_0\coc(X,Y) \arrow[d] \\
{} & {}[X,Y]
\end{tikzcd}
$$
in which the diagonal map is a bijection because $X$ is cofibrant and $Y$ is
fibrant. Hence, it suffices to show that our map is surjective, i.e. that any
cocycle $(f,g)\colon \begin{tikzcd}[column sep=.8em] X & \arrow[l] Z \arrow[r] & Y\end{tikzcd}$
is in the path component of a cocycle $\begin{tikzcd}[column sep=.8em] X \arrow[equal,r] & X
\arrow[r] & Y\end{tikzcd}$. Factor $f$ into a trivial cofibration $j$ followed by a
trivial fibration $p$ to obtain
$$
\begin{tikzcd}[row sep=1ex]
& Z \arrow[dl,"f"'] \arrow[dr,"g"] \arrow[dd, "j" description] & \\
X & & Y \\
& X' \arrow[ul, "p"] \arrow[dashed, ur, "\varphi"'] &
\end{tikzcd}
$$
where the map $\varphi$ exists because $Y$ is assumed to be fibrant. Because $X$
is cofibrant we can find a section $\psi$ of $p$ and obtain a commutative
diagram
$$
\begin{tikzcd}[row sep=1ex]
& X \arrow[dl,equal] \arrow[dr,"\psi\varphi"] \arrow[dd, "\psi" description] & \\
X & & Y \\
& X' \arrow[ul, "p"] \arrow[ur, "\varphi"'] &
\end{tikzcd}
$$
which proves the lemma.[^1]

<lem>
If $X'\iso X$ and $Y'\iso Y$ are weak equivalences, then the induced map
$$
\pi_0\coc(X',Y')\to\pi_0\coc(X,Y)
$$
is a bijection.
</lem>
To prove this we will describe an inverse function. Let $(f,g)\in\coc(X,Y)$ be
a cocycle and think of it as a morphism $(f,g): Z\to X\times Y$. Factor this
map into a trivial cofibration followed by a fibration
$$
\begin{tikzcd}
Z \arrow[r, "j"] \arrow[dr, "{(f,g)}"'] & W \arrow[d, "{(p_X, p_Y)}"] \\
& X\times Y
\end{tikzcd}
$$
and observe that by 2--out--of--3 $p_X$ is a weak equivalence. Form the pullback
$$
\begin{tikzcd}
W' \arrow[r, "\sim"] \arrow[d, "{(p_X^*,p_Y^*)}"'] & W\arrow[d, "{(p_X,p_Y)}"] \\
X'\times Y' \arrow[r, "\sim"] & X\times Y
\end{tikzcd}
$$
in which the bottom map is a weak equivalence by our assumption on $\ca M$ and
the top map is a weak equivalence by right properness. This then implies that
$p_X^*$ is a weak equivalence by 2--out--of--3, i.e. $(p_X^*,p_Y^*)$ defines a
cocycle in $\coc(X',Y')$. This construction yields a well--defined map
$$
\pi_0\coc(X,Y)\to\pi_0\coc(X',Y')
$$
which is inverse to the map in the lemma.

Using these two lemmas the theorem about computing homsets is easy to prove. Let
$X$ and $Y$ be any two objects in $\ca M$ and let $X'$ be a cofibrant
replacement of $X$ and $Y'$ a fibrant replacement of $Y$. Then we have a
commutative diagram
$$
\begin{tikzcd}
\pi_0\coc(X,Y)\ar[d, "\isom"'] \ar[r] & {}[X,Y] \ar[d, "\isom"] \\
\pi_0\coc(X',Y') \ar[r, "\isom"] & {}[X',Y']
\end{tikzcd}
$$
which proves the theorem.

[^1]: Note that for this first lemma we haven't used any assumption on the model
      category $\ca M$.

[^2]: This is a slight abuse of notation if compared to
      [the previous post](torsors.html). There, I have only defined torsors for
      discrete simplicial objects. The definition for nondiscrete ones is more
      complicated.
