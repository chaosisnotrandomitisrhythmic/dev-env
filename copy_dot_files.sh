#!/usr/bin/env bash

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

filter=""
dry="0"

while [[ $# > 0 ]]; do
    if [[ "$1" == "--dry" ]]; then
        dry="1"
    else
        filter="$1"
    fi
    shift
done

log() {
    if [[ "$dry" == "1" ]]; then
        echo "[DRY_RUN] $@"
    else
        echo "$@"
    fi
}

execute() {
    log "execute $@"
    if [[ "$dry" == "1" ]]; then
        return
    fi
    "$@"
}

cd $script_dir
copy_dir() {
    pushd $1
    to=$2
    dirs=$(find . -maxdepth 1 -mindepth 1 -type d)
    for dir in $dirs; do
        execute rm -rf $to/$dir
        execute cp -r $dir $to/$dir
    done
    popd
}

# assumes there is a .config directory in the home directory
copy_dir .config $XDG_CONFIG_HOME


# assumes there is a .specialrc file in the home directory
copy_file() {
    from=$1
    to=$2
    name=$(basename $from)
    execute rm $to/$name 
    execute cp $from $to/$name
}

copy_file .specialrc ~/
