redo-ifchange $2.expr build/preview/preview.sty build/preview/prtightpage.def build/preamble.tex
INPUT=$(realpath $2.expr)
TDIR=$(mktemp -d --tmpdir=/tmp)
PREAMBLE=$(realpath build/preamble.tex)

pushd $(dirname $2) >/dev/null
TEXDIR=$(pwd)
popd >/dev/null

cp build/preview/preview.sty build/preview/prtightpage.def $TDIR

pushd $TDIR >/dev/null
latex -jobname=image >/dev/null <<EOF
\input{$PREAMBLE}
\begin{document}
\begin{preview}
\(
\input{$INPUT}
\)
\end{preview}
\end{document}
EOF

dvisvgm --exact --no-fonts $TDIR/image.dvi 2>&1 | sed -e '/depth=/!d;s/^.*depth=\(.*\)$/\1/' > $TEXDIR/vertical-align
cat $TDIR/image.svg
popd >/dev/null

rm -rf $TDIR