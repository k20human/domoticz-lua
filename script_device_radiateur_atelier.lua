package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

commandArray = {}

interupteur = 'Radiateur atelier'
module = 'Module radiateur atelier'


if devicechanged[interupteur] and otherdevices[interupteur] == 'On' then
    Library.addToCommand(module, 'Set Level: 51')
    print('Allumage chauffage atelier')
elseif devicechanged[interupteur] and otherdevices[interupteur] == 'Off' then
    Library.addToCommand(module, 'Set Level: 0')
    print('Eteindre chauffage atelier')
end

return commandArray