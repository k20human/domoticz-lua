-----------------------------------------
-- Gestion du volume de la TV
-----------------------------------------

tvIp = '192.168.1.36'
tvPort = '1925'
volumeInterupteur = 'test'

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')
JSON = assert(loadfile '/home/k20/domoticz/scripts/lua/JSON.lua')()

if devicechanged[volumeInterupteur] then
    local volumeRead = assert(io.popen('curl http://' .. tvIp .. ':' .. tvPort .. '/6/audio/volume'))
    local volumeJson = volumeRead:read('*all')
    local volume = JSON:decode(volume)
    print(volumeJson)
    print(volume.current)
end