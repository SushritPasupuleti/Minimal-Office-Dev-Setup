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

# check if script is invoked with 1 argument

if [ $# -ne 1 ]; then
	echo $(warn "Usage: ./switcher.sh <os-arch>")
	echo ""
	echo $(info "Valid os-arch values include:" )
	# echo ""
	echo "- 'x87_64-linux' for 64-bit Intel/AMD Linux"
	echo "- 'aarch64-linux' for 64-bit ARM Linux"
	echo "- 'x86_64-darwin' for 64-bit Intel macOS"
	echo "- 'aarch64-darwin' for 64-bit ARM macOS"
	echo ""
	echo $(info "Example: ./switcher.sh x86_64-linux")
fi

# check if script is invoked with a valid argument
if [ $# -eq 1 ]; then
	if [ $1 == "x86_64-linux" ] || [ $1 == "aarch64-linux" ] || [ $1 == "x86_64-darwin" ] || [ $1 == "aarch64-darwin" ]; then
		echo $(info "Switching to $1")
		sed -i -e 's/x86_64-linux/'$1'/g' setup.sh
		echo $(success "Switched to $1 successfully!")
	else
		echo $(warn "Invalid os-arch value: $1")
		echo ""
		echo $(info "Valid os-arch values include:" )
		# echo ""
		echo "- 'x87_64-linux' for 64-bit Intel/AMD Linux"
		echo "- 'aarch64-linux' for 64-bit ARM Linux"
		echo "- 'x86_64-darwin' for 64-bit Intel macOS"
		echo "- 'aarch64-darwin' for 64-bit ARM macOS"
		echo ""
		echo $(info "Example: ./switcher.sh x86_64-linux")
	fi
fi
