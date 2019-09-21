commandArray = {}

interupteur = 'Porte garage'
detection = 'Présence garage'
detection2 = 'Présence garage 2'
lampes = 'Lampes garage'
force = 'Forcer lumière garage'

print('Garage - changed 1 ' .. devicechanged[detection])
print('Garage - changed 2 ' .. devicechanged[detection2])
print('Garage - dev 1 ' .. otherdevices[detection])
print('Garage - dev 2 ' .. otherdevices[detection2])

-- On ouvre la porte
if devicechanged[interupteur] and devicechanged[interupteur] == 'Open' then
    commandArray['Group:' .. lampes] = 'On'
    print('Garage - ouverture de porte allumage lumière')
-- On ferme la porte
elseif devicechanged[interupteur] and devicechanged[interupteur] ~= 'Open' and otherdevices[force] == 'Off' then
    -- Si on ne détecte personne
    if (otherdevices[detection] == 'Off' and otherdevices[detection2] == 'Off') then
        commandArray['Group:' .. lampes] = 'Off'
        print('Garage - fermeture de porte éteignage lumière')
    else
        print('Garage - fermeture de porte encore une personne')
    end
-- Plus personne dans le garage
elseif (devicechanged[detection] or devicechanged[detection2]) and otherdevices[detection] == 'Off' and otherdevices[detection2] == 'Off' and otherdevices[force] == 'Off' then
    commandArray['Group:' .. lampes] = 'Off'
    print('Garage - plus personne')
-- Quelqu'un arrive dans le garage
elseif (devicechanged[detection] or devicechanged[detection2]) and (otherdevices[detection] == 'On' or otherdevices[detection2] == 'On') then
    commandArray['Group:' .. lampes] = 'On'
    print('Garage - une personne est là')
end

return commandArray