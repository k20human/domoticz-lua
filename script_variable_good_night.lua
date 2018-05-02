commandArray = {}

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

variable = 'Bonne_Nuit'
lampes = {
    'Lampe salon',
    'Lampe cuisine',
    'Lampe TV'
}

if (uservariablechanged[variable] ~= nil) then
    Library.onOffDevices(lampes, 'Off', '')
end

return commandArray