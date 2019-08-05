-- Lorsque le relais est en position 1 le chauffage est éteint
-- Lorsque le relais est en position 0 le chauffage est en mode confort
-- Ce script permet d'allumer ou éteindre le chauffage tout en affichant le vrai status du radiateur

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

commandArray = {}

check = {
	'Radiateur chambre Théa',
	'Radiateur salle de bain',
	'Radiateur salle à manger',
	'Radiateur salon',
	'Radiateur chambre 2',
	'Radiateur bureau'
}

for deviceName, deviceValue in pairs(devicechanged) do
	if Library.tableContains(check, deviceName) then
		print ("Device based event fired on '" .. deviceName .. "', value '" .. tostring(deviceValue) .. "'");
		
		if deviceValue == 'On' then
			commandArray[deviceName .. ' (matériel)'] = 'Off'
		elseif deviceValue == 'Off' then
			commandArray[deviceName .. ' (matériel)'] = 'On'
		end
	end
end

return commandArray
