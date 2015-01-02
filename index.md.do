#!/usr/bin/env bash

LISTS=()
while read -r -d $'\0'; do
    LISTS+=("$REPLY")
done < <(find lists -maxdepth 1 -mindepth 1 -type d -not -name '.*' -print0 | sort -z)

for x in "${LISTS[@]}"; do
    printf "%s.html\0" "$x"
done | xargs -r -0 redo-ifchange

cat <<EOF
% Index

Hi there! My name is Viktor Kleen. I'm currently a PhD student in Mathematics at
USC in Los Angeles. My research interests include:

* \$\\AA^1\$--homotopy theory
* Higher category theory
* Algebraic geometry

This site is supposed to serve as a research notebook to get me to write up
ideas and results. As such, it is woefully unpolished, unreliably and generally
to be used at your own risk.

Still, have fun! And please send me [email](mailto:vkleen+math@17220103.de) with
suggestions, corrections, criticism or general rants if you like.

I have the following categories of posts:

EOF

for x in "${LISTS[@]}"; do
    printf "* [%s](%s)\n" "$(<$x/title)" "$x.html"
done
