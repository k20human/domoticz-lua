-----------------------------------------
-- Gestion de la lampe de l'entrée
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables
local nut = 'Nut_Kevin'
local lampe = 'Lampe entrée'
local luminosite = 'Luminosité entrée'
local days = {
	1,
	2,
	4,
	5
}

commandArray = {}

if (uservariablechanged[nut] ~= nil) then
	-- Recupère les minutes et l'heure
	local minutes = Library.getCurrentMinutes()
	local heure = Library.getCurrentHours()
	local day = Library.getDayNumberOfWeek()

	if (uservariables[nut] ~= "AWAY") and (heure == 18 or heure == 19) and (Library.tableContains(days, day)) and tonumber(otherdevices[luminosite]) < 400 then
		commandArray[lampe] = 'On'
	end
end

return commandArray
