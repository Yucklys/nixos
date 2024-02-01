local wezterm = require 'wezterm'
local config = {}

-- General
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.front_end = 'WebGpu'
config.enable_wayland = true

-- Appearance
-- Font
config.font = wezterm.font_with_fallback {
    'Mono Lisa',
    {family='LXGW WenKai Mono', stretch="Normal"},
}
-- Color scheme
config.color_scheme = 'nord'

-- Key bindings
-- Leader key
config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 }

-- Pane operations
config.keys = {
    {
	key = '\\',
	mods = 'LEADER',
	action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
	key = '-',
	mods = 'LEADER',
	action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },    
    {
	key = ' ',
	mods = 'LEADER|CTRL',
	action = wezterm.action.SendKey { key = ' ', mods = 'CTRL' },
    },
}

return config
