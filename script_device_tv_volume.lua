-----------------------------------------
-- Gestion du volume de la TV
-----------------------------------------

commandArray = {}

tvIp = '192.168.1.36'
tvPort = '1925'
volumeInterupteurUp = 'Augmenter volume TV'
volumeInterupteurDown = 'Diminuer volume TV'

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

if devicechanged[volumeInterupteurUp] or devicechanged[volumeInterupteurDown] then
    local setVolume = ''

    if devicechanged[volumeInterupteurUp] then
        setVolume = 'VolumeUp'
    end

    if devicechanged[volumeInterupteurDown] then
        setVolume = 'VolumeDown'
    end

    Library.setTvKey(tvIp, tvPort, setVolume)
    Library.setTvKey(tvIp, tvPort, setVolume)
end

return commandArray