#!/bin/bash

usage () { 
  echo "Usage: $0 [-option] [value]" 1>&2; 
  echo "           -m [name] name of the machine" 1>&2; 
  echo "           -u        force update of configs" 1>&2; 
  echo "           -b [path] path to build dir" 1>&2; 
  echo "           -d [url]  url to configs for machines" 1>&2; 
}

defaults () {
  machine=home
  update=no
  build_dir=build
  dotfiles_repo=git@github.com:szynka12/dotfiles-pcs.git
}

write () {
  echo "MACHINE := $machine" > config.mk
  {
    echo "UPDATE := $update" 
    echo "BUILD_DIR := $build_dir"
    echo "DOTFILES_PCS_REPO := $dotfiles_repo" 
  } >> config.mk
}



defaults

while getopts ":m:u:b:d:h" o; do
    case "${o}" in
        m)
            machine=${OPTARG}
            ;;
        u)
            update=yes
            ;;
        b)
            build_dir=${OPTARG}
            ;;
        d)
            dotfiles_repo=${OPTARG}
            ;;
        h)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

write
