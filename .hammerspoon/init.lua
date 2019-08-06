hyperKey = "F18" --{"cmd", "alt", "ctrl", "shift"} --"F18" --
hyper = {"shift", "ctrl", "alt", "cmd"}
menubarHeight = 22
-- menubar = hs.menubar.new()
-- defaultTitle = "🔨"--"😀"
-- menubar:setTitle(defaultTitle)

--#Utility Functions
require "dependsOn"

--#Features
require "reloadConfigOnChange"
require "reloadConfig"
require "SpotifyControls"
require "WindowSnap"
require "lockScreen"
require "wifi"

-- Circumvent paste blocking
hs.hotkey.bind(hyper, "V", function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

-- Test hotkey please ignore
hs.hotkey.bind({"cmd", "alt"}, "B", function()
  local m = {}
  m.modes = {"a", "b", "c"}

  hs.alert(m.modes[1])
end)
