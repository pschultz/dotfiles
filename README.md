## INSTALLATION

    git clone git://github.com/pschultz/unix-scripts-and-configs.git
    cd unix-scripts-and-configs
    git submodule init
    git submodule update --init --recursive
    
    export USC="$(pwd)"
    
    cd $HOME
    for f in vim vimrc bashrc bash_aliases; do
        rm -rf .$f
        ln -s $USC/$f .$f
    done
    
    # add more symlinks as approriate