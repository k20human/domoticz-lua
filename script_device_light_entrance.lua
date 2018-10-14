commandArray = {}

interupteur = 'Interrupteur entrée'
lampe = 'Lampes chambre parents'

if devicechanged[interupteur] and otherdevices[lampe] == 'Off' then
    commandArray[lampe] = 'On'
elseif devicechanged[interupteur] and otherdevices[lampe] ~= 'Off' then
    commandArray[lampe] = 'Off'
end

return commandArray