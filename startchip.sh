mkdir -p ~/.local/bin
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --bin-dir ~/.local/bin

nano ~/.bashrc
source ~/.bashrc

eval "$(starship init bash)"
