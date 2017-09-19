-----------------------------------------
-- Gestion de la détection de présence
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local security = 'Sécurité'
local detection = 'Detection'
local detectionAlready = 'DetectionAlready'

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
				commandArray['Scene:Warning alarme'] = "On"
				commandArray['Variable:' .. detection] = "1 AFTER 30"
			end
		end
	end

	-- Si on désactive la sécurité on désactive la détection
	if (deviceName == security) and (deviceValue ~= 'Absence') then
		commandArray['Variable:' .. detection] = "0"
		commandArray['Variable:' .. detectionAlready] = "0"
		commandArray['Scene:Désactivation alarme'] = "On"
	end

	-- Lampe absence
	if (deviceName == security) and (deviceValue == 'Absence') then
		commandArray['Variable:' .. detection] = "0"
		commandArray['Variable:' .. detectionAlready] = "0"
		commandArray['Scene:Activation alarme'] = "On"
	end
end

return commandArray
