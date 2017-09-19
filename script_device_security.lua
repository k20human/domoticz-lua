-----------------------------------------
-- Gestion de la détection de présence
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local security = 'Sécurité'

local presence = {
	'Présence rdc'
}

local portes = {
	'Porte garage',
	'Porte entrée'
}

commandArray = {}

for deviceName, deviceValue in pairs(devicechanged) do
	-- Si un des appareils passe à On en mode absence on active la détection
	if (otherdevices[security] == 'Absence') then
		if Library.tableContains(presence, deviceName) or Library.tableContains(portes, deviceName) then
			if deviceValue == 'On' then
				print('ALERTE - Détection présence ' .. deviceName)
				commandArray['Variable:Detection'] = "1"
			end
		end
	end

	-- Si on désactive la sécurité on désactive la détection
	if (deviceName == security) and (deviceValue ~= 'Absence') then
		commandArray['Variable:Detection'] = "0"
	end
end

return commandArray
