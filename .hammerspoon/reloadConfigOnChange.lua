dependsOn("TimeoutNotification")

-- Watch for changes to the hammerspoon config and reload on change
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function(files)
  doReload = false
  for _,file in pairs(files) do
      if file:sub(-4) == ".lua" then
          doReload = true
      end
  end
  if doReload then
    -- menubar:setTitle("🌀")
    hs.reload()
  end
end):start()
hs.alert.closeAll()

TimeoutNotification({
    title="Hammerspoon",
    informativeText="Config loaded"
    }, { duration=1.5 })
