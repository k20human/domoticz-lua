commandArray = {}

interupteur = 'Vacances'
heating_management = {
    ['chambre Théa'] = 'On',
	['rdc'] = 'On',
	['chambre parents'] = 'On',
	['bureau'] = 'Off'
}

if devicechanged[interupteur] and otherdevices[interupteur] == 'On' then
    for deviceName, deviceValue in pairs(heating_management) do
        print ("Gestion " .. deviceName .. ", mode vacance");
        commandArray['Gestion chauffage ' .. deviceName] = 'Vacances'
    end
elseif devicechanged[interupteur] and otherdevices[interupteur] == 'Off' then
    for deviceName, deviceValue in pairs(heating_management) do
        print ("Gestion " .. deviceName .. ", " .. deviceValue);
        commandArray['Gestion chauffage ' .. deviceName] = deviceValue
    end
end

return commandArray