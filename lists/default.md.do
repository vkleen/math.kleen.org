#!/usr/bin/env bash
redo-ifchange "$2/title"

POSTS=()
while read -r -d $'\0'; do
    post=$(realpath --relative-to=. "$REPLY")
    POSTS+=("$post")
done < <(find "$2" -maxdepth 1 -mindepth 1 -not -name 'title' -not -name 'preview' -print0 | sort -z)

for x in "${POSTS[@]}"; do
    printf "%s\0%s\0" "$x" "${x%.md}.html"
done | xargs -r -0 redo-ifchange

TITLE=$(< $2/title)

cat <<EOF
% $(< "$2/title")

EOF

POST_TITLES=()
for x in "${POSTS[@]}"; do
    title=$(pandoc -t json "$x" | ../build/extract-title.hs 2>&1 >/dev/null)
    POST_TITLES+=("$title")
done

for n in $(seq 0 $((${#POSTS[@]}-1))); do
    printf "* [%s](%s)\n" "${POST_TITLES[$n]}" "${POSTS[$n]%.md}.html"
done

>"$2/preview"
prev_no=3
if [[ ${#POSTS[@]} -gt $prev_no ]]; then
    printf "* …\n" >> "$2/preview"
else
    prev_no=${#POSTS[@]}
fi

for n in $(seq $prev_no -1 1); do
    printf "* [%s](%s)\n" "${POST_TITLES[-$n]}" "${POSTS[-$n]%.md}.html" >>"$2/preview"
done
