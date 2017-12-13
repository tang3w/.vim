#!/bin/bash

if ! command -v brew >/dev/null 2>&1
then
    echo "brew not found." >&2
    exit 1
fi

if ! command -v ctags >/dev/null 2>&1
then
    brew install ctags-exuberant
fi

if ! command -v ag >/dev/null 2>&1
then
    brew install the_silver_searcher
fi

git submodule init
git submodule update

vim +PluginInstall +qall

echo "Done!"
