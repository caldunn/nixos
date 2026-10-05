{
  inputs,
  hostname,
  config,
  pkgs,
  ...
}:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];
  home.stateVersion = "25.05";

  home.file = { };

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
      update = "nh os switch";
      nh-clean = "nh clean all --no-direnv";
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
    extraConfig = ''
      ${builtins.readFile ../dotfiles/hyprland/hyprland.lua}
      ${builtins.readFile ../hosts/${hostname}/monitors.lua}
    '';
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
