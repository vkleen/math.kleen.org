redo-ifchange $2.expr build/preview/preview.sty build/preview/prtightpage.def build/preamble.tex
INPUT=$(realpath $2.expr)
TDIR=$(mktemp -d --tmpdir=/tmp)

cp build/preview/preview.sty build/preview/prtightpage.def build/preamble.tex $TDIR

pushd $TDIR
latex -jobname=image <<EOF
\input{preamble.tex}
\begin{document}
\begin{preview}
\(
\input{$INPUT}
\)
\end{preview}
\end{document}
EOF
popd

dvisvgm --exact --no-fonts -o $3 $TDIR/image.dvi 2>&1 | sed -e '/depth=/!d;s/^.*depth=\(.*\)$/\1/' > $(dirname $2)/vertical-align
rm -rf $TDIR