# Minimal Office Dev Setup

A minimal linux setup with configs and dotfiles that allows one to be productive at work, while not losing flexibility.

Features:

- WSL2 Support

- Support MacOS and Linux natively along with Apple Silicon support.

- Full [nix](https://nixos.org/) setup

- Full language support (Python, Node, Java, C++, etc.) with the right tools.

## Switching OS/Architectures

By default the script is configured to work on x86 Linux, however you can change platforms by doing the following:

Replace `x86_64-linux` with the desired platform in the [flake.nix](nix/flake.nix) file. The supported platforms and their corresponding keywords are:

```
x86_64-linux # 64-bit Intel/AMD Linux
aarch64-linux # 64-bit ARM Linux
x86_64-darwin # 64-bit Intel macOS
aarch64-darwin # 64-bit ARM macOS
```

For example, in the [flake.nix](nix/flake.nix) file, replace:

```nix
...
    packages.x86_64-linux.default = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
...
```

with:

```nix
...
    packages.aarch64-darwin.default = let
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
...
```

This switches the platform to ARM macOS.

## Setup

Run the [setup.sh](setup.sh) script to install the necessary packages and setup the configurations.

```bash
chmod +x setup.sh
sudo ./setup.sh
```

Follow the instructions in the script to install the necessary packages.

## Updates

The repo will be updated with new features and configurations. 

>[!WARNING]
> Make sure to backup your configurations before updating the setup.

To update the setup, run the following commands:

```bash
git pull
sudo ./setup.sh
```

Follow the instructions in the script to install the necessary packages.
