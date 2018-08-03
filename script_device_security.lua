-----------------------------------------
-- Gestion de la détection de présence
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local security = 'Sécurité'
local detection = 'Détection présence'
local detectionAlarm = 'DetectionAlarm'
local detectionActivate = 'DetectionActivate'
local alarme = 'Alarme'
local volume = 'Xiaomi Gateway Volume'

local presence = {
	'Présence rdc',
	'Présence entrée',
	'Présence garage'
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
			if (deviceValue == 'On' or deviceValue == 'Open') and (uservariables[detectionActivate] == 0) then
				print('ALARME ALERTE - Détection présence ' .. deviceName)

				Library.addToCommand('Variable:' .. detectionActivate, "1")
				Library.addToCommand(detection, "On AFTER 10")

				-- Gestion des groupes
				Library.addToCommand('Group:Warning alarme', 'On')
				Library.addToCommand('Group:Warning alarme', 'Off AFTER 10')
			end
		end
	end

	-- Si on désactive la sécurité on désactive la détection
	if (deviceName == security) and (deviceValue ~= 'Absence') then
		print('ALARME - Désactivation')

		Library.addToCommand(detection, "Off")
		Library.addToCommand(alarme, 'Set Level: 0')
		Library.addToCommand('Variable:' .. detectionAlarm, "0")
		Library.addToCommand('Variable:' .. detectionActivate, "0")

		-- Gestion des groupes
		Library.addToCommand('Group:Désactivation alarme', 'On')
		Library.addToCommand('Group:Désactivation alarme', 'Off AFTER 10')
	end

	-- Lampe absence
	if (deviceName == security) and (deviceValue == 'Absence') then
		print('ALARME - Activation')

		Library.addToCommand(detection, "Off")
		Library.addToCommand(alarme, 'Set Level: 0')
		Library.addToCommand('Variable:' .. detectionAlarm, "0")
		Library.addToCommand('Variable:' .. detectionActivate, "1")
		Library.addToCommand('Variable:' .. detectionActivate, "0 AFTER 120")

		-- Gestion des groupes
		Library.addToCommand('Group:Activation alarme', 'On')
		Library.addToCommand('Group:Activation alarme', 'Off AFTER 10')
	end
end

return commandArray
