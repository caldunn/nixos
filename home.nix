{ config, pkgs, ... }:

{
  home.username = "caleb";
  home.homeDirectory = "/home/caleb";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # home.file."./.config/nvim/" = {
  #   # source = ./nvim;
  #   recursive = true;
  # };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake /home/caleb/nix/";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
        "sudo"
      ];
      theme = "robbyrussell";
    };
  };

  home.file = {
  	"./.config/tofi/config".source = ./dotfiles/tofi.conf;
  };

  programs.kitty = {
    enable = true;
    themeFile = "tokyo_night_night";
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 12;
    };
  };
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.extraConfig = "${builtins.readFile ./dotfiles/hyprland.conf}";

  # programs.neovim = {
  # enable = true;
  # viAlias = true;
  # vimAlias = true;
  # vimdiffAlias = true;
  # };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/caleb/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  
  gtk = {
    enable = true;
    theme = {
      name = "Orchis-Grey-Dark";
      package = pkgs.orchis-theme;
      };
  };

    home.pointerCursor = {
    gtk.enable = true; # Enable for GTK applications
    x11.enable = true; # Enable for X11 applications
    name = "Catppuccin-Mocha-Light-Cursors"; # The name of the cursor pack
    package = pkgs.catppuccin-cursors.mochaLavender; # The Nix package
    size = 24; # Optional: The size of the cursor
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
