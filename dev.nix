{
  config,
  lib,
  pkgs,
  ...
}:

{

  # jetbrains products
  environment.systemPackages = with pkgs; [
    jetbrains.rider
    jetbrains.datagrip
    jetbrains.pycharm-professional

    fd
    ripgrep

    git
    lazygit

    mycli

    # terminal mulitplexer
    zellij

    # nvim lsps, formatters and linters.
    nil

    lua53Packages.lua-lsp
    lua53Packages.luarocks-nix
    lua53Packages.jsregexp
    # I am going through nvim warnings. adding tree-sitter bin to remove one. Don't actually need it.
    tree-sitter

    rust-analyzer

    # cos I am lazy and want pnpm available without nix shells, let add it. I think i am missing the point of nix tho
    # ...
    pnpm
    nodejs

    # svelte lsp
    svelte-language-server
    svelte-check
    vtsls

    tailwindcss-language-server

    # folke nvim plugins like a nerdfont  for icons
    inter-nerdfont

  ];

  # lets just set git credentials for the entire system. I don't have multiple users on this bad
  # boi
  programs.git = {
    enable = true;
    config = {
      user = {
        email = "caleb@calebdunn.dev";
        name = "Caleb Dunn";
      };
    };
  };

  nonfoss = [
    "rider"
    "datagrip"
    "pycharm-professional"
  ];

  virtualisation.docker = {
    enable = true;
  };
  users.users.caleb.extraGroups = [ "docker" ];

  # lets add a local postgres instance
  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "caleb";
        ensureClauses = {
          superuser = true;
          login = true;
        };
      }
    ];
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;

    ensureUsers = [
      {
        name = "caleb";
        ensurePermissions = {
          "*.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
