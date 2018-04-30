commandArray = {}

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

interupteur = 'Bonne nuit'
lampes = {
    'Lampe salon',
    'Lampe TV'
}

if devicechanged[interupteur] then
    Library.onOffDevices(lampes, 'Off', '')
end

return commandArray