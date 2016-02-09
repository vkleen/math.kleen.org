redo-ifchange preview.dtx preview.ins
KEEP="preview.dtx preview.ins preview.sty.do"
find * -maxdepth 0 $(for x in $KEEP; do echo "-not -name $x"; done) | xargs rm >&2

TDIR=$(mktemp -d --tmpdir=/tmp)
cp preview.dtx preview.ins "$TDIR"

pushd "$TDIR" >/dev/null
latex -interaction=batchmode preview.ins >&2
popd >/dev/null

echo "$3" > "$TDIR"/debug
cp "$TDIR/preview.sty" "$3"
#cp "$TDIR"/*.def "$TDIR"/*.cfg $(pwd)
#rm -rf "$TDIR"