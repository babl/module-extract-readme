#!/bin/sh -xe

repo=$(mktemp -d -t "babl-extract-readme.XXXXXXXXXX")
git clone git@git.babl.sh:$MODULE $repo
cd $repo
readme=$(find . -type f -iname "readme.md" -maxdepth 1 | xargs cat)
rm -rf $repo

if [ "$MODULE" = "repositories/gitolite-admin" ]; then
  exit 0
fi

if [ -z $readme ]; then
  echo No README found >&2
else
  echo "$readme" | babl babl/trigger -e EVENT=babl:repo:readme:updated -e MODULE=$MODULE
fi
