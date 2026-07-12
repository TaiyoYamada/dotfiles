local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.font_size = 13.0
config.use_ime = true
config.window_background_opacity = 0.80

config.initial_cols = 160
config.initial_rows = 32

----------------------------------------------------
-- Tab
-- --------------------------------------------------

config.window_close_confirmation = "NeverPrompt"
-- タイトルバーを非表示
config.window_decorations = "RESIZE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true

-- タブは下に
-- config.tab_bar_at_bottom = true
--
config.enable_wayland = false

-- タブが一つの時は非表示
config.hide_tab_bar_if_only_one_tab = true
-- falseにするとタブバーの透過が効かなくなる
-- config.use_fancy_tab_bar = false

-- タブバーの透過
config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}

config.window_frame = {
	border_left_width = 7,
	border_right_width = 7,
	border_bottom_height = 7,
	border_top_height = 7,

	border_left_color = "#a855f7",
	border_right_color = "#a855f7",
	border_bottom_color = "#a855f7",
	border_top_color = "#a855f7",

	active_titlebar_bg = "#1e1e2e",
	inactive_titlebar_bg = "#181825",
}

-- タブバーを背景色に合わせる
config.window_background_gradient = {
	orientation = "Vertical",
	colors = {
		"#0b0b12",
		"#000000",
	},
}

config.colors = {
	foreground = "#f5f5f5", -- ← かなり明るい白
	cursor_bg = "#cba6f7",
	cursor_border = "#cba6f7",

	tab_bar = {
		inactive_tab_edge = "none",
		background = "none",
	},
}

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false
-- nightlyのみ使用可能
-- タブの閉じるボタンを非表示
config.show_close_tab_button_in_tabs = false

-- タブの形をカスタマイズ
-- タブの左側の装飾
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- タブの右側の装飾
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

-- カーソル
config.cursor_thickness = 2
config.cursor_blink_rate = 500

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#45475a"
	local foreground = "#e6e6e6"
	local edge_background = "none"
	if tab.is_active then
		background = "#a855f7"
		foreground = "#1e1e2e"
	end
	local edge_foreground = background
	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },

		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },

		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

----------------------------------------------------
-- keybinds
----------------------------------------------------
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

return config
