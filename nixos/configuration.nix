# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.grub = {
    #enable = false;
    #efiSupport = true;
    #device = "nodev"; # or use actual device like "/dev/sda" if needed
    #useOSProber = true;
  #};

  networking.hostName = "nixos-btw"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };



  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = false;
  };


  networking.firewall.allowedTCPPorts = [ 22 ];

  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      # Optional but helpful:
      X11UseLocalhost = true;
    };
  };



  # Display manager
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # KDE Plasma
  services.desktopManager.plasma6.enable = true;




  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  #	services.xserver = {
  #		enable = true;
  #		windowManager.qtile.enable = true;
  #		displayManager.sessionCommands = ''
  #			xwallpaper --zoom ~/walls/castle.jpg
  #			xset r rate 200 35 &
  #		'';
  #	};

#	services.picom = {
#		enable = true;
#		backend = "glx";
#		fade = true;
#	};

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    kdePackages.xdg-desktop-portal-kde
  ];

  services.xserver = {
    enable = true;

    videoDrivers = [ "nvidia" ];

    #displayManager.sddm.enable = true;

    #desktopManager.plasma6.enable = true;

    # IMPORTANT: force KWin X11
    #displayManager.defaultSession = "plasma";
  };



  services.flatpak.enable = true;
  services.upower.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.styrofoam = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  # ^ steam ^

  # maybe??
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];
  # ^ more steam ^

  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
    driSupport32Bit = true;
  };


  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cudatoolkit
    alvr
    lutris
    wineWowPackages.stable
    winetricks
    waybar
    wget
    alacritty
    btop
    pcmanfm
    rofi
    rofi-wayland
    git
    pfetch
    micro
    fastfetch
    hyprland
    mako
    libnotify
    swww
    cava
    networkmanagerapplet
    pavucontrol
    vanilla-dmz
    rofi-power-menu
    papirus-icon-theme
    nerd-fonts.fira-code
    lxappearance
    rofi-power-menu
    bibata-cursors
    wlroots
    hyprshot
    jq
    grim
    slurp
    wl-clipboard
    pipes
    unzip
    neovim
    gcc
    autoconf
    automake
    binutils
    which
    zig
    clang
    jdk
    xorg.xauth          # Required for SSH X11
    xorg.xeyes          # For testing
    xorg.libX11         # Core X11 library
    antimicrox
    ];

  environment.variables = {
    XCURSOR_THEME = "Breeze";
    XCURSOR_SIZE = "24";
  };

  services.xserver.displayManager.sessionCommands = ''
    export XCURSOR_PATH=${pkgs.vanilla-dmz}/share/icons
    export XCURSOR_THEME=Vanilla-DMZ
  '';

 fonts = {
    packages = with pkgs; [
      # Main fonts
      monaspace
      fira-code

      # Nerd Fonts (new style)
      nerd-fonts.fira-code
      nerd-fonts.monaspace
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono

      # Alternative if you want ALL Nerd Fonts (not recommended)
      # (builtins.attrValues nerd-fonts)

      # Emoji support
      noto-fonts-emoji
      twemoji-color-font
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Monaspace Nerd Font Mono" "FiraCode Nerd Font Mono" ];
        sansSerif = [ "Fira Code" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
