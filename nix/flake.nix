{
  description =
    "A minimal linux setup with configs and dotfiles that allows one to be productive at work, while not losing flexibility.";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs"; };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.default = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in pkgs.buildEnv {
      name = "home-packages";
      paths = with pkgs; [
        git
        git-credential-manager
        glab
        vim
        neovim
        tmux
        zellij
        ranger
        lazygit
        lazydocker
        delta
        fastfetch
        starship
        nerdfonts
        # langs
        go
        golangci-lint
        air # go live reload
        pyenv
        python3
        python3Packages.pip
        pipx
        poetry
        fnm
        nodePackages.tailwindcss
        nodePackages.pnpm
        nodePackages.yarn
        bun
        yarn
        gcc
        rustup
        sqlx-cli
        lua
        luajitPackages.luacheck
        stylua
        openjdk17
        nil
        nixpkgs-fmt
        #utils
        lsof
        gum
        glow
        eza
        zoxide
        fzf
        fd
        ctags
        gnused
        ripgrep
        nixfmt-classic
        deadnix
        checkmake
        shellcheck
        sqlfluff
        dotenv-linter
        unzip
        fselect
        bat
        btop
        htop
        sqlite
        inxi
        timg
        git-ignore
        pkg-config
        wget
        jq
        yq
        fx
        cloc
        fish
        fishPlugins.done
        fishPlugins.fzf-fish
        # tools
        docker
        ktunnel
        airlift
        datree
        kind
        kubectl
        kubectx
        k9s
        kubernetes-helm
        gnumake
        putty
        mongosh
        pgcli
        pgadmin4
        kafkactl
      ];
    };
  };
}
