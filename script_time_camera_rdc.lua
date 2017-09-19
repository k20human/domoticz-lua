-----------------------------------------
-- Gestion de la caméra rdc
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local calendrier = 'Calendrier caméra rdc'

cameras = {
	'Caméra rdc'
}

commandArray = {}

-- Recupere les minutes
minutes = Library.getCurrentMinutes()

if (minutes % 5 == 0) then
	-- Sécurité off
	if (otherdevices['Sécurité'] == 'Off') then
		Library.onOffDevices(cameras, 'Off', '')
	-- Mode absence
	elseif (otherdevices['Sécurité'] == 'Absence') then
		Library.onOffDevices(cameras, 'On', '')
	-- Calendrier
	elseif (otherdevices['Sécurité'] == 'On') then
		if (otherdevices[calendrier] == 'On') then
			Library.onOffDevices(cameras, 'On', 'calendrier')
		else
			Library.onOffDevices(cameras, 'Off', 'calendrier')
		end
	end
end

return commandArray
