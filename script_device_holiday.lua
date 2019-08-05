commandArray = {}

interupteur = 'Vacances'
heating_management = {
    ['chambre Théa'] = '30',
	['rdc'] = '30',
	['chambre 2'] = '0',
	['bureau'] = '30'
}

if devicechanged[interupteur] and otherdevices[interupteur] == 'On' then
    for deviceName, deviceValue in pairs(heating_management) do
        print ("Gestion " .. deviceName .. ", mode vacance");
        commandArray['Gestion chauffage ' .. deviceName] = 'Set Level: 20'
    end
elseif devicechanged[interupteur] and otherdevices[interupteur] == 'Off' then
    for deviceName, deviceValue in pairs(heating_management) do
        print ("Gestion " .. deviceName .. ", " .. deviceValue);
        commandArray['Gestion chauffage ' .. deviceName] = 'Set Level: ' .. deviceValue
    end
end

return commandArray