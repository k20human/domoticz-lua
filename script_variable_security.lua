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
	print('ALERTE - Activation alarme')
end

-- Désactivation du système d'alarme
if uservariables[detection] == 0 and uservariables[detectionAlready] == 1 then
	commandArray['Variable:' .. detectionAlready] = "0"
	print('FIN ALERTE - Désactivation alarme')
end

return commandArray
