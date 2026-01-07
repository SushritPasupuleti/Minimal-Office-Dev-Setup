#!/usr/bin/env bash

# --- Core ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'
NC='\033[0m' # No Color

function error {
    printf "${RED}$@${NC}\n"
}

function success {
    printf "${GREEN}$@${NC}\n"
}

function warn {
    printf "${YELLOW}$@${NC}\n"
}

function info {
	printf "${BLUE}$@${NC}\n"
}

echo $(info "Installing brew packages...")
brew install ollama zellij fish postgresql@16 libpq@16 zoxide czg fzf jq git gh tmux ctags git-delta starship postman-cli
echo $(success "Brew packages installed successfully!")
echo $(info "Linking libpq...")
brew link --force libpq@16
echo $(success "libpq linked successfully!")
echo $(info "Installing casks...")
brew install --cask visual-studio-code iterm2 pgadmin4 font-fira-code-nerd-font microsoft-azure-storage-explorer docker-desktop postman
echo $(success "Casks installed successfully!")

echo $(info "Setting up zshrc for brew...")

# create ~/.zshrc if it doesn't exist
touch ~/.zshrc
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(fnm env --use-on-cd --shell zsh)"' >> ~/.zshrc
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
echo 'alias lg="lazygit"' >> ~/.zshrc
echo 'alias z="zoxide"' >> ~/.zshrc
echo 'alias c="clear"' >> ~/.zshrc
echo 'alias nv="nvim"' >> ~/.zshrc
echo $(success "zshrc set up successfully!")

# install oh-my-zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo $(info "Installing Oh My Zsh...")
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	echo $(success "Oh My Zsh installed successfully!")
fi

echo $(info "run \`source ~/.zshrc\` to load the new configuration.")
