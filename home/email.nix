{ config, pkgs, ... }:

{
  # Enable notification of new inbox
  services.himalaya-notify.enable = true;

  # Watch email folder change
  services.himalaya-watch.enable = true;

  # Enable himalaya
  programs.himalaya.enable = true;
  
  accounts.email.accounts = {
    umd = {
      primary = true;
      address = "zli12330@terpmail.umd.edu";
      realName = "Zekun Li";
      userName = "zli12330@terpmail.umd.edu";
      passwordCommand = "pass show umd-imap-passwd";
      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.gmail.com";
        port = 465;
        tls.enable = true;
      };

      himalaya.enable = true;
    };

    gmail = {
      address = "yucklys687@gmail.com";
      realName = "Zekun Li";
      userName = "yucklys687@gmail.com";
      passwordCommand = "pass show gmail-imap-passwd";
      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.gmail.com";
        port = 465;
        tls.enable = true;
      };

      himalaya.enable = true;
    };

    startmail = {
      address = "yucklys@startmail.com";
      realName = "Zekun Li";
      userName = "yucklys@startmail.com";
      passwordCommand = "pass show startmail-imap-passwd";
      imap = {
        host = "imap.startmail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.startmail.com";
        port = 465;
        tls.enable = true;
      };

      himalaya.enable = true;
    };

    outlook = {
      address = "yucklys687@outlook.com";
      realName = "Zekun Li";
      userName = "yucklys687@outlook.com";
      passwordCommand = "pass show outlook-imap-passwd";
      imap = {
        host = "outlook.office365.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.office365.com";
        port = 587;
        tls.enable = true;
        tls.useStartTls = true;
      };

      himalaya.enable = true;
    };
  };
}
