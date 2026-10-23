hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "1.0" })

local terminal = "foot"
local menu     = "wofi --show drun"
local mainMod  = "SUPER"

hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
end)

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("pkill waybar; waybar &"))

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
    general = {
        gaps_in = 2, gaps_out = 2, border_size = 3,
        col = {
            active_border   = "rgba(fb4934ee)",   -- red = untrusted session
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
    },
    input  = { kb_layout = "es", follow_mouse = 1, sensitivity = 0 },
    cursor = { no_hardware_cursors = true },
})

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + M",      hl.dsp.exit())
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen())

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })

hl.window_rule({ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize" })
