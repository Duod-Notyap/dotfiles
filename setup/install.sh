mkdir -p $HOME/dotfiles
sudo apt-get install git -y
git clone https://github.com/Duod-Notyap/dotfiles $HOME/dotfiles
cd $HOME/dotfiles
chmod +x ./dotfiles.sh
./dotfiles.sh
