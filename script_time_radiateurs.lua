-----------------------------------------
-- Gestion des radiateurs
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables

local hysteresis = 0.5 -- Valeur seuil pour éviter que le relai ne cesse de commuter dans les 2 sens
local tempVacs = tonumber(otherdevices['Thermostat hors gel'])
local tempMin = tonumber(otherdevices['Thermostat minimum'])

local sonde = 'Température '
local thermostat = 'Thermostat '
local calendrier = 'Calendrier chauffage '
local management = 'Gestion chauffage '

zones = {
	['chambre Théa'] = {'Radiateur chambre Théa'},
	['salle de bain'] = {'Radiateur salle de bain'},
	['rdc'] = {
		'Radiateur salon',
		'Radiateur salle à manger'
	},
	['chambre Maxime'] = {'Radiateur chambre Maxime'},
	['bureau'] = {'Radiateur bureau'}
}

commandArray = {}

-- Recupere les minutes
minutes = Library.getCurrentMinutes()

if ((minutes - 1) % 5 == 0) then
	-- On parcourt les zones
	for zone, radiateurs in pairs(zones) do
        print('Chauffage - Zone ' .. zone)

		local temperature = tonumber(Library.split(otherdevices[sonde .. zone], ";")[0])
		local thermostatValue = tonumber(otherdevices[thermostat .. zone])

		-- Mode vacances
		if (otherdevices[management .. zone] == 'Vacances') then
			if (temperature <= (tempVacs - hysteresis) ) then
				Library.onOffDevices(radiateurs, 'On', 'vacances')
			elseif (temperature >= (tempVacs + hysteresis) ) then
				Library.onOffDevices(radiateurs, 'Off', 'vacances')
			end
        -- Gestion spécifique Indépendant
		elseif (otherdevices[management .. zone] == 'Indépendant') then
			if (temperature >= (thermostatValue + hysteresis) ) then
				Library.onOffDevices(radiateurs, 'Off', 'mode forcé indépendant')
			end
		-- Mode forcé
		elseif (otherdevices[management .. zone] == 'Mode forcé') then
			if (temperature <= (thermostatValue - hysteresis) ) then
				Library.onOffDevices(radiateurs, 'On', 'mode forcé')
			elseif (temperature >= (thermostatValue + hysteresis) ) then
				Library.onOffDevices(radiateurs, 'Off', 'mode forcé')
			end
		-- Gestion spécifique serviettes
		elseif (otherdevices[management .. zone] == 'Serviettes') then
			Library.onOffDevices(radiateurs, 'On', 'serviettes')
		-- Gestion normale
		elseif (otherdevices[management .. zone] == 'On') then
			if (otherdevices[calendrier .. zone] == 'On') then
				if (temperature <= (thermostatValue - hysteresis) ) then
					Library.onOffDevices(radiateurs, 'On', 'calendrier')
				elseif (temperature >= (thermostatValue + hysteresis) ) then
					Library.onOffDevices(radiateurs, 'Off', 'calendrier')
				end
			else
				-- Si température trop faible on lance quand même le chauffage
				if (temperature <= (tempMin - hysteresis) ) then
					Library.onOffDevices(radiateurs, 'On', 'minimum')
				elseif (temperature >= (tempMin + hysteresis) ) then
					Library.onOffDevices(radiateurs, 'Off', 'minimum / calendrier fin')
				end
			end
		-- Off
		elseif (otherdevices[management .. zone] == 'Off') then
			Library.onOffDevices(radiateurs, 'Off', '')
		end
	end
end

return commandArray
