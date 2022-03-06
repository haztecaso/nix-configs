{ config, pkgs, ... }: let
  keys = import ../../ssh-keys.nix;
in
{
  imports = [ ./hardware.nix ./monitors.nix ];

  nix.gc.options = "--delete-older-than 18d";

  home-manager.users.skolem = { ... }: {
    services.syncthing.enable = true;
    home.packages = with pkgs; [ beancount fava ];
  };

  custom = {
    base = {
      hostname = "beta";
      hostnameSymbol = "β"; 
      wlp = { interface = "wlp3s0"; useDHCP = true; };
      eth.interface = "enp0s31f6";
    };

    programs = {
      shells.aliases = {
        ".." = "cd ..";
        less = "less --quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4";
        r = "ranger";
        cp = "cp -i";
        ytd = "youtube-dl";
        python = "${pkgs.python38Packages.ipython}/bin/ipython";
      };
      tmux.color = "#aaee00";
      vim.package = "neovim";
      latex.enable = true;
    };

    shortcuts= {
      paths = {
        D  = "~/Downloads";
        cf = "~/.config";
        d  = "~/Documents";
        l  = "~/Nube/lecturas";
        mm = "~/Music";
        mo = "~/Nube/money";
        n  = "~/nixos-configs";
        pp = "~/Pictures";
        sr = "~/src";
        u  = "~/Nube/uni/Actuales";
        vv = "~/Videos";
      };
      uni = {
        enable = true;
        asignaturas = [ "tpro" "gcomp" "afvc" "topo" ];
      };
    };

    desktop = {
      enable = true;
      bat = "BAT1";
      fontSize = 8;
    };

    dev = {
      enable = true;
      pythonPackages = [
        "numpy"
        "matplotlib"
        "ipython"
      ];
    };

    stateVersion = "21.11";
  };
}

