hs.hotkey.bind({"cmd", "alt"}, "R", "Reload Configuration", function()
    -- menubar:setTitle("🌀")
    hs.reload()
end)
hs.notify.new({
    title = "Hammerspoon",
    informativeText = "Config loaded"
}):send()
