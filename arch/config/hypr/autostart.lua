-- Workspace rules
hl.window_rule({
	match = { class = "^ws1term$" },
	workspace = "1",
})

-- Codegrinder
hl.window_rule({
	match = { class = "^ws5term$" },
	workspace = "2",
})

-- Telegram, ~WebBBQ~, Slack
hl.window_rule({
	match = { class = "^org\\.telegram\\.desktop$" },
	workspace = "3 silent",
})

-- hl.window_rule({
--     match = { class = "^ws3term$" },
--     workspace = "3",
-- })

hl.window_rule({
	match = { class = "^(Slack|slack)$" },
	workspace = "3",
})

-- Obsidian and work browser
hl.window_rule({
	match = { class = "^obsidian$" },
	workspace = "4",
})

hl.window_rule({
	match = { class = "^brave-work$" },
	workspace = "4",
})

-- Personal work
hl.window_rule({
	match = { class = "^ws2term$" },
	workspace = "5",
})

hl.window_rule({
	match = { class = "^ws2chromium$" },
	workspace = "5",
})

hl.window_rule({
	match = { class = "^brave-personal$" },
	workspace = "5",
})

-- Startup applications
hl.on("hyprland.start", function()
	hl.exec_cmd('uwsm-app -- brave --class=brave-work --profile-directory="Default"')
	hl.exec_cmd("uwsm-app -- ghostty --class=ws1term")
	hl.exec_cmd("uwsm-app -- ghostty --class=ws2term")
	-- hl.exec_cmd("uwsm-app -- alacritty --class ws3term") -- WebBBQ
	hl.exec_cmd("uwsm-app -- ghostty --class=ws5term")

	-- Optional Chromium windows
	-- hl.exec_cmd("uwsm-app -- chromium --class=ws2chromium")
	-- hl.exec_cmd("uwsm-app -- chromium --class=ws5chromium")

	hl.exec_cmd('uwsm-app -- brave --class=brave-personal --profile-directory="Profile 1"')
	hl.exec_cmd("uwsm-app -- /usr/bin/Telegram")
	hl.exec_cmd("uwsm-app -- slack")
	hl.exec_cmd("uwsm-app -- obsidian")
end)
