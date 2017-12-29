-----------------------------------------
-- Gestion du volume de la TV
-----------------------------------------

commandArray = {}

tvIp = '192.168.1.36'
tvPort = '1925'
volumeInterupteurUp = 'Augmenter volume TV'
volumeInterupteurDown = 'test'

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

if devicechanged[volumeInterupteurUp] or devicechanged[volumeInterupteurDown] then
    local currentVolume = Library.readTvVolume(tvIp, tvPort)

    if devicechanged[volumeInterupteurUp] then
        setVolume = currentVolume + 1
    else
        setVolume = currentVolume - 1
    end

    if setVolume > 60 then
        setVolume = 60
    end


end

return commandArray