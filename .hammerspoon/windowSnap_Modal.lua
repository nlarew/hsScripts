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

local availableHotkeys = {}
for i, snapLocation in ipairs(snapLocations) do
  for _, hotkey in ipairs(snapLocation.hotkeys) do
    availableHotkeys[hs.keycodes.map[hotkey]] = snapLocation
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
  win:setFrame(f, 0)
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

local dimScreens = function()
  local gammaWhitepoint = {["red"] = 0.5, ["green"] = 0.55, ["blue"] = 0.55}
  local gammaBlackpoint = {["red"] = 0, ["green"] = 0, ["blue"] = 0}
  local allScreens = hs.screen.allScreens()
  for _, screen in ipairs(allScreens) do
    screen:setGamma(gammaWhitepoint, gammaBlackpoint)
  end
end

Manager = hs.hotkey.modal.new({"cmd"}, hyperKey)

local keyPressListener = hs.eventtap.new({hs.eventtap.event.types.keyDown}, handleKeyPress)
function Manager:entered()
  currentModal:setTitle("💻 WND")
  dimScreens()
  keyPressListener:start()
end
function Manager:exited()
  currentModal:setTitle(defaultTitle)
  hs.screen.restoreGamma()
  keyPressListener:stop()
end