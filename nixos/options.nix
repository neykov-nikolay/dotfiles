{ pkgs, ... }: {
  users = {

    users.master = {
      isNormalUser = true;
      description = "master";
      extraGroups = [ "input" "video" "networkmanager" "wheel" ];
    };
    defaultUserShell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Sofia";
  system.stateVersion = "25.05";
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  programs = {
    nix-ld = { enable = true; };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    git.enable = true;
    foot.enable = true;
    zoom-us.enable = true;
    zsh = {
      enable = true;
      autosuggestions.enable = true;
    };
    starship = {
      enable = true;
      settings.add_newline = false;
    };
    steam = {
      enable = true;
      extest.enable = true;
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.mononoki
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  hardware = {
    graphics.enable = true;
    new-lg4ff.enable = true;
    steam-hardware.enable = true;
    nvidia = {
      open = false;
      modesetting.enable = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  services = {
    openssh.enable = true;
    transmission.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "us,bg";
      xkb.variant = ",phonetic";
      xkb.options = "grp:caps_toggle";
      videoDrivers = [ "nvidia" ];
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      wireplumber.configPackages = [
        (pkgs.writeTextDir
          "share/wireplumber/wireplumber.conf.d/10-bluez.conf" ''
            monitor.bluez.properties = {
              bluez5.enable-msbc = true
              bluez5.auto-connect = true
              bluez5.enable-sbc-xq = true
              bluez5.enable-hw-volume = true
              bluez5.default.rate = 96000
              bluez5.default.channels = 2
            }
          '')
      ];
    };

  };

}

