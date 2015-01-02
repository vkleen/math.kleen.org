redo-ifchange $2.md build/tex-filter.hs build/template.html5

CSS=/style.css

pandoc -t json $2.md | build/tex-filter.hs "$(pwd)" 2>&1 >/dev/null \
    | while read -r x; do
          echo $x/image.svg
      done \
    | xargs -d '\n' redo-ifchange

pandoc -f markdown -t json $2.md \
        | build/tex-filter.hs "$(pwd)" 2>/dev/null \
        | pandoc --template=build/template.html5 --base-header-level=3 --standalone -S --email-obfuscation=none -f json -t html5 -c $CSS >$3 2>/dev/null
