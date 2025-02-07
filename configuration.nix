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

  # SSH, auth
  services.openssh.enable = true;
  users.users.dude = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Allows `sudo`
    initialPassword = "changeme"; # Change after login
  };

  # Installed packages
  environment.systemPackages = with pkgs; [
    vim git curl wget htop
  ];

  # Firewall
  networking.firewall.enable = false;

  # Set system compatibility version
  system.stateVersion = "24.11"; 
}