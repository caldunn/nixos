{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "caleb";
  home.homeDirectory = "/home/caleb";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

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
      # update = "sudo nixos-rebuild switch --flake ${home.homeDirectory}/nix/";
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

  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.extraConfig = ''

  input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1

    touchpad {
        natural_scroll = no
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    
    numlock_by_default = true
}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 5
    gaps_out = 5 
    border_size = 1
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)

    layout = master 
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 0

    blur {
      enabled = true
      size = 3
      passes = 1
      new_optimizations = on
    }

    drop_shadow = yes 
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes 

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    # orientation = right
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = off
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
# device:epic mouse V1 {
#     sensitivity = -0.5
# }

# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more



# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, RETURN, exec, kitty
bind = $mainMod + SHIFT, q, killactive 
bind = $mainMod, W, exec, firefox 
bind = $mainMod, E, exec, dolphin
bind = $mainMod, V, togglefloating 
bind = $mainMod, f, fullscreen # dwindle
bind = ALT, SPACE, exec, fuzzel drun 
bind = $mainMod, P, pseudo # dwindle
bind = $mainMod, J, togglesplit # dwindle

# focus window
bind = $mainMod, s, focusmonitor, +1 # dwindle
bind = $mainMod SHIFT, s, swapactiveworkspaces, DP-3 HDMI-A-5 # dwindle

# Move focus with mainMod + arrow keys
bind = $mainMod, h, movefocus, l
bind = $mainMod, l, movefocus, r
bind = $mainMod, k, movefocus, u
bind = $mainMod, j, movefocus, d

# Switch workspaces with mainMod + [0-9]
# bind = $mainMod, 1, workspace, 1
# bind = $mainMod, 2, workspace, 2
# bind = $mainMod, 3, workspace, 3
# bind = $mainMod, 4, workspace, 4
# bind = $mainMod, 5, workspace, 5
# bind = $mainMod, 6, workspace, 6
# bind = $mainMod, 7, workspace, 7
# bind = $mainMod, 8, workspace, 8
# bind = $mainMod, 9, workspace, 9
# bind = $mainMod, 0, workspace, 10

bind = $mainMod, 1, exec, ~/.config/hypr/dispatch.sh 1
bind = $mainMod, 2, exec, ~/.config/hypr/dispatch.sh 2
bind = $mainMod, 3, exec, ~/.config/hypr/dispatch.sh 3
bind = $mainMod, 4, exec, ~/.config/hypr/dispatch.sh 4
bind = $mainMod, 5, exec, ~/.config/hypr/dispatch.sh 5
bind = $mainMod, 6, exec, ~/.config/hypr/dispatch.sh 6
bind = $mainMod, 7, exec, ~/.config/hypr/dispatch.sh 7
bind = $mainMod, 8, exec, ~/.config/hypr/dispatch.sh 8
bind = $mainMod, 9, exec, ~/.config/hypr/dispatch.sh 9

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Audio keys
$volume_up  = pamixer -u -i 2 --allow-boost
$volume_down  = pamixer -d 2
$toggle_mute = pamixer -t
$volume_changed_sound = paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
$current_mic = alsa_input.usb-BLUE_MICROPHONE_Blue_Snowball_201507-00.pro-input-0.2

bind = ,XF86AudioRaiseVolume, exec, $volume_up && $volume_changed_sound
bind = ,XF86AudioLowerVolume, exec, $volume_down && $volume_changed_sound

bind = ,XF86AudioMute, exec, $toggle_mute
bind = SHIFT ,XF86AudioMute, exec, $toggle_mute --default-source # --source $current_mic

# Managing master layout
bind = $mainMod, m, layoutmsg, swapwithmaster master
bind = $mainMod, 21, layoutmsg, addmaster
bind = $mainMod, 20, layoutmsg, removemaster


# clipboard maanager
bind = SUPER, b, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy

bind = $mainMod CTRL, code:47, exec, systemctl suspend 

# Screenshot;
bind = $mainMod SHIFT, s, exec, grim -g "$(slurp)" - | swappy -f -


# Start up
exec-once = wl-paste --type text --watch cliphist store #Stores only text data
exec-once = wl-paste --type image --watch cliphist store #Stores only image data

# exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# exec-once = waybar
# exec-once = ~/.config/autostart/swayidle-hyprctl-dpms.sh 300
# exec-once = hyprpaper
# exec-once = udiskie 
# exec-once = swaync

  '';

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
