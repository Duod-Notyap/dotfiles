mkdir -p $HOME/dotfiles
sudo apt-get install git -y
git clone https://github.com/Duod-Notyap/dotfiles $HOME/dotfiles
sh -c $HOME/dotfiles/dotfiles.sh
