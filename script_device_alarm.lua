-----------------------------------------
-- Gestion de la sécurité en cas dé détection
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local detection = 'Détection présence'
local detectionAlarm = 'DetectionAlarm'
local alarme = 'Alarme'
local volume = 'Xiaomi Gateway Volume'

commandArray = {}

-- Activation du système d'alarme
for deviceName, deviceValue in pairs(devicechanged) do
	if deviceName == detection and deviceValue == 'On' and uservariables[detectionAlarm] == 0 then
		print('ALRME ALERTE - Activation alarme')

		Library.addToCommand('Variable:' .. detectionAlarm, '1')
		Library.addToCommand(alarme, 'Set Level: 10')
		Library.addToCommand(volume, 'Set Level 100')
		Library.sendEmail('[Domoticz] Intrusion détectée', "Alerte")

		-- Gestion des groupes
		Library.addToCommand('Group:Intrusion', 'On')
		Library.addToCommand('Group:Intrusion', 'Off AFTER 30')
	end
end

return commandArray
