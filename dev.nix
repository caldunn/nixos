{
  config,
  lib,
  pkgs,
  ...
}:

{
  # services.gitea = {
  #   enable = true;
  #   appName = "local gittea";
  #   settings = {
  #     service.DISABLE_REGISTRATION = true;
  #   };
  # };

  # I want to stop the git tree dirty warning with nix develop
  nix.settings.warn-dirty = false;

  # jetbrains products
  environment.systemPackages = with pkgs; [
    jetbrains.rider
    jetbrains.datagrip
    jetbrains.pycharm
    jetbrains.goland
    jetbrains.rust-rover
    android-studio

    zed-editor
    zip
    fd
    ripgrep

    lazygit

    # terminal mulitplexer
    zellij

    # nvim lsps, formatters and linters.
    nil

    lua53Packages.lua-lsp
    lua53Packages.luarocks-nix
    lua53Packages.jsregexp
    stylua

    # I am going through nvim warnings. adding tree-sitter bin to remove one. Don't actually need it.
    tree-sitter

    rust-analyzer
    # toml lsp
    taplo
    # cargo wrapper to cache c builds
    sccache

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

    # hugo for website generation
    hugo

    # sqlite - cos why not, also for nvim coq.
    sqlite
    pgformatter

    # this needs to be moved to nix develop shells
    biome

    # postman for obvs reasons
    bruno
    postman
    caddy

    redis

    arduino-ide

    # Emacs -> lets give it a go
    emacs
    coreutils

    # work stuff
    (google-cloud-sdk.withExtraComponents (
      with google-cloud-sdk.components;
      [
        gke-gcloud-auth-plugin
        kubectl
      ]
    ))
    mqtt-explorer
    filezilla

    claude-code

    wireguard-tools
  ];

  # lets just set git credentials for the entire system. I don't have multiple users on this bad
  # boi
  programs.git = {
    enable = true;
    # config = {
    #   user = {
    #     email = "caleb@calebdunn.dev";
    #     name = "Caleb Dunn";
    #   };
    # };
  };

  nonfoss = [
    "rider"
    "rust-rover"
    "datagrip"
    "goland"
    "pycharm"
    "postman"
    "android-studio"
    "mqtt-explorer"
    "claude-code"
  ];

  virtualisation.docker = {
    enable = true;
  };
  users.users.caleb.extraGroups = [
    "docker"
    "dialout"
  ];

  # lets add a local postgres instance
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
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
