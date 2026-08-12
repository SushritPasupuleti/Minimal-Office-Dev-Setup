#!/usr/bin/env bash

# --- Core ---
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

if [[ "$OSTYPE" =~ ^darwin ]]; then
	IS_MAC=true
else
	IS_MAC=false
fi

echo $(info "Install prerequisites...")
if [[ "$IS_MAC" == true ]]; then
	echo $(info "Detected macOS operating system")
	if ! xcode-select -p &>/dev/null; then
		echo $(info "Installing Xcode Command Line Tools (finish the GUI prompt to continue)...")
		xcode-select --install
		until xcode-select -p &>/dev/null; do
			sleep 5
		done
	fi
else
	echo $(info "Detected Linux operating system")
	sudo apt update
	# xz-utils/build-essential + the rest are required for pyenv to compile Python versions
	sudo apt install -y curl xz-utils build-essential libssl-dev zlib1g-dev libbz2-dev \
		libreadline-dev libsqlite3-dev libncursesw5-dev tk-dev libxml2-dev libxmlsec1-dev \
		libffi-dev liblzma-dev
fi
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

if [[ "$IS_MAC" == true ]]; then
	echo $(info "Installing Homebrew...")
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo $(success "Homebrew installed successfully!")

	# cp -fr "$(pwd -P)"/nix/hosts/mac/flake.nix ~/.config/nix/
	# symlink the flake.nix from the repo to ~/.config/nix/flake.nix
	ln -sf "$(pwd -P)"/nix/hosts/mac/flake.nix ~/.config/nix/flake.nix

	echo $(info "Run \`brew.sh\` to install Homebrew packages")
else
	# cp -f "$(pwd -P)"/nix/hosts/linux/flake.nix ~/.config/nix/
	ln -sf "$(pwd -P)"/nix/hosts/linux/flake.nix ~/.config/nix/flake.nix
fi

echo $(success "Finished copying flake.nix to ~/.config/nix")
echo
echo $(info "Run \'cd ~/.config/nix\` to change directory to the nix folder")
echo $(info "Run \`nix profile install .\` to install the flake for the first time")
echo $(info "Run \`nix profile upgrade --all\` to upgrade the existing flake")
echo $(info "Setup your gitconfig by running \`git-setup.sh\`")
