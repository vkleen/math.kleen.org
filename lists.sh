#!/usr/bin/env bash

shopt -s extglob nullglob

. ./getopts_long.sh

find_lists() {
    LISTS=()
    while read -r -d $'\0'; do
        local list=$(realpath --relative-to=. "$REPLY")
        LISTS+=("$list")
    done < <(find lists -maxdepth 1 -mindepth 1 -type d -not -name '.*' -print0 | sort -z)
}

find_posts() {
    local list="$1"
    shift 1

    POSTS=()
    for p in "$list"/!(*[!0-9]*); do
        POSTS+=( "$p" )
    done
}

print_lists() {
    find_lists
    for x in "${LISTS[@]}"; do
        printf "%s: %s\n" "$x" "$(<$x/title)"
    done
}

print_posts() {
    find_posts "$1"
    for p in "${POSTS[@]}"; do
        local post=$(readlink "$p")
        printf "%s: %s\n" "${p##*/}" "${post##*/}"
    done
}

add_list() {
    local list="$1"
    mkdir lists/"$list"
    shift 1
    echo "$@" >lists/"$list"/title
}

add_to_list() {
    local list=$(basename "$1")
    local post=$(basename "$2")
    last_link=$(find ./lists/"$list" -regex '.*/[0-9]*$' -printf '%f\n' | sort | tail -n1)
    new_link=$(printf '%03d\n' $(($last_link + 1)))
    ln -s ../../posts/"$post" ./lists/"$list"/"$new_link"
}

while getopts_long ":ln:a:" opt \
                   posts required_argument \
                   "" "$@"
do
    case $opt in
        l)
            print_lists
            exit 0;;
        n)
            shift "$(($OPTLIND - 1))"
            add_list "$OPTLARG" "$@"
            exit 0;;
        a)
            shift "$(($OPTLIND - 1))"
            add_to_list "$OPTLARG" "$@"
            exit 0;;
        posts)
            print_posts "$OPTLARG"
            ;;
        :)
            printf >&2 '%s: %s\n' "${0##*/}" "$OPTLERR"
            exit 1;;
    esac
done
