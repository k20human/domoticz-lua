commandArray = {}

interupteur = 'Vacances'
heating_management = {
    ['chambre Théa'] = 'On',
	['rdc'] = 'On',
	['chambre parents'] = 'On',
	['bureau'] = 'Off'
}

if devicechanged[interupteur] and otherdevices[interupteur] == 'On' then
    for deviceName, deviceValue in pairs(devicechanged) do
        commandArray['Gestion chauffage ' .. deviceName] = 'Off'
    end
elseif devicechanged[interupteur] and otherdevices[interupteur] == 'Off' then
    for deviceName, deviceValue in pairs(devicechanged) do
        commandArray['Gestion chauffage ' .. deviceName] = deviceValue
    end
end

return commandArray