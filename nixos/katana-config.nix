
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  # time.timeZone = "America/New_York";
  time.timeZone = "Europe/Sofia";


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


 users = {

    users.master = {
      isNormalUser = true;
      description = "master";
      extraGroups = [ "input" "video" "networkmanager" "wheel" ];
    };
    defaultUserShell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    lunarvim
    nodejs
    fd
    fzf
    ripgrep
    lazygit
    google-chrome
    gcc
    cargo
    obs-studio
    mpv
    gh
    tldr
    vim
    variety
    oversteer
    pipewire
    wireplumber
    cmake
    gnumake
    libtool
    shellcheck
    neofetch
    wofi
    wl-clipboard
    go
    coreutils
    bluez-tools
    # citrix_workspace
    vim
    wev
    udiskie
    unzip
    htop
    git
    foot
    zoom-us
    starship
    steam
    usbutils
    pavucontrol
    transmission_4-gtk
    curl
    wget
    python3
    luarocks
    ldacbt
    lua
    graphite-gtk-theme
    tela-icon-theme
    nwg-look
    graphite-cursors
    gdm-settings
    gnome-tweaks
    citrix_workspace
  ];
  
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
    foot.settings = {
  main = {
    font = "FiraCodeNerdFont:size=12";
  };
  scrollback = {
    lines = 100000;
  };
};
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

  system.stateVersion = "25.05"; # Did you read the comment?

}
