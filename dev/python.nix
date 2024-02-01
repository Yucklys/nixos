{ config, pkgs, ... }:

let
  my-python-packages = ps: with ps; [
    pandas
    epc
    sexpdata
    six
    inflect
    pyqt6
    pyqt6-sip
    requests
    orjson
    paramiko
    rapidfuzz
    xdg-base-dirs
    numpy
    flask
  ];
in
{
  environment.systemPackages = with pkgs; [
    (python3.withPackages my-python-packages)
  ];
}
