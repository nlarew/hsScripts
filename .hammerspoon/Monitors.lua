local log = hs.logger.new('Monitors', 'debug')

local swap = function(screenX, screenY)
    -- Given two hs.screen objects, screenX and screenY, swap the
    -- coordinates of the two screens and set the secondary screen as the
    -- primary screen.
    local screenXFrame = screenX:fullFrame()
    local screenYFrame = screenY:fullFrame()
    screenY:setOrigin(screenXFrame.x + screenXFrame.w, screenXFrame.y)
    screenY:setPrimary()
end

hs.hotkey.bind(hyper, "home", function()
    local screens = hs.screen.allScreens()
    local primaryScreen = screens[1]
    local secondaryScreen = screens[2]

    if #(screens) == 2 then
        swap(primaryScreen, secondaryScreen)
    else
        local error_message = "Expected 2 screens, but found " .. #(screens) .. "."
        log.e(error_message)
        hs.alert(error_message)
    end
end)
