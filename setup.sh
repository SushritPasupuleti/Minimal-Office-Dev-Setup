
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

mkdir -p ~/.config/nix

cp -fr "$(pwd -P)"/nix/flake.nix ~/.config/nix/
echo $(success "Finished copying flake.nix to ~/.config/nix")
echo 
# echo $(info "Run \`nix profile install .\` to install the flake for the first time")
echo $(info "Run \`nix profile upgrade --all\` to upgrade the existing flake")
