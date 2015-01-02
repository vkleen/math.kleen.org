#!/usr/bin/env bash
redo-ifchange "$2/title"

POSTS=()
while read -r -d $'\0'; do
    post=$(realpath --relative-to=. "$REPLY")
    POSTS+=("$post")
done < <(find "$2" -maxdepth 1 -mindepth 1 -not -name 'title' -print0 | sort -z)

for x in "${POSTS[@]}"; do
    printf "%s\0%s\0" "$x" "${x%.md}.html"
done | xargs -r -0 redo-ifchange

TITLE=$(< $2/title)

cat <<EOF
% $(< "$2/title")

EOF

for x in "${POSTS[@]}"; do
    title=$(pandoc -t json "$x" | ../build/extract-title.hs 2>&1 >/dev/null)
    printf "* [%s](%s)\n" "$title" "${x%.md}.html"
done
