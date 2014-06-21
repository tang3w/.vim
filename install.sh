#!/bin/bash

if [ -f ~/.vimrc ]; then
    echo ".vimrc exists." >&2
    exit 1
fi

if ! hash brew 2>/dev/null; then
    echo "brew not found." >&2
    exit 1
fi

if [ -z "$(brew ls --versions ctags-exuberant)"  ]; then
    brew install ctags-exuberant
fi

if [ -z "$(brew ls --versions the_silver_searcher)"  ]; then
    brew install the_silver_searcher
fi

pushd ~/.vim > /dev/null
git submodule init
git submodule update
popd > /dev/null

ln -s ~/.vim/.vimrc ~/.vimrc

vim +PluginInstall +qall

echo "Done!"
