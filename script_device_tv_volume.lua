-----------------------------------------
-- Gestion du volume de la TV
-----------------------------------------

tvIp = '192.168.1.36'
tvPort = '1925'
volumeInterupteur = 'test'

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')


if devicechanged[volumeInterupteur] then
    print(Library.readTvVolume(tvIp, tvPort))
    print(otherdevices_svalues[volumeInterupteur])
end