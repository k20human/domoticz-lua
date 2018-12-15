-----------------------------------------
-- Gestion de l'écran la TV via variable (Google Home)
-----------------------------------------

commandArray = {}

tvIp = '192.168.1.36'
tvPort = '1925'
screenVariable = 'TvScreenOff'

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

if uservariablechanged[screenVariable] ~= nil then
    Library.setTvKey(tvIp, tvPort, 'Adjust')
    Library.sleep(0.2)

    for i = 1, 6, 1
    do
        Library.setTvKey(tvIp, tvPort, 'CursorDown')
        Library.sleep(0.2)
    end

    Library.setTvKey(tvIp, tvPort, 'Confirm')
    Library.sleep(0.2)

    Library.setTvKey(tvIp, tvPort, 'CursorDown')
    Library.sleep(0.2)
    Library.setTvKey(tvIp, tvPort, 'CursorDown')
    Library.sleep(0.2)

    Library.setTvKey(tvIp, tvPort, 'Confirm')
    Library.sleep(0.2)

    Library.setTvKey(tvIp, tvPort, 'CursorDown')
    Library.sleep(0.2)

    Library.setTvKey(tvIp, tvPort, 'Confirm')
    Library.sleep(0.2)
end

return commandArray