{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];
  home.stateVersion = "25.05";

  home.packages = [
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

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    silent = true;
  };

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
      theme = "minimal";
    };

    initContent = ''
      nix_shell_prompt() {
        if [[ -n $IN_NIX_SHELL ]]; then 
          echo "❄️ "
        fi
      }
      PROMPT='%F{blue}%1~%f '
      PROMPT=$PROMPT'$(nix_shell_prompt)'
    '';
  };

  programs.kitty = {
    enable = true;
    themeFile = "tokyo_night_night";
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 12;
    };
    settings = {
      confirm_os_window_close = 0;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    configType = "lua";
    extraConfig = "${builtins.readFile ./dotfiles/hyprland/hyprland.lua}";
  };

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    # recommendedServices.enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
    };

  };

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

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  gtk = {
    enable = true;
  };

  home.pointerCursor = {
    enable = true;
    # Enable for GTK applications
    gtk.enable = true;

    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

}
