-----------------------------------------
-- Gestion des chauffages sdb
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local calendrier = 'Calendrier chauffage sdb'

radiateurs = {
	'Radiateur salle de bain'
}

commandArray = {}

-- Recupere les minutes
minutes = Library.getCurrentMinutes()

if (minutes % 5 == 0) then
	-- Mode vacances
	if (otherdevices['Gestion radiateurs'] == 'Vacances') then
		Library.onOffDevices(radiateurs, 'On', 'vacances')
	-- Calendrier
	elseif (otherdevices['Gestion radiateurs'] == 'On') then
		if (otherdevices[calendrier] == 'On') then
			Library.onOffDevices(radiateurs, 'On', 'calendrier')
		else
			Library.onOffDevices(radiateurs, 'Off', 'calendrier')
		end
	-- Off
	elseif (otherdevices['Gestion radiateurs'] == 'Off') then
	    Library.onOffDevices(radiateurs, 'Off', '')
	end
end

return commandArray
