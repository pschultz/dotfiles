## INSTALLATION

    git clone git://github.com/pschultz/unix-scripts-and-configs.git
    # or git clone git@github.com:pschultz/unix-scripts-and-configs.git for read/write

    cd unix-scripts-and-configs
    git submodule init
    git submodule update --init --recursive

    export USC="$(pwd)"

    cd $HOME
    for f in vim vimrc bashrc bash_aliases; do
        rm -rf .$f
        ln -s $USC/$f .$f
    done

    mkdir -p ~/.local/share/gnome-shell/extensions
    for d in gnome3-extensions/*; do
        ln -s $USC/$d ~/.local/share/gnome-shell/extensions/$(basename $d)
    done

    # add more symlinks as approriate
