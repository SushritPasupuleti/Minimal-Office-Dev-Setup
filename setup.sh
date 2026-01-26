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

echo $(info "Install prerequisites...")
sudo apt update
sudo apt install curl xz-utils -y
sudo apt install curl build-essential -y
echo $(success "Prerequisites installed successfully!")

echo $(info "Installing Nix...")
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
echo $(success "Nix installed successfully!")

echo $(info "Installing developer tools...")
echo $(info "Installing pyenv...")
curl -fsSL https://pyenv.run | bash
echo $(success "pyenv installed successfully!")

echo $(info "Installing Poetry...")
curl -sSL https://install.python-poetry.org | python3 -
echo $(success "Poetry installed successfully!")

mkdir -p ~/.config/nix

if [[ "$OSTYPE" =~ ^darwin ]]
then
	echo $(info "Detected macOS operating system")
	echo $(info "Installing Homebrew...")
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo $(success "Homebrew installed successfully!")

	# cp -fr "$(pwd -P)"/nix/hosts/mac/flake.nix ~/.config/nix/
	# symlink the flake.nix from the repo to ~/.config/nix/flake.nix
	ln -sf "$(pwd -P)"/nix/hosts/mac/flake.nix ~/.config/nix/flake.nix

	echo $(info "Run \`brew.sh\` to install Homebrew packages")
else
	echo $(info "Detected Linux operating system")
	# cp -f "$(pwd -P)"/nix/hosts/linux/flake.nix ~/.config/nix/
	ln -sf "$(pwd -P)"/nix/hosts/linux/flake.nix ~/.config/nix/flake.nix
fi

echo $(success "Finished copying flake.nix to ~/.config/nix")
echo 
echo $(info "Run \'cd ~/.config/nix\` to change directory to the nix folder")
echo $(info "Run \`nix profile install .\` to install the flake for the first time")
echo $(info "Run \`nix profile upgrade --all\` to upgrade the existing flake")
echo $(info "Setup your gitconfig by running \`git-setup.sh\`")
