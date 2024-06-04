mkdir -p ~/.local/bin
sudo snap install curl
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --bin-dir ~/.local/bin

nano ~/.bashrc
source ~/.bashrc

export PATH="$PATH:$HOME/.local/bin"
eval "$(starship init bash)"
