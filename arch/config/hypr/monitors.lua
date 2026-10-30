-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = "auto"

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- Fallback for monitors without a specific rule
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

-- Laptop
hl.monitor({
	output = "eDP-2",
	mode = "preferred",
	position = "0x0",
	scale = 1.60,
})

-- LG ultrawide from school
hl.monitor({
	output = "DP-1",
	mode = "preferred",
	position = "-3072x-800",
	scale = 1.666666,
})

-- 1080p TV from school
hl.monitor({
	output = "HDMI-A-1",
	mode = "preferred",
	position = "1600x0",
	scale = 1.60,
})
