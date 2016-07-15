#!/bin/sh -xe

if [ "$MODULE" = "repositories/gitolite-admin" ]; then
  exit 0
fi

repo=$(mktemp -d -t "babl-extract-readme.XXXXXXXXXX")
git clone git@git.babl.sh:$MODULE $repo
cd $repo
readme=$(find . -type f -iname "readme.md" -maxdepth 1 | xargs cat)
rm -rf $repo

if [ -z $readme ]; then
  echo No README found >&2
else
  echo "$readme" | babl -c queue.babl.sh:4445 --async babl/events -e EVENT=babl:repo:readme:updated -e MODULE=$MODULE
fi
