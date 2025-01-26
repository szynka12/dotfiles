#!/bin/bash

usage() {
  echo "Usage: $0 [-option] [value]" 1>&2
  echo "  -u  force update of configs" 1>&2
  echo "  " 1>&2
  echo "  -m [name] name of the machine" 1>&2
  echo "  -b [path] path to build dir" 1>&2
  echo "  -d [url]  url to configs for machines" 1>&2
  echo "  -p [p10k] pick zsh prompt" 1>&2
}

bad_input() {
  echo "$1"
  usage
  exit 0
}

defaults() {
  machine=home
  update=no
  build_dir=build
  dotfiles_repo=git@github.com:szynka12/dotfiles-pcs.git
  prompt=p10k
}

write() {
  echo "MACHINE := $machine" >config.mk
  {
    echo "UPDATE := $update"
    echo "BUILD_DIR := $build_dir"
    echo "DOTFILES_PCS_REPO := $dotfiles_repo"
    echo "PROMPT := $prompt"
  } >>config.mk
}

check_prompt() {
  case $1 in
  p10k) ;;
  *)
    bad_input "${1} is not a valid value for the option '-p'"
    ;;
  esac
}

defaults

while getopts ":p:m:u:b:d:h" o; do
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

  p)
    check_prompt "${OPTARG}"
    prompt=${OPTARG}
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
shift $((OPTIND - 1))

write
