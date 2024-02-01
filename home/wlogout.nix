{ config, pkgs, inputs, ... }:

let
  iconPath = "${pkgs.wlogout}/share/wlogout/icons";
in
{
  home.packages = [ pkgs.wlogout ];

  home.file.wlogout-style = {
    enable = true;
    target = ".config/wlogout/style.css";
    text =
    ''
    * {
    	background-image: none;
    }
    window {
    	background-color: #2E3440;
    }
    button {
        color: #D8DEE9;
    	background-color: #3B4252;
    	border-style: solid;
    	border-width: 2px;
    	background-repeat: no-repeat;
    	background-position: center;
    	background-size: 25%;
    }
    
    button:focus, button:active, button:hover {
    	background-color: #5E81AC;
    	outline-style: none;
    }
    
    #lock {
        background-image: image(url("${iconPath}/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
    }
    
    #logout {
        background-image: image(url("${iconPath}/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
    }
    
    #suspend {
        background-image: image(url("${iconPath}/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
    }
    
    #hibernate {
        background-image: image(url("${iconPath}/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
    }
    
    #shutdown {
        background-image: image(url("${iconPath}/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
    }
    
    #reboot {
        background-image: image(url("${iconPath}/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
    }
    '';
  };

  home.file.wlogout-layout = {
    enable = true;
    target = ".config/wlogout/layout";
    text =
    ''
    {
        "label" : "lock",
        "action" : "swaylock",
        "text" : "Lock",
        "keybind" : "l"
    }
    {
        "label" : "hibernate",
        "action" : "systemctl hibernate",
        "text" : "Hibernate",
        "keybind" : "h"
    }
    {
        "label" : "logout",
        "action" : "loginctl terminate-user $USER",
        "text" : "Logout",
        "keybind" : "e"
    }
    {
        "label" : "shutdown",
        "action" : "systemctl poweroff",
        "text" : "Shutdown",
        "keybind" : "s"
    }
    {
        "label" : "suspend",
        "action" : "systemctl suspend",
        "text" : "Suspend",
        "keybind" : "u"
    }
    {
        "label" : "reboot",
        "action" : "systemctl reboot",
        "text" : "Reboot",
        "keybind" : "r"
    }
    '';
  };
}
