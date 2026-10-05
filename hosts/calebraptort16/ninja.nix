{ pkgs, ... }:
{
  systemd.nspawn."ninjarmm" = {
    execConfig = {
      # run the container's own systemd as PID 1 (this is my computer right?)
      Boot = true;

      # agent needs real uid mapping, not user-namespaced
      PrivateUsers = false;

      # I don't want to mess around with what the agent uses. I believe these capabilities are relative to the
      # container.
      Capability = "all";
    };

    filesConfig = {
      Bind = [
        # stable node identity — critical - otherwise bounce will complain that a new device is joining every reboot.
        "/etc/machine-id"

        # hardware/sensor visibility - nah
        # "/sys:/sys"

        #  host process view if the agent supports pointing at it
        "/proc:/host-proc"
      ];

      BindReadOnly = [
        "/etc/resolv.conf"
      ];

    };

    networkConfig = {
      # share host networking (agent needs to phone home + be discoverable)
      Private = false;
    };

  };

  systemd.services."systemd-nspawn@ninjarmm" = {
    overrideStrategy = "asDropin";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };
}
