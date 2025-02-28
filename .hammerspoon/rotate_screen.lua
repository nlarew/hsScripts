rotate_screen_logger = hs.logger.new('rotate_screen')
local screens = hs.screen.allScreens()

local rotatable_screens = {"ASUS PB278 (1)", "ASUS PB278 (1)", "ASUS PB278 (2)"}

for _, screen in ipairs(screens) do
    if has_value(rotatable_screens, screen:name()) then
        r = a + b
    else
        error("invalid operation")
    end
    logger:w(screen:name())
end

-- #Spoons
-- ToggleScreenRotation = hs.loadSpoon("ToggleScreenRotation")
-- ToggleScreenRotation.screens_to_skip = { "Built-in Retina Display" }
-- ToggleScreenRotation:bindHotkeys({
--   [".*"] = { hyper, "f1" },
--   ["ASUS PB278 (1)"] = { hyper, "f2" }
-- })

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
