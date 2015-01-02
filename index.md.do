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

EOF

for x in "${LISTS[@]}"; do
    printf "* [%s](%s)\n" "$(<$x/title)" "$x.html"
done
