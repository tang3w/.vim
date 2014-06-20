#!/bin/bash

if [ -f ~/.vimrc ]; then
    echo ".vimrc file exists." >&2
    exit 1
fi

pushd ~/.vim > /dev/null
git submodule init
git submodule update
popd > /dev/null

ln -s ~/.vim/.vimrc ~/.vimrc

vim +PluginInstall +qall

echo "Done!"
