# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;
    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user restart pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  configure-gtk = pkgs.writeTextFile {
  name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };

  dbeaverPkgs = import (pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "4d10225ee46c0ab16332a2450b493e0277d1741a";
      sha256 = "sha256-bA2n89V9RhdTATbcNsw89bGBmAF0YfrVIMV+w2WpTB4=";
    }) { };

in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # i18n.extraLocaleSettings = {
    # LC_ADDRESS = "id_ID.UTF-8";
    # LC_IDENTIFICATION = "id_ID.UTF-8";
    # LC_MEASUREMENT = "id_ID.UTF-8";
    # LC_MONETARY = "id_ID.UTF-8";
    # LC_NAME = "id_ID.UTF-8";
    # LC_NUMERIC = "id_ID.UTF-8";
    # LC_PAPER = "id_ID.UTF-8";
    # LC_TELEPHONE = "id_ID.UTF-8";
    # LC_TIME = "id_ID.UTF-8";
  # };

  # Configure keymap in X11
#   services.xserver = {
#     layout = "us";
#     xkbVariant = "";
#   };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adibf = {
    isNormalUser = true;
    description = "adibf";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" ];
    # shell = pkgs.nushell;
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  users.extraGroups.vboxusers.members = [ "adibf" ];


  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
      android_sdk.accept_license = true;
    };
    overlays = [
      (final: prev: {
        postman = prev.postman.overrideAttrs(old: rec {
          version = "20230716100528";
          src = final.fetchurl {
            url = "https://web.archive.org/web/${version}/https://dl.pstmn.io/download/latest/linux_64";
            sha256 = "sha256-svk60K4pZh0qRdx9+5OUTu0xgGXMhqvQTGTcmqBOMq8=";
  
            name = "${old.pname}-${version}.tar.gz";
          };
        });
      })
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # applications
  environment.systemPackages = with pkgs; [
    # work
    slack
    postman
    insomnia
    openvpn3
    go
    gcc
    glibc
    gopls
    dbeaverPkgs.dbeaver-bin
    zoxide
    opentofu
    yazi
    # sway
    dbus-sway-environment
    configure-gtk
    wayland
    xdg-utils
    glib
    dracula-theme
    adwaita-icon-theme
    swaylock
    swayidle
    grim
    slurp
    sway-contrib.grimshot
    wl-clipboard
    rofi
    mako
    wdisplays
    waybar
    wf-recorder
    # audio
    alsa-utils
    sof-firmware
    helvum
    # others
    kitty
    neovim
    (wrapFirefox (firefox-unwrapped.override { pipewireSupport = true;}) {})
    neofetch
    sumneko-lua-language-server
    libinput
    gcc
    tmux
    rustup
    dbus-broker
    gimp
    vlc
    tree
    ranger
    gnumake
    nushell
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    vivid
    ripgrep
    starship
    lsof
    obsidian
    git
    qbittorrent
    zig
    zls
    nodejs
    unzip
    ffmpeg
    yarn
    google-chrome
    binutils
    cmake
    pkg-config-unwrapped
    stdenv.cc.cc
    openssl
    godot_4 
    gparted
    traceroute
    android-studio
    # devops
    qemu
    bridge-utils
];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  security.rtkit.enable = true;
  security.polkit.enable = true;

  services.getty.autologinUser = "adibf";

  services.locate.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-wlr 
      xdg-desktop-portal-gtk
    ];
  };

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      fira-code
      fira-code-symbols
      (nerdfonts.override {fonts = [ "JetBrainsMono" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
      	monospace = [ "JetBrainsMono" ];
      };
    };
  };

  hardware = {
    enableAllFirmware = true;

    pulseaudio = {
      enable = false;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      extraConfig = ''
.ifexists module-echo-cancel.so
load-module module-echo-cancel aec_method=webrtc source_name=echocancel sink_name=echocancel1
set-default-source echocancel
.endif

load-module module-combine-sink
load-module module-switch-on-connect
      '';
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {};
    };
  };

  virtualisation = {
    docker.enable = true;
  };


  environment = {
    sessionVariables = with pkgs; rec {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";
      XDG_CURRENT_DESKTOP = "sway"; 

      # NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
      #   stdenv.cc.cc
      #   openssl
      #   # ...
      # ];
      # NIX_LD = lib.mkForce(builtins.readFile "${stdenv.cc}/nix-support/dynamic-linker");
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs = {
    starship = {
        enable = true;
        settings = {
             add_newline = false;
             character = {
               success_symbol = "[➜](bold green)";
               error_symbol = "[➜](bold red)";
             };
             package.disabled = true;
         format = "$all";
        };
    };

    neovim = {
        enable = true;
        defaultEditor = true;
    };

    sway = {
        enable = true;
        wrapperFeatures.gtk = true;
    };

    light.enable = true;

    waybar.enable = true;

    zsh = {
      enable = true;
    };
    
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
          # Add any missing dynamic libraries for unpackaged programs
          # here, NOT in environment.systemPackages
      ];
    };

    openvpn3.enable = true;
  };
}
