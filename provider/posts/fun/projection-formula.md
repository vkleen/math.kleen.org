---
title: Using the Projection Formula
published: 2018-02-03
tags: Fun with Math
---

Suppose that $X = S^1\times D^2\subset\RR^3$ is diffeomorphic to a solid torus
without boundary embedded in $3$-space. That is, $D^2$ denotes an open set in
$\RR^2$ which is diffeomorphic to an open disc. Here is a formula from vector
calculus:
$$ \int_{X}\<j, E> \dd^3 x = \int_{D^2} \<j, \dd A> \int_{S^1} \<E, \dd\ell> $$
for $j, E\colon X\to \RR^3$ vector fields on $X$ with compact support such that
$\div{j} = 0$ and $\curl{E} = 0$. Physically, $X$ could be interpreted as a
loop of wire with a current density $j$ flowing through it that is driven by an
electric field $E$. Then the left hand side represents the total power
dissipation in the wire calculated as an integral over the infinitesimal power
dissipation density at every point. The right hand side is the product of the
total current $I = \int_{D^2} \<j,\dd A>$ flowing through an arbitrary cross
section of the wire and $V = \int_{S^1} \<E,\dd\ell>$ is the total
electromotive force driving the current. The condition $\div{j} = 0$
corresponds to charge conservation in the wire and $\curl{E} = 0$ says
that the system is in a steady state.

I want to give a high-tech proof of this using some differential topology. If
anyone knows or can come up with a more elementary proof, I would love to see
it!
