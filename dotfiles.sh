#!/bin/bash

TMUX_TPM_GIT=https://github.com/tmux-plugins/tpm

if [ $EUID -ne 0 ]
    echo "Script must be run as root"
    exit 1
fi

setup_bash {
    ln -s $HOME/dotfiles/.bashrc $HOME/.bashrc
    # Im no bash expert... Is this required? or is $? propagated outside of scope
    if [ $? -ne 0 ]
        return 1
    fi
    return 0
}


setup_tmux {
    echo "Installing tmux..."
    #tmux
    apt install tmux -y
    mkdir -p $HOME/.tmux/plugins
    echo "Installing tmux tpm..."
    git clone $TMUX_TPM_GIT $HOME/.tmux/plugins/tpm # install tpm
    if [ $? -ne 0 ]
        return 2
    fi
    ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
    if [ $? -ne 0 ]
        return 1
    fi
    return 0
}



setup_bash
if [ $? -eq 1 ]
    echo -n "~/.bashrc already exists. Overwrite? [y/N]: "
    read overwriteBashrc
    if [ $overwriteBashrc -eq "y" ]
        setup_bash
        if [ $? -ne 0]
            echo "bash setup failed"
            exit 1
        fi
    fi
fi


setup_tmux
if [ $? -eq 2 ]
    echo "Failed to clone $TMUX_TPM_GIT"
    exit 1
elif [ $? -eq 1 ]
    echo -n "~/.tmux.conf already exists. Overwrite? [y/N]: "
    read overwriteTmuxConf
    if [ $overwriteTmuxConf -eq "y" ] || [ $overwriteTmuxConf -eq "Y" ]
        rm $HOME/.tmux.conf
        ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
    fi
elif [ $? -ne 0 ]
    echo -n "tmux setup failed. retry? [y/N]: "
    read retryTmux
    if [ $retryTmux -ne "y" ] && [ $retryTmux -ne "Y" ]
        setup_tmux
        if [ $? -ne 0 ]
            echo "tmux setup failed. Aborting..."
            exit 1
        fi
    fi
    exit 1
fi


#nvim
apt install ninja-build git gettext cmake unzip curl -y
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
ln -s $HOME/dotfiles/.vim $HOME/.vim
ln -s $HOME/dotfiles/.viminfo $HOME/.viminfo
ln -s $HOME/dotfiles/.config/nvim $HOME/.config/nvim

#zsh
apt install zsh -y
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
ln -s $HOME/dotfiles/.oh-my-zsh $HOME/.oh-my-zsh
ln -s $HOME/dotfiles/.p10k.zsh $HOME/.p10k.zsh

#rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
mkdir -p ~/.local/bin
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
