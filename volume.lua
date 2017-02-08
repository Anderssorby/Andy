local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local watch = require("awful.widget.watch")

function update_volume()
	awful.spawn.easy_async([[bash -c 'amixer -D pulse sget Master']], 
		function(stdout, stderr, reason, exit_code)   
			local volume = string.match(stdout, "(%d?%d?%d)%%")

            volume = tonumber(string.format("% 3d", volume))

			local volume_icon_name

			if (volume >= 0 and volume < 20) then volume_icon_name="audio-volume-none-panel"
			elseif (volume >= 20 and volume < 40) then volume_icon_name="audio-volume-zero-panel"
			elseif (volume >= 40 and volume < 60) then volume_icon_name="audio-volume-low-panel"
			elseif (volume >= 60 and volume < 80) then volume_icon_name="audio-volume-medium-panel"
			elseif (volume >= 80 and volume <= 100) then volume_icon_name="audio-volume-high-panel"
			end
		volumeIcon:set_image("/usr/share/icons/Arc/panel/22/" .. volume_icon_name .. ".svg")
	end)
end


function show_volume_status()
    awful.spawn.easy_async([[bash -c 'amixer sget Master']],
        function(stdout, stderr, reason, exit_code)  
            local volume = string.match(stdout, "(%d?%d?%d%%)")
            if not naughty.is_suspended() then
                naughty.notify{
                    title = "Volume " .. volume,
                    timeout = 3, hover_timeout = 0.2,
                    width = 200,
                }
            end
        end
    )
end


volumeIcon = wibox.widget { widget = wibox.widget.imagebox }

mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () update_volume() end)
mytimer:start()

volumeIcon:connect_signal("mouse::enter", function() show_volume_status() end)
