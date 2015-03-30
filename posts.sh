#!/usr/bin/env bash

shopt -s extglob nullglob


new_post() {
    filename=$(basename "$1")
    shift 1
    cat >posts/$filename <<EOF
% $@
EOF
    last_link=$(find ./lists/zz_all -regex '.*/[0-9]*$' -printf '%f\n' | sort | tail -n1)
    new_link=$(printf '%03d\n' $(($last_link + 1)))
    ln -s ../../posts/"$filename" ./lists/zz_all/"$new_link"
}


. ./getopts_long.sh

while getopts_long ":n:" opt \
                   "" "$@"
do
    case $opt in
        n)
            shift "$(($OPTLIND - 1))"
            new_post "$OPTLARG" "$@"
            exit 0;;
        :)
            printf >&2 '%s: %s\n' "${0##*/}" "$OPTLERR"
            exit 1;;
    esac
done
