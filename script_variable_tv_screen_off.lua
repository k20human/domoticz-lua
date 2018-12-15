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
    Library.sleep(0.5)

    for i = 0, 7, 1
    do
        Library.setTvKey(tvIp, tvPort, 'CursorDown')
        Library.sleep(0.5)
    end

    Library.setTvKey(tvIp, tvPort, 'Confirm')
    Library.sleep(0.8)

    Library.setTvKey(tvIp, tvPort, 'CursorDown')
    Library.sleep(0.5)
    Library.setTvKey(tvIp, tvPort, 'CursorDown')
    Library.sleep(0.5)
    Library.setTvKey(tvIp, tvPort, 'CursorDown')
    Library.sleep(0.5)

    Library.setTvKey(tvIp, tvPort, 'Confirm')
    Library.sleep(0.8)
    Library.setTvKey(tvIp, tvPort, 'CursorDown')
    Library.sleep(0.5)

    Library.setTvKey(tvIp, tvPort, 'CursorDown')
    Library.sleep(0.5)

    Library.setTvKey(tvIp, tvPort, 'Confirm')
end

return commandArray