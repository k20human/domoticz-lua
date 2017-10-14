commandArray = {}

interupteur = 'Lampes chambre parents'
lampe1 = 'Lampe chambre parents 1'
lampe2 = 'Lampe chambre parents 2'


if devicechanged[interupteur] and otherdevices[lampe1] == 'Off' then
    commandArray[lampe1] = 'Set Level 80'
    commandArray[lampe2] = 'Set Level 80'
elseif devicechanged[interupteur] and otherdevices[lampe1] ~= 'Off' then
    commandArray[lampe1] = 'Off'
    commandArray[lampe2] = 'Off'
end

return commandArray