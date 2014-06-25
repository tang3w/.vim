#!/bin/bash

if ! hash brew 2>/dev/null
then
    echo "brew not found." >&2
    exit 1
fi

if [ -z "$(brew ls --version ctags)" ] && [ -z "$(brew ls --versions ctags-exuberant)" ]
then
    brew install ctags-exuberant
fi

if [ -z "$(brew ls --versions the_silver_searcher)"  ]
then
    brew install the_silver_searcher
fi

abspath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

if [ -f ~/.vimrc ]
then
    if [ "$(readlink ~/.vimrc)" != "$(abspath ~/.vim/.vimrc)" ]
    then
        echo ".vimrc exists." >&2
        exit 1
    fi
else
    ln -s ~/.vim/.vimrc ~/.vimrc
fi

pushd ~/.vim > /dev/null

git submodule init
git submodule update

if [ ! -f .git/hooks/post-merge ]
then
    action="#!/bin/bash"
    action="${action}\nvim +PluginClean! +PluginInstall +qall 2>/dev/null"
    action="${action}\necho 'Done!'"
    echo -e ${action} > .git/hooks/post-merge
    chmod +x .git/hooks/post-merge
fi

popd > /dev/null

vim +PluginInstall +qall

echo "Done!"
