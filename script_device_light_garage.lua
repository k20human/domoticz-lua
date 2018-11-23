commandArray = {}

interupteur = 'Porte garage'
detection = 'Présence garage'
lampes = 'Lampes garage'

-- On ouvre la porte
if devicechanged[interupteur] and devicechanged[interupteur] == 'On' then
    commandArray['Group:' .. lampes] = 'On'
elseif devicechanged[interupteur] and otherdevices[lampe] ~= 'Off' then
    commandArray['Group:' .. lampes] = 'Off'
end

return commandArray