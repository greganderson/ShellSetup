-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Workspace rules
o.window("^ws1-term$", { workspace = "1" })

-- Codegrinder
o.window("^ws5-term$", { workspace = "2" })

-- Telegram, ~WebBBQ~, Slack
o.window("^org\\.telegram\\.desktop$", { workspace = "3 silent" })
-- o.window("^ws3-term$", { workspace = "3" })
o.window("^(Slack|slack)$", { workspace = "3" })

-- Obsidian and work browser
o.window("^obsidian$", { workspace = "4" })
o.window({ title = "^brave-work - Brave$" }, { workspace = "4" })

-- Personal work
o.window("^ws2-term$", { workspace = "5" })
o.window({ title = "^ws2-chromium - Chromium$" }, { workspace = "5" })
o.window({ title = "^brave-personal - Brave$" }, { workspace = "5" })

-- Startup applications
-- o.launch_on_start wraps each command with uwsm-app.
o.launch_on_start('brave --class=brave-work --profile-directory="Default"')
o.launch_on_start("alacritty --class ws1-term")
o.launch_on_start("alacritty --class ws2-term")
-- o.launch_on_start("alacritty --class ws3-term") -- WebBBQ
o.launch_on_start("alacritty --class ws5-term")

-- Optional Chromium windows
-- o.launch_on_start("chromium --class=ws2-chromium")
-- o.launch_on_start("chromium --class=ws5-chromium")

o.launch_on_start('brave --class=brave-personal --profile-directory="Profile 1"')
o.launch_on_start("/usr/bin/Telegram")
o.launch_on_start("slack")
o.launch_on_start("obsidian")
