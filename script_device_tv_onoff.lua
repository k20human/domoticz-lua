-----------------------------------------
-- Allumer / Eteindre la TV
-----------------------------------------

commandArray = {}

tvIp = '192.168.1.36'
tvPort = '1925'
button = 'Télévision'
buttonWol = 'Allumer TV wol'

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

if (devicechanged[button]) then
    if otherdevices[button] == 'Off' then
        Library.setTvKey(tvIp, tvPort, 'Standby')
    else
        local ping_success = os.execute('fping -c1 -t100 ' .. tvIp)

        if ping_success then
            print("TV - ping ok")
            Library.setTvKey(tvIp, tvPort, 'Standby')
        else
            print("TV - ping fail - wol")
            commandArray[buttonWol] = 'On'
        end
    end
end

return commandArray