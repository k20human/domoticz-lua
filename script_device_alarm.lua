-----------------------------------------
-- Gestion de la sécurité en cas dé détection
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local detection = 'Detection'
local detectionAlarm = 'DetectionAlarm'
local flash = 'Xiaomi Gateway lampe'

commandArray = {}

-- Activation du système d'alarme
for deviceName, deviceValue in pairs(devicechanged) do
	if deviceName == detection and deviceValue == 'On' and uservariables[detectionAlarm] == 0 then
		commandArray['Variable:' .. detectionAlarm] = "1"
		commandArray['Scene:Intrusion'] = "On"
		print('ALRME ALERTE - Activation alarme')
	end
end

return commandArray
