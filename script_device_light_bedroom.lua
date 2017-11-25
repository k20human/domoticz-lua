commandArray = {}

interupteur = 'Interrupteur lampes chambre parents'
lampes = 'Lampes chambre parents'
lampe1 = 'Lampe chambre parents 1'

if devicechanged[interupteur] and otherdevices[lampe1] == 'Off' then
    commandArray['Group:' .. lampes] = 'On'
elseif devicechanged[interupteur] and otherdevices[lampe1] ~= 'Off' then
    commandArray['Group:' .. lampes] = 'Off'
end

return commandArray