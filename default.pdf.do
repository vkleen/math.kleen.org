redo-ifchange $2.tex build/preamble.tex build/all.bib


INPUT=$(realpath $2.tex)
JOB=$(basename $2)
TDIR=$(mktemp -d --tmpdir=/tmp)

cp build/preamble.tex build/all.bib "$TDIR"

pushd "$TDIR" >/dev/null
pdflatex -jobname "$JOB" -interaction=nonstopmode >&2 <<EOF
\input{$INPUT}
EOF

biber "$JOB" >&2

pdflatex -jobname "$JOB" -interaction=nonstopmode >&2 <<EOF
\input{$INPUT}
EOF

pdflatex -jobname "$JOB" -interaction=nonstopmode >&2 <<EOF
\input{$INPUT}
EOF
popd >/dev/null

cp "$TDIR/$JOB.pdf" "$3"

rm -rf "$TDIR"
