commandArray = {}

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

variable = 'Bonne_Nuit'
appareils = {
    'Lampe salon',
    'Lampe cuisine',
    'Lampe salle à manger',
    'Lampe ambilight',
    'Interrupteur caisson'
}

if (uservariablechanged[variable] ~= nil) then
    Library.onOffDevices(appareils, 'Off', '')
    commandArray['Eteindre TV'] = 'On'
end

return commandArray