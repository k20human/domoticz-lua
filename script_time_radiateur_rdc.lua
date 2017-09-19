-----------------------------------------
-- Gestion des chauffages du rdc
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local hysteresis = 0.5 -- Valeur seuil pour éviter que le relai ne cesse de commuter dans les 2 sens
local sonde = 'Température salon'
local thermostat = 'Thermostat salon'
local calendrier = 'Calendrier chauffage rdc'
local tempVacs = 10

radiateurs = {
	'Radiateur salon',
	'Radiateur salle à manger'
}

commandArray = {}

-- Recupere les minutes
minutes = Library.getCurrentMinutes()

if (minutes % 5 == 0) then
	local temperature = tonumber(Library.split(otherdevices[sonde], ";")[0])
	local thermostatValue = tonumber(otherdevices[thermostat])

	-- Mode vacances
	if (otherdevices['Gestion radiateurs'] == 'Vacances') then
		if (temperature <= (tempVacs - hysteresis) ) then
			Library.onOffDevices(radiateurs, 'On', 'vacances')
		elseif (temperature >= (tempVacs + hysteresis) ) then
			Library.onOffDevices(radiateurs, 'Off', 'vacances')
		end
	-- Mode forcé
	elseif (otherdevices['Gestion radiateurs'] == 'Mode forcé') then
		if (temperature <= (thermostatValue - hysteresis) ) then
			Library.onOffDevices(radiateurs, 'On', 'mode forcé')
		elseif (temperature >= (thermostatValue + hysteresis) ) then
			Library.onOffDevices(radiateurs, 'Off', 'mode forcé')
		end
	-- Calendrier
	elseif (otherdevices['Gestion radiateurs'] == 'On') then
		if (otherdevices[calendrier] == 'On') then
			if (temperature <= (thermostatValue - hysteresis) ) then
				Library.onOffDevices(radiateurs, 'On', 'calendrier')
			elseif (temperature >= (thermostatValue + hysteresis) ) then
				Library.onOffDevices(radiateurs, 'Off', 'calendrier')
			end
		else
			Library.onOffDevices(radiateurs, 'Off', 'calendrier fin')
		end
	-- Off
	elseif (otherdevices['Gestion radiateurs'] == 'Off') then
		Library.onOffDevices(radiateurs, 'Off', '')
	end
end

return commandArray
