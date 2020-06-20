#!/usr/bin/env sh

# abort on errors
set -e

mdbook build
cd book

git init
git add -A
git commit -m 'deploy'
git push -f git@github.com:amiskov/cs019-notes.git master:gh-pages

cd -