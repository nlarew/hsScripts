hs.hotkey.bind(hyper, "P", function()
  hs.spotify.playpause()
end)
hs.hotkey.bind(hyper, "]", function()
  hs.spotify.next()
end)
hs.hotkey.bind(hyper, "[", function()
  hs.spotify.previous()
end)

hs.hotkey.bind(hyper, "\\", function()
  artist = hs.spotify.getCurrentArtist()
  album = hs.spotify.getCurrentAlbum()
  TimeoutNotification({
    title=hs.spotify.getCurrentTrack(),
    subTitle='By: ' .. artist,
    informativeText='Album: ' .. album,
    -- setIdImage=hs.image.imageFromPath('./assets/Spotify.ico'),
    contentImage=hs.image.imageFromPath('./assets/Spotify.ico')
    }, { duration=3 })
end)
