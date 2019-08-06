local snapLocations = {
  {
    ["description"] = "Left Half (Curr)",
    ["type"] = "snapLocation",
    ["hotkeys"] = {"J", "left"},
    ["xPosition"] = function(max) return max.x end,
    ["yPosition"] = function(max) return max.y end, ["width"] = function(max) return max.w / 2 end,
    ["height"] = function(max) return max.h end
  }, {
    ["description"] = "Right Half (Curr)",
    ["type"] = "snapLocation",
    ["hotkeys"] = {"L", "right"},
    ["xPosition"] = function(max) return max.x + (max.w / 2) end,
    ["yPosition"] = function(max) return max.y end,
    ["width"] = function(max) return max.w / 2 end,
    ["height"] = function(max) return max.h end
  
  
  
  }, {
    ["description"] = "Top Half (Curr)",
    ["type"] = "snapLocation",
    ["hotkeys"] = {"U"},
    ["xPosition"] = function(max) return max.x end,
    ["yPosition"] = function(max) return max.y end,
    ["width"] = function(max) return max.w end,
    ["height"] = function(max) return max.h / 2 end
  }, {
    ["description"] = "Bottom Half (Curr)",
    ["type"] = "snapLocation",
    ["hotkeys"] = {"H"},
    ["xPosition"] = function(max) return max.x end,
    ["yPosition"] = function(max) return max.y + (max.h / 2) end,
    ["width"] = function(max) return max.w end,
    ["height"] = function(max) return max.h / 2 end
  }, {



    ["description"] = "Full Screen (Curr)",
    ["type"] = "snapLocation",
    ["hotkeys"] = {"I", "up"},
    ["xPosition"] = function(max) return max.x end,
    ["yPosition"] = function(max) return max.y end,
    ["width"] = function(max) return max.w end,
    ["height"] = function(max) return max.h end
  }, {
    ["description"] = "Send to Next Monitor",
    ["type"] = "nextMonitor",
    ["hotkeys"] = {"K", "down"},
    ["sendToScreen"] = function(s) return s end,
    ["xPosition"] = function(max) return max.x end,
    ["yPosition"] = function(max) return max.y end,
    ["width"] = function(max) return max.w / 2 end,
    ["height"] = function(max) return max.h end
  }, {
    ["type"] = "closeAllAlerts",
    ["hotkeys"] = {"`"}
  }
}

MODE = "RIGHT_BOTTOM" --"LEFT_TOP"
local switch_mode = function(MODE)
  if MODE == "RIGHT_BOTTOM" then
    return "LEFT_TOP"
  else
    return "RIGHT_BOTTOM"
  end
end

local handleSnapLocations = function(snapLocation)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = snapLocation.xPosition(max)
  f.y = snapLocation.yPosition(max)
  f.w = snapLocation.width(max)
  f.h = snapLocation.height(max)
  win:setFrame(f, 0.05)
end

local switchToNextMonitor = function()
  local win = hs.window.focusedWindow()
    local f = win:frame()
    local currentScreen = win:screen():fullFrame()
    local nextScreen = win:screen():next():fullFrame()
  local currentFrame = {
    ["x"] = f.x,
    ["y"] = f.y,
    ["w"] = f.w,
    ["h"] = f.h
  }
  local nextFrame = {
    ["x"] = nextScreen.x + (currentFrame.x-currentScreen.x)*nextScreen.w/currentScreen.w,
    ["y"] = nextScreen.y, -- TODO: This is weird because f is not a full frame so the frame.y is getting bumped by the menubar. Unfortunately it gets bumped different amounts depending on the screen!
    ["w"] = nextScreen.w * (currentFrame.w / currentScreen.w),
    ["h"] = nextScreen.h - menubarHeight
  }
  win:move(hs.geometry(
    nextFrame.x,
    nextFrame.y,
    nextFrame.w,
    nextFrame.h
  ), win:screen():next(), 0)
end

local handleKeyPress = function(tap_event)
  local pressedKey = tap_event:getKeyCode()
  local hotkeyData = availableHotkeys[pressedKey]
  if (hotkeyData ~= nil) then
    local hotkeyType = hotkeyData.type
    if(hotkeyType == "nextMonitor") then
      switchToNextMonitor()
    end
    if(hotkeyType == "snapLocation") then
      handleSnapLocations(hotkeyData)
    end
    if(hotkeyType == "closeAllAlerts") then
      hs.alert.closeAll()
    end
  end
  Manager:exit()
  return true
end

local availableHotkeys = {}
for i, snapLocation in ipairs(snapLocations) do
  for _, hotkey in ipairs(snapLocation.hotkeys) do
    availableHotkeys[hs.keycodes.map[hotkey]] = snapLocation
  end
end

--[[Snap left half, right half, or full screen]]
hs.hotkey.bind(hyper, "J", function()
  local hotkeyData = availableHotkeys[hs.keycodes.map["J"]]
  handleSnapLocations(hotkeyData)
end)
hs.hotkey.bind(hyper, "left", function()
  local hotkeyData = availableHotkeys[hs.keycodes.map["left"]]
  handleSnapLocations(hotkeyData)
end)

hs.hotkey.bind(hyper, "L", function()
  local hotkeyData = availableHotkeys[hs.keycodes.map["L"]]
  handleSnapLocations(hotkeyData)
end)
hs.hotkey.bind(hyper, "right", function()
  local hotkeyData = availableHotkeys[hs.keycodes.map["right"]]
  handleSnapLocations(hotkeyData)
end)

hs.hotkey.bind(hyper, "U", function()
  local hotkeyData = availableHotkeys[hs.keycodes.map["U"]]
  handleSnapLocations(hotkeyData)
end)
hs.hotkey.bind(hyper, "H", function()
  local hotkeyData = availableHotkeys[hs.keycodes.map["H"]]
  handleSnapLocations(hotkeyData)
end)

hs.hotkey.bind(hyper, "I", function()
  local hotkeyData = availableHotkeys[hs.keycodes.map["I"]]
  handleSnapLocations(hotkeyData)
end)
hs.hotkey.bind(hyper, "up", function()
  local hotkeyData = availableHotkeys[hs.keycodes.map["up"]]
  handleSnapLocations(hotkeyData)
end)

hs.hotkey.bind(hyper, "K", function()
  switchToNextMonitor()
end)
hs.hotkey.bind(hyper, "down", function()
  switchToNextMonitor()
end)

--[[Window Width Control (10% of window increments)]]
hs.hotkey.bind(hyper, "space", function()
  MODE = switch_mode(MODE)
  hs.alert(MODE)
end)
-- hs.hotkey.bind(hyper, "U", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:fullFrame()

--   if MODE == "LEFT_TOP" then
--     f.x = f.x - 256
--     f.y = f.y
--     f.w = f.w + 256
--     f.h = f.h
--   end
--   if MODE == "RIGHT_BOTTOM" then
--     f.x = f.x
--     f.y = f.y
--     f.w = f.w - 256
--     f.h = f.h
--   end
--   win:setFrame(f, 0.05)
-- end)
hs.hotkey.bind(hyper, "O", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()
  
  if MODE == "LEFT_TOP" then
    f.x = f.x + 256
    f.y = f.y
    f.w = f.w - 256
    f.h = f.h
  end
  if MODE == "RIGHT_BOTTOM" then
    f.x = f.x
    f.y = f.y
    f.w = f.w + 256
    f.h = f.h
  end

  win:setFrame(f, 0.05)
end)

-- hs.hotkey.bind(hyper, "Y", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:fullFrame()

--   if MODE == "LEFT_TOP" then
--     f.x = f.x
--     f.y = f.y - 144
--     f.w = f.w
--     f.h = f.h + 144
--   end
--   if MODE == "RIGHT_BOTTOM" then
--     f.x = f.x
--     f.y = f.y
--     f.w = f.w
--     f.h = f.h - 144
--   end
--   win:setFrame(f, 0.05)
-- end)
-- hs.hotkey.bind(hyper, "H", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:fullFrame()
  
--   if MODE == "LEFT_TOP" then
--     f.x = f.x
--     f.y = f.y + 144
--     f.w = f.w
--     f.h = f.h - 144
--   end
--   if MODE == "RIGHT_BOTTOM" then
--     f.x = f.x
--     f.y = f.y
--     f.w = f.w
--     f.h = f.h + 144
--   end

--   win:setFrame(f, 0.05)
-- end)
