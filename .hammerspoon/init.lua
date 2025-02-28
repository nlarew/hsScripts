-- hyperKey = "F18" --{"cmd", "alt", "ctrl", "shift"} --"F18" --
hyper = {"shift", "ctrl", "alt", "cmd"}
menubarHeight = 22
-- menubar = hs.menubar.new()
-- defaultTitle = "🔨"--"😀"
-- menubar:setTitle(defaultTitle)

-- logger = hs.logger.new('NicksLua')
-- screens = hs.screen.allScreens()
-- for _, screen in ipairs(screens) do
--     logger:w(screen:name())
-- end

-- #Spoons
-- ToggleScreenRotation = hs.loadSpoon("ToggleScreenRotation")
-- ToggleScreenRotation.screens_to_skip = { "Built-in Retina Display" }
-- ToggleScreenRotation:bindHotkeys({
--   [".*"] = { hyper, "f1" },
--   ["ASUS PB278 (1)"] = { hyper, "f2" }
-- })

-- #Utility Functions
require "dependsOn"

-- #Features
require "reloadConfigOnChange"
require "reloadConfig"
require "SpotifyControls"
require "WindowSnap"
require "lockScreen"
require "wifi"
require "Monitors"

-- Circumvent paste blocking
hs.hotkey.bind(hyper, "V", function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
