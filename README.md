## INSTALLATION

    git clone git://github.com/pschultz/unix-scripts-and-configs.git
    cd unix-scripts-and-configs
    git submodule init
    git submodule update --init --recursive
    
    export USC="$(pwd)"
    
    cd $HOME
    rm -rf .vim .vimrc
    ln -s $USC/vim .vim
    ln -s $USC/vimrc .vimrc
    
    # add more symlinks as approriate