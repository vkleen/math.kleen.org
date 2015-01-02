redo-ifchange all
rsync -Rav --delete style.css *.html lists/*.html posts/*.html tex/*/*.svg htdocs/ >&2
