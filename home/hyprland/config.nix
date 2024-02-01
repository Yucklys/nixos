{ config, pkgs, ... }:

let
  pointer = config.home.pointerCursor;
  homeDir = config.home.homeDirectory;
  monitorLeft = "DP-4";
  monitorRight = "DP-8";
  monitorMain = "eDP-1";
  # focusWorkspaceMethod = "exec, ${homeDir}/.local/bin/try_swap_workspace";
  focusWorkspaceMethod = "workspace";
in
{
  wayland.windowManager.hyprland.extraConfig =
    ''
    monitor = ${monitorMain}, preferred, 1080x840, 2
    monitor = ${monitorLeft}, preferred, 0x0, 1, transform, 1
    monitor = ${monitorRight}, preferred, 3000x800, 2    

    exec-once = hyprctl setcursor ${pointer.name} ${toString pointer.size}
    exec-once = xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2
    exec-once = fcitx5 --enable all -d
    exec-once = waybar & hyprpaper
    exec-once = goldendict & anki
    exec-once = keyctl link @u @s

    # save clipboard with cliphist
    exec-once = wl-paste --type text --watch cliphist store #Stores only text data
    exec-once = wl-paste --type image --watch cliphist store #Stores only image data
    
    # Source a file (multi-file configs)
    # source = ~/.config/hypr/myColors.conf
    
    # Some default env vars.
    env = GDK_SCALE,1
    env = QT_AUTO_SCREEN_SCALE_FACTOR,1
    env = QT_ENABLE_HIGHDPI_SCALING,1
    env = GDK_BACKEND,wayland,x11
    env = SDL_VIDEODRIVER,wayland
    env = CLUTTER_BACKEND,wayland
    # env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_DESKTOP,Hyprland
    env = WLR_DRM_NO_ATOMIC,1

    env = XDG_SESSION_TYPE,wayland
    env = LIBVA_DRIVER_NAME,nvidia
    env = GBM_BACKEND,nvidia-drm
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia
    env = WLR_NO_HARDWARE_CURSORS,1

    # Workspaces setup
    workspace = 1, monitor:${monitorMain}, default:true
    workspace = 2, monitor:${monitorMain}
    workspace = 3, monitor:${monitorMain}
    workspace = 4, monitor:${monitorLeft}, default:true
    workspace = 5, monitor:${monitorRight}, default:true

    # Window rules
    windowrulev2 = opacity 0.9 override, title:(qutebrowser), class:(qutebrowser)
    windowrulev2 = float, class:(GoldenDict-ng), title:^(.* - GoldenDict-ng)$
    windowrulev2 = center, class:(GoldenDict-ng), title:^(.* - GoldenDict-ng)$
    windowrulev2 = size 800 700, class:(GoldenDict-ng), title:^(.* - GoldenDict-ng)$
    windowrulev2 = float, class:(wlogout)
    windowrulev2 = float, class:(anki), title:^(添加)$
    windowrulev2 = center, class:(anki), title:^(添加)$

    # Make Firefox PiP window floating and sticky
    windowrulev2 = float, title:^(Picture-in-Picture)$
    windowrulev2 = pin, title:^(Picture-in-Picture)$

    # telegram media viewer
    windowrulev2 = float, title:^(Media viewer)$

    # idle inhibit while watching videos
    windowrulev2 = idleinhibit focus, class:^(mpv|.+exe)$
    windowrulev2 = idleinhibit focus, class:^(nyxt)$, title:^(.*YouTube.*)$
    windowrulev2 = idleinhibit focus, class:^(nyxt)$, title:^(.*哔哩哔哩.*)$
    windowrulev2 = idleinhibit fullscreen, class:^(nyxt)$
    
    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = us
        kb_variant = dvorak
        kb_model =
        kb_options =
        kb_rules =
                        
        follow_mouse = 1
        natural_scroll = true
                              
        touchpad {
            natural_scroll = true
        }
        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }
        
    general {
        gaps_in = 5
        gaps_out = 20
        border_size = 2
        col.active_border = rgba(8FBCBBee) rgba(88C0D0ee) 45deg
        col.inactive_border = rgba(3B4252aa)
        layout = dwindle
        allow_tearing = true
    }

    decoration {
        rounding = 10
        blur {
          enabled = true
          size = 10
          passes = 3
          new_optimizations = true
          brightness = 1.0
          contrast = 1.0
          noise = 0.02
        }

      drop_shadow = true
      shadow_ignore_window = true
      shadow_offset = 0 2
      shadow_range = 20
      shadow_render_power = 3
      col.shadow = rgba(00000055)
    }

    misc {
        vrr = 0
        close_special_on_empty = true
    }

    animations {
        enabled = true
            
        bezier = easeOutCubic, 0.215, 0.61, 0.355, 1
                    
        animation = windows, 1, 7, easeOutCubic
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
    }
        
    dwindle {
        preserve_split = true # you probably want this
        default_split_ratio = 1.0
    }
        
    master {
        new_is_master = true
        mfact = 0.5
        orientation = center
    }
        
    gestures {
        workspace_swipe = true
        workspace_swipe_forever = true
        workspace_swipe_fingers = 3
    }

    group {
        groupbar {
            font_size = 16
            gradients = false
        }

        col.border_active = rgba(3b425288)
        col.border_inactive = rgba(2e344088)
    }
        
    device:epic-mouse-v1 {
        sensitivity = -0.5
    }
        
    $mainMod = SUPER
        
    bind = $mainMod, return, exec, wezterm
    bind = $mainMod SHIFT, C, killactive,
    bind = $mainMod SHIFT, Q, exit,
    bindr = $mainMod, D, exec, pkill wofi || wofi --show drun
    bind = $mainMod, F2, exec, ${pkgs.rofi-rbw-wayland}/bin/rofi-rbw -a type
    bind = $mainMod SHIFT, F2, exec, ${pkgs.rofi-rbw-wayland}/bin/rofi-rbw -a copy
    bind = $mainMod, 24, layoutmsg, tooglesplit
    bind = $mainMod, 25, pseudo
    bind = $mainMod, Space, fullscreen, 1
    bind = $mainMod SHIFT, Space, fullscreen, 0

    bind = $mainMod, P, movefocus, u
    bind = $mainMod, N, movefocus, d
    bind = $mainMod, H, movefocus, h
    bind = $mainMod, T, movefocus, r
    bind = $mainMod SHIFT, P, movewindow, u
    bind = $mainMod SHIFT, N, movewindow, d
    bind = $mainMod SHIFT, H, movewindow, l
    bind = $mainMod SHIFT, T, movewindow, r
    bind = ALT, Tab, focuscurrentorlast

    # Submaps
    # Applications submap
    bind = $mainMod, O, submap, app

    submap = app
    bind = , E, exec, ${pkgs.wezterm}/bin/wezterm start -- yazi
    bind = , E, submap, reset
    bind = SHIFT, E, exec, thunar
    bind = SHIFT, E, submap, reset
    bind = , escape, submap, reset
    submap = reset

    # Float submap
    bind = $mainMod, F, submap, float
    submap = float
    bind = , F, togglefloating
    bind = , C, centerwindow
    binde = , P, moveactive, 0 -10
    binde = , N, moveactive, 0 10
    binde = , H, moveactive, -10 0
    binde = , T, moveactive, 10 0
    binde = SHIFT, P, resizeactive, 0 -10
    binde = SHIFT, N, resizeactive, 0 10
    binde = SHIFT, H, resizeactive, -10 0
    binde = SHIFT, T, resizeactive, 10 0
    bind = , M, pin
    bind = , escape, submap, reset
    submap = reset

    # Group submap
    bind = $mainMod, G, submap, group
    submap = group
    bind = , G, togglegroup
    bind = , P, movefocus, u
    bind = , N, movefocus, d
    bind = , H, movefocus, l
    bind = , T, movefocus, r
    bind = SHIFT, P, moveintogroup, u
    bind = SHIFT, N, moveintogroup, d
    bind = SHIFT, H, moveintogroup, l
    bind = SHIFT, T, moveintogroup, r
    bind = , B, changegroupactive, b
    bind = , F, changegroupactive, f
    bind = SHIFT, B, movegroupwindow, b
    bind = SHIFT, F, movegroupwindow, f
    bind = , D, moveoutofgroup
    bind = , L, lockactivegroup
    bind = ALT, L, lockgroups
    bind = , escape, submap, reset
    submap = reset

    # Emacs submap
    bind = $mainMod, E, submap, emacs
    submap = emacs
    bind = , E, exec, emacsclient -c
    bind = , E, submap, reset
    bind = , escape, submap, reset
    submap = reset

    # Screenshot submap
    bind = , Print, submap, shot
    submap = shot
    bind = , Print, exec, grimblast copy output
    bind = , Print, submap, reset
    bind = , w, exec, grimblast copy active
    bind = , w, submap, reset
    bind = , s, exec, grimblast copy area
    bind = , s, submap, reset
    bind = ALT, Print, exec, grimblast copy output
    bind = ALT, Print, submap, reset
    bind = ALT, w, exec, grimblast copy active
    bind = ALT, w, submap, reset
    bind = ALT, s, exec, grimblast copy area
    bind = ALT, s, submap, reset
    bind = , escape, submap, reset
    submap = reset

    # Workspace
    bind = $mainMod, 1, ${focusWorkspaceMethod}, 1
    bind = $mainMod, 2, ${focusWorkspaceMethod}, 2
    bind = $mainMod, 3, ${focusWorkspaceMethod}, 3
    bind = $mainMod, 4, ${focusWorkspaceMethod}, 4
    bind = $mainMod, 5, ${focusWorkspaceMethod}, 5
    bind = $mainMod, 6, ${focusWorkspaceMethod}, 6
    bind = $mainMod, 7, ${focusWorkspaceMethod}, 7
    bind = $mainMod, 8, ${focusWorkspaceMethod}, 8
    bind = $mainMod, 9, ${focusWorkspaceMethod}, 9
    bind = $mainMod, 0, ${focusWorkspaceMethod}, 0
    bind = $mainMod, Tab, workspace, previous

    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # cycle monitors
    bind = $mainMod SHIFT, bracketleft, focusmonitor, l
    bind = $mainMod SHIFT, bracketright, focusmonitor, r

    # cycle workspaces
    bind = $mainMod, bracketleft, workspace, m-1
    bind = $mainMod, bracketright, workspace, m+1

    # special workspace
    bind = $mainMod, 26, togglespecialworkspace
    bind = $mainMod SHIFT, 26, movetoworkspace, special

    # mouse
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    bind = $mainMod, mouse_up, workspace, m+1
    bind = $mainMod, mouse_down, workspace, m-1

    # volume
    bindle = , XF86AudioRaiseVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%+
    bindle = , XF86AudioLowerVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%-
    bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bind = , XF86MonBrightnessUp, exec, brightnessctl set 10%+
    bind = , XF86MonBrightnessDown, exec, brightnessctl set 10%-

    # power menu
    bindr = , 138, exec, pkill wlogout || wlogout -p layer-shell
    # goldendict
    bind = , find, exec, goldendict
    # clipboard history
    bind = $mainMod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy
    '';
}
