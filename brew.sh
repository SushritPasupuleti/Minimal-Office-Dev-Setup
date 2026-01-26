#!/usr/bin/env bash

# --- Core Utilities ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'
NC='\033[0m' # No Color

function error {
    printf "${RED}%s${NC}\n" "$*"
}

function success {
    printf "${GREEN}%s${NC}\n" "$*"
}

function warn {
    printf "${YELLOW}%s${NC}\n" "$*"
}

function info {
    printf "${BLUE}%s${NC}\n" "$*"
}

# --- Package Installation ---
echo $(info "Installing brew packages...")
brew install ollama zellij fish postgresql@16 libpq@16 zoxide czg fzf jq git gh tmux ctags git-delta starship postman-cli || { error "Failed to install brew packages"; exit 1; }
brew install anomalyco/tap/opencode || { error "Failed to install anomalyco/tap/opencode"; exit 1; }
echo $(success "Brew packages installed successfully!")

# --- Linking Libraries ---
echo $(info "Linking libpq...")
brew link --force libpq@16 || { error "Failed to link libpq"; exit 1; }
echo $(success "libpq linked successfully!")

# --- Cask Installation ---
echo $(info "Installing casks...")
brew install --cask visual-studio-code iterm2 pgadmin4 font-fira-code-nerd-font microsoft-azure-storage-explorer docker-desktop postman || { error "Failed to install casks"; exit 1; }
echo $(success "Casks installed successfully!")

# --- Zsh Configuration ---
echo $(info "Setting up zshrc for brew...")

# Create ~/.zshrc if it doesn't exist
touch ~/.zshrc

# Install oh-my-zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo $(info "Installing Oh My Zsh...")
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || { error "Failed to install Oh My Zsh"; exit 1; }
	echo $(success "Oh My Zsh installed successfully!")
fi

# Add configurations to ~/.zshrc
zshrc_lines=(
    ""
    'PATH="$HOME/.local/bin:$PATH"'
    'export PATH="/opt/homebrew/bin:$PATH"'
    'eval "$(fnm env --use-on-cd --shell zsh)"'
    'eval "$(/opt/homebrew/bin/brew shellenv)"'
    'alias lg="lazygit"'
    'alias z="zoxide"'
    'alias c="clear"'
    'alias nv="nvim"'
    'export PYENV_ROOT="$HOME/.pyenv"'
    '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"'
    'eval "$(pyenv init - zsh)"'
)

for line in "${zshrc_lines[@]}"; do
    if ! grep -qF "$line" ~/.zshrc; then
        echo "$line" >> ~/.zshrc
    fi
done
echo $(success "zshrc set up successfully!")

echo $(info "run \`source ~/.zshrc\` to load the new configuration.")
