package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

commandArray = {}

interupteur = 'Radiateur atelier'
module = 'Module radiateur atelier'

-- On ouvre la porte
if devicechanged[interupteur] and otherdevices[interupteur] == 'On' then
    Library.addToCommand(module, 'Set Level: 0')
    print('Allumage chauffage atelier')
else
    Library.addToCommand(module, 'Set Level: 51')
    print('Eteindre chauffage atelier')
end

return commandArray