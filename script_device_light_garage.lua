commandArray = {}

interupteur = 'Porte garage'
detection = 'Présence garage'
lampes = 'Lampes garage'

-- On ouvre la porte
if devicechanged[interupteur] and devicechanged[interupteur] == 'Open' then
    commandArray['Group:' .. lampes] = 'On'
-- On ferme la porte
elseif devicechanged[interupteur] and devicechanged[interupteur] ~= 'Open' then
    -- Si on ne détecte personne
    if (otherdevices[detection] == 'Off')
        commandArray['Group:' .. lampes] = 'Off'
    end
-- Plus personne dans le garage
elseif devicechanged[detection] and devicechanged[detection] == 'Off' then
    commandArray['Group:' .. lampes] = 'Off'
-- Quelqu'un arrive dans le garage
elseif devicechanged[detection] and devicechanged[detection] == 'On' then
    commandArray['Group:' .. lampes] = 'On'
end

return commandArray