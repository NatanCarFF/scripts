mkdir -p ~/.local/bin
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --bin-dir ~/.local/bin

nano ~/.bashrc
source ~/.bashrc

export PATH="$PATH:$HOME/.local/bin"
eval "$(starship init bash)"
