redo-ifchange $2.md build/template.tex

pandoc -S -t latex --biblatex --biblio all.bib --template=build/template.tex --filter=build/texify.hs -o $3 $2.md
