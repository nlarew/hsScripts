--[[
    Motivation: "Alert" style notifications (set in System Preferences) do not auto-dismiss.
]]

local resolveOptions = function(options)
  if options == nil then
    options = {}
  end
  local defaults = {
    duration=1.5
  }

  if options.duration == nil then options.duration = defaults.duration end

  return options
end

TimeoutNotification = function(note, options)
    local note = hs.notify.new(note)
    options = resolveOptions(options)

    note:send()
    hs.timer.doAfter(options.duration, function()
        note:withdraw()
        note = nil
    end)
end
