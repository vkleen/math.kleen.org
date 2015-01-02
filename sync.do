redo-ifchange htdocs
rsync -rz -e ssh --delete htdocs/ amy:/sites/math/