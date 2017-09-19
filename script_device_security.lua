-----------------------------------------
-- Gestion de la détection de présence
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local security = 'Sécurité'
local detection = 'Detection'
local detectionAlarm = 'DetectionAlarm'
local detectionActivate = 'DetectionActivate'

local presence = {
	'Présence rdc'
}

local portes = {
	'Porte garage',
	'Porte entrée'
}

local groups = {
	'Warning alarme',
	'Désactivation alarme',
	'Activation alarme',
	'Intrusion'
}

commandArray = {}

for deviceName, deviceValue in pairs(devicechanged) do
	-- Si un des appareils passe à On en mode absence on active la détection
	if (otherdevices[security] == 'Absence') then
		if Library.tableContains(presence, deviceName) or Library.tableContains(portes, deviceName) then
			if deviceValue == 'On' and uservariables[detectionActivate] == 0 then
				print('ALARME ALERTE - Détection présence ' .. deviceName)

				commandArray['Variable:' .. detectionActivate] = "1"
				commandArray[detection] = "On AFTER 10"

				-- Gestion des groupes
				commandArray['Group:Warning alarme'] = "On"
				commandArray['Group:Warning alarme'] = "Off AFTER 10"
			end
		end
	end

	-- Si on désactive la sécurité on désactive la détection
	if (deviceName == security) and (deviceValue ~= 'Absence') then
		print('ALARME - Désactivation')

		commandArray[detection] = "Off"
		commandArray['Variable:' .. detectionAlarm] = "0"
		commandArray['Variable:' .. detectionActivate] = "0"

		-- Gestion des groupes
		commandArray['Group:Désactivation alarme'] = "On"
		commandArray['Group:Désactivation alarme'] = "Off AFTER 10"
	end

	-- Lampe absence
	if (deviceName == security) and (deviceValue == 'Absence') then
		print('ALARME - Activation')

		commandArray[detection] = "Off"
		commandArray['Variable:' .. detectionAlarm] = "0"
		commandArray['Variable:' .. detectionActivate] = "0"

		-- Gestion des groupes
		commandArray['Group:Activation alarme'] = "On"
		commandArray['Group:Activation alarme'] = "Off AFTER 10"
	end
end

return commandArray
