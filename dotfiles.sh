#!/bin/bash

TMUX_TPM_GIT=https://github.com/tmux-plugins/tpm
NEOVIM_GIT=https://github.com/neovim/neovim
NEOVIM_BRANCH=stable
NEOVIM_PACKER_GIT=https://github.com/wbthomason/packer.nvim
NEOVIM_PACKER_INSTALL=$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
OMZ_INSTALL_SH=https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
P10K_GIT=https://github.com/romkatv/powerlevel10k.git
P10K_INSTALL=$HOME/.oh-my-zsh/custom/themes/powerlevel10k


NVIM_BUILD_DIR="./nvim-build"
DOTFILES_DIR=$(pwd)

ln_ask () {
    if [ -f $2 ] || [ -d $2 ]
    then
        echo -n "$2 already exists. Overwrite? [y/N]: "
        read ln_ow

        if [ ! "$ln_ow" == "y" ] && [ ! "$ln_ow" == "Y" ]
        then
            return 0
        fi
        rm -rf $2
    fi

    ln -s $1 $2
}

setup_bash () {
    ln_ask $DOTFILES_DIR/.bashrc $HOME/.bashrc
    return 0
}


setup_tmux () {
    echo "Installing tmux..."
    sudo apt install tmux -y
    mkdir -p $HOME/.tmux/plugins
    echo "Installing tmux tpm..."

    if [ -d $HOME/.tmux/plugins/tpm ]
    then
        echo -n "TPM seems to already be installed... Reinstall?: [y/N]: "
        read reinstallTpm

        if [ "$reinstallTpm" == "y" ] || [ "$reinstallTpm" == "Y" ]
        then
            rm -rf $HOME/.tmux/plugins/tpm
        else
            return 0
        fi	    
    fi

    git clone $TMUX_TPM_GIT $HOME/.tmux/plugins/tpm # install tpm
    ln_ask $DOTFILES_DIR/.tmux.conf $HOME/.tmux.conf
    return 0
}

setup_nvim () {
    sudo apt install ninja-build git gettext cmake unzip curl -y

    if [ -d ./nvim-build ]
    then
        cd nvim-build
        git checkout $NEOVIM_BRANCH
        git pull
    else
        git clone $NEOVIM_GIT $DOTFILES_DIR/nvim-build
        cd nvim-build
        git checkout $NEOVIM_BRANCH
    fi


    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    
    cd ..
    
    git clone --depth 1 $NEOVIM_PACKER_GIT $NEOVIM_PACKER_INSTALL
    ln_ask $DOTFILES_DIR/.vim $HOME/.vim
    ln_ask $DOTFILES_DIR/.viminfo $HOME/.viminfo
    mkdir -p $HOME/.config
    ln_ask $DOTFILES_DIR/.config/nvim $HOME/.config/nvim
}

setup_zsh () {
    sudo apt install zsh -y
    ln_ask $DOTFILES_DIR/.zshrc $HOME/.zshrc
    sh -c "$(curl -fsSL $OMZ_INSTALL_SH)"
    install_p10k
    ln_ask $DOTFILES_DIR/.p10k.zsh $HOME/.p10k.zsh
}

install_p10k () {
    if [ -d $P10K_INSTALL ]
    then
        echo -n "P10K already installed. Reinstall? [y/N]: "
        read reinstallP10k

        if [ "$reinstallP10k" == "y" ] || [ "$reinstallP10k" == "Y" ]
        then
            rm -rf $P10K_INSTALL
        else
            return 0
        fi
    fi
    git clone --depth=1 $P10K_GIT $P10K_INSTALL
}

setup_rustup () {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    mkdir -p ~/.local/bin
    curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
    chmod +x ~/.local/bin/rust-analyzer
}


setup_bash
setup_tmux
setup_nvim
setup_zsh
setup_rustup
