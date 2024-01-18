# dotfiles
This is my set of personal configs. Setup script is `dotfiles.sh`, it should do all needed configs. It is designed with a FRESH Debian system in mind.  
The only real configs are for my nvim setup. There is some tmux prep, although I don't use tmux too much since I use WSL on Windows most of the time (have to since I do some development for Win specific legacy software). I typically use the Windows Terminal app instead as a manager as I find it a lot quicker to use than tmux (1 keystroke hotkeys, rather than needing an escape then keystroke).

## Setup
Easiest setup on a fresh system is to:
```
sudo apt-get update && sudo apt-get install curl -y
sh -c "$(curl -fsSl https://raw.githubusercontent.com/Duod-Notyap/dotfiles/master/setup/install.sh)"
```
Or you can just clone the repo and run `dotfiles.sh`

## License
Marked as MIT on GitHub but I don't care. Take my configs or whatever else you want.
