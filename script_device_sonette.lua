-----------------------------------------
-- Gestion de la sonnette
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables
local sonnette = 'Sonnette'
local sonnetteSound = 'Sonnette son'
local volume = 'Xiaomi Gateway Volume'

commandArray = {}

if (devicechanged[sonnette]) then
	Library.addToCommand(volume, 'Set Level 15')
    Library.addToCommand(sonnetteSound, "Set Level: 10")
	Library.addToCommand(sonnetteSound, "Set Level: 10 AFTER 2")
end

return commandArray
