-- Lock screen (similar to windows-L)
hs.hotkey.bind({"ctrl", "alt", "cmd"}, 'L', function()
  if hs.appfinder.appFromName("Spotify") then
    hs.spotify.pause()
  end
  if hs.appfinder.appFromName("iTunes") then
    hs.alert("asdf")
  end
  --hs.caffeinate.startScreensaver()
  hs.caffeinate.lockScreen()
end)