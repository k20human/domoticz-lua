commandArray = {}

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

variable = 'Bonne_Nuit'
appareils = {
    'Lampe salon',
    'Lampe cuisine',
    'Lampe TV',
    'Interrupteur caisson'
}

if (uservariablechanged[variable] ~= nil) then
    Library.onOffDevices(appareils, 'Off', '')
end

return commandArray