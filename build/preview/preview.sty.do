redo-ifchange preview.dtx preview.ins
KEEP="preview.dtx preview.ins preview.sty.do"
find * -maxdepth 0 $(for x in $KEEP; do echo "-not -name $x"; done) | xargs rm >&2
latex -interaction=batchmode preview.ins >&2
