package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

commandArray = {}

interrupteur = 'Interrupteur atelier'
light = 'Lampe atelier'

if devicechanged[interrupteur] then
    print(otherdevices[light])
end

if devicechanged[interrupteur] and otherdevices[interrupteur] == 'Click' and otherdevices[light] == 'Off' then
    commandArray['Group:' .. light] = 'On'
    print('Allumage lampe atelier')
elseif devicechanged[interrupteur] and otherdevices[interrupteur] == 'Click' and otherdevices[light] == 'On' then
    commandArray['Group:' .. light] = 'Off'
    print('Eteindre lampe atelier')
end

return commandArray