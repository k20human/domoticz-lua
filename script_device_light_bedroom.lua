commandArray = {}

interupteur = 'Interrupteur lampes chambre parents'
lampes = 'Lampes chambre parents'

if devicechanged[interupteur] and otherdevices[lampe1] == 'Off' then
    commandArray['Group:' .. lampes] = 'On'
elseif devicechanged[interupteur] and otherdevices[lampe1] ~= 'Off' then
    commandArray['Group:' .. lampes] = 'Off'
end

return commandArray