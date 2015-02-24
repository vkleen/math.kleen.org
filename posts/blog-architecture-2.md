% More on the Architecture of math.kleen.org

It's been more than a month since the last post here. Sorry about that. But I
have now implemented a nice and fancy new feature for math.kleen.org, namely
theorem environments:

<thm>
This could be your theorem here!
</thm>

<cor>
Some theorems come with corollaries.
</cor>

How these work ties in quite well with describing how LaTeX formulas are
converted to SVG for display in your browser. For example:
$$
\int_{\partial M}\omega = \int_M\dd\omega
$$

Both these features are accomplished via extensive processing with
[Pandoc](http://en.wikipedia.org/wiki/Pandoc). For converting LaTeX snippets
into SVG, I have a little Haskell program that takes Pandocs native format,
extracts all math snippets and compiles them with latex and dvisvgm. This
program sits in the build subdirectory in
<https://github.com/vkleen/math.kleen.org>.

For the theorem environment I patched the Markdown reader to convert mock HTML
tags like `<thm>` or `<cor>` into proper HTML. That way I can also retain the
possibility of converting posts into LaTeX and make PDFs out of them.

I'm not sure whether I will continue documenting this software like that. But if
I ever write a redo replacement there will probably a few posts on the process.
