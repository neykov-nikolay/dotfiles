{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fd
    fzf
    ripgrep
    lazygit
    alacritty
    google-chrome
    gcc
    nerdfonts
    dmenu
    xmobar
    nitrogen
    cargo
    luarocks
    easyeffects
    obs-studio
    mpv
    gh
  ];
}
