commandArray = {}

interupteur = 'Interrupteur lampe bureau'
lampes = 'Lampes bureau'
lampe1 = 'Lampe bureau'

if devicechanged[interupteur] and otherdevices[lampe1] == 'Off' then
    commandArray['Group:' .. lampes] = 'On'
elseif devicechanged[interupteur] and otherdevices[lampe1] ~= 'Off' then
    commandArray['Group:' .. lampes] = 'Off'
end

return commandArray