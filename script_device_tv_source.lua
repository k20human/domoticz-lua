-----------------------------------------
-- Gestion de la source de la TV
-----------------------------------------

commandArray = {}

tvIp = '192.168.1.36'
tvPort = '1925'
selector = 'Source TV'
sourceTv = 'TV'
sourceShield = 'Shield'

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

if devicechanged[selector] then
    local source = ''

    if (otherdevices[selector] == sourceTv) then
        source = 'tv'
    elseif (otherdevices[selector] == sourceTv) then
        source = 'hdmi'
    end

    Library.setTvSource(tvIp, tvPort, source)
end

return commandArray