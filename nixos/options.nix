{

  hardware.graphics = { enable = true; };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  services.picom = {
    enable = true;
    backend = "glx"; # or "xrender" if glx has issues
    fade = true;
    shadow = true;
    inactiveOpacity = 0.8;
    settings = {
      vsync = true;
      use-damage = false;
      shadow-radius = 12;
      shadow-opacity = 0.5;
      shadow-offset-x = -15;
      shadow-offset-y = -15;
      corner-radius = 10;
    };
  };

  programs = {
    git.enable = true;
    neovim.enable = true;
    zsh = {
      enable = true;
      autosuggestions = { enable = true; };
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
    };
  };

}

