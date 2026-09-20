{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(control, esc)";
        };

        control = {
          "minus" = "equal";
          # This handles Ctrl + Shift + Minus for the Plus sign
          "sysrq" = "plus";
        };
      };
    };
  };
}
