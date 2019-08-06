-- Wifi menubar item
local wifiMenu = hs.menubar.new()
function ssidChangedCallback()
    SSID = hs.wifi.currentNetwork()
    if SSID == nil then
        SSID = "Not Connected 😞"
    end
    wifiMenu:setTitle("(" .. SSID .. ")" )
end
wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()
ssidChangedCallback()
