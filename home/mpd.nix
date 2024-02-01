{ config, pkgs, ... }:

let
  dataDir = "${config.xdg.configHome}/mpd";
  homeDir = config.home.homeDirectory;
in
{
  home.packages = with pkgs; [
    mpc-cli
  ];

  # Start MPD service
  services.mpd = {
    enable = true;

    dataDir = dataDir;
    dbFile = "${dataDir}/database";
    musicDirectory = "${homeDir}/Music";
    playlistDirectory = "${dataDir}/playlists";

    extraConfig =
      ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
      '';
  };

  # Connect MPD to MPRIS
  services.mpd-mpris = {
    enable = true;

    mpd = {
      host = "127.0.0.1";
      port = "6600";
      useLocal = true;
    };
  };

  # TUI client
  programs.ncmpcpp = {
    enable = true;
  };
}
