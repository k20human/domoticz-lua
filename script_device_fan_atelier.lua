package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

commandArray = {}

--[[ interupteur = 'Ventilation atelier'

if devicechanged[presence] and otherdevices[presence] == 'On' then
    commandArray[interupteur] = 'On'
    print('Allumage ventilation atelier')
elseif devicechanged[presence] and otherdevices[presence] == 'Off' then
    commandArray[interupteur] = 'Off'
    print('Eteindre ventilation atelier')
end ]]

return commandArray