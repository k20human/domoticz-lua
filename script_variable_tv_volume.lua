-----------------------------------------
-- Gestion du volume de la TV via variable
-----------------------------------------

commandArray = {}

tvIp = '192.168.1.36'
tvPort = '1925'
volumeVariable = 'TvVolume'

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

if uservariablechanged[volumeVariable] ~= nil then
    local tvVolume = uservariables[volumeVariable]
    local setVolume = ''

    if tvVolume > 0 then
        setVolume = 'VolumeUp'
    end

    if tvVolume < 0 then
        setVolume = 'VolumeDown'
    end

    if (setVolume ~= '') then
        Library.setTvKey(tvIp, tvPort, setVolume)
        os.execute("sleep 1")

        for i = 1, math.abs(tvVolume), 1
        do
            Library.setTvKey(tvIp, tvPort, setVolume)
            Library.sleep(0.1)
        end
    end
end

return commandArray