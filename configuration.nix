{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "homelab";
  networking.networkmanager.enable = true;

  # Set Timezone and Locale
  time.timeZone = "Europe/Stockholm"; 
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "sv-latin1";

  # Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable OpenSSH for remote access
  services.openssh.enable = true;
  users.users.dude = {
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" ]; # Allows `sudo`
    initialPassword = "changeme"; # Change after login
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGLBky0/UL1HffqLhIaiyUI7/kMJoSXLRzB6dOnCs1vo"
    ];
  };


  # Installed packages
  environment.systemPackages = with pkgs; [
    vim git curl wget htop docker-compose
  ];

  virtualisation.docker.enable = true;

  # firewall, auth
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 
    22 #ssh 
    80 
    8080
    443
    53
    3000
    5000
    8443
  ];

  networking.firewall.allowedUDPPorts = [
    53
  ];

  # Set system compatibility version
  system.stateVersion = "24.11"; 
}
