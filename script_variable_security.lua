-----------------------------------------
-- Gestion de la sécurité en cas dé détection
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local detection = 'Detection'
local detectionAlready = 'DetectionAlready'
local flash = 'Xiaomi Gateway lampe'

commandArray = {}

-- Activation du système d'alarme
if uservariables[detection] == 1 and uservariables[detectionAlready] == 0 then
	commandArray['Variable:' .. detectionAlready] = "1"
	commandArray['Scene:Intrusion'] = "On"
	print('ALERTE - Activation alarme')
end

return commandArray
