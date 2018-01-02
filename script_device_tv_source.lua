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
  --  Library.setTvKey(tvIp, tvPort, 'Source')

    if (otherdevices[selector] == sourceShield) then
        Library.setTvKey(tvIp, tvPort, 'CursorDown')
        Library.setTvKey(tvIp, tvPort, 'CursorDown')
        Library.setTvKey(tvIp, tvPort, 'CursorDown')
        Library.setTvKey(tvIp, tvPort, 'CursorDown')
        Library.setTvKey(tvIp, tvPort, 'CursorDown')
        Library.setTvKey(tvIp, tvPort, 'CursorDown')
    elseif (otherdevices[selector] == sourceTv) then
    --    Library.setTvKey(tvIp, tvPort, 'CursorUp')
    --    Library.sleep(0.1)
    --    Library.setTvKey(tvIp, tvPort, 'CursorUp')
    --    Library.sleep(0.1)
    --    Library.setTvKey(tvIp, tvPort, 'CursorUp')
    --    Library.sleep(0.1)
    --    Library.setTvKey(tvIp, tvPort, 'CursorUp')
    --    Library.sleep(0.1)
    --    Library.setTvKey(tvIp, tvPort, 'CursorUp')
    --    Library.sleep(0.1)
    --    Library.setTvKey(tvIp, tvPort, 'CursorUp')
    --    Library.sleep(0.1)
        local runcommand = 'curl -X POST -H "Content-Type: application/json" -d \'{"key":"Source"}\' http://' .. tvIp .. ':' .. tvPort .. '/6/input/key'
        runcommand = runcommand .. ' && curl -X POST -H "Content-Type: application/json" -d \'{"key":"CursorUp"}\' http://' .. tvIp .. ':' .. tvPort .. '/6/input/key'
        os.execute(runcommand)
    end

  --  Library.setTvKey(tvIp, tvPort, 'Confirm')
end

return commandArray