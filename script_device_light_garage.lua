commandArray = {}

interupteur = 'Porte garage'
detection = 'Présence garage'
lampes = 'Lampes garage'

-- On ouvre la porte
if devicechanged[interupteur] and devicechanged[interupteur] == 'Open' then
    commandArray['Group:' .. lampes] = 'On'
    print('Garage - ouverture de porte allumage lumière')
-- On ferme la porte
elseif devicechanged[interupteur] and devicechanged[interupteur] ~= 'Open' then
    -- Si on ne détecte personne
    if (otherdevices[detection] == 'Off') then
        commandArray['Group:' .. lampes] = 'Off'
        print('Garage - fermeture de porte éteignage lumière')
    else
        print('Garage - fermeture de porte encore une personne')
    end
-- Plus personne dans le garage
elseif devicechanged[detection] and devicechanged[detection] == 'Off' then
    commandArray['Group:' .. lampes] = 'Off'
    print('Garage - plus personne')
-- Quelqu'un arrive dans le garage
elseif devicechanged[detection] and devicechanged[detection] == 'On' then
    commandArray['Group:' .. lampes] = 'On'
    print('Garage - une personne est là')
end

return commandArray