-----------------------------------------
-- Gestion de la sécurité en cas dé détection
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local detection = 'Detection'
local detectionAlarm = 'DetectionAlarm'

local groups = {
	'Warning alarme',
	'Désactivation alarme',
	'Activation alarme',
	'Intrusion'
}

commandArray = {}

-- Activation du système d'alarme
for deviceName, deviceValue in pairs(devicechanged) do
	if deviceName == detection and deviceValue == 'On' and uservariables[detectionAlarm] == 0 then
		print('ALRME ALERTE - Activation alarme')

		commandArray['Variable:' .. detectionAlarm] = "1"
		Library.sendEmail('[Domoticz] Intrusion détectée', "Alerte")

		-- Gestion des groupes
		Library.disableGroups(groups)
		commandArray['Group:Intrusion'] = "On"
		commandArray['Group:Intrusion'] = "Off AFTER 30"
	end
end

return commandArray
