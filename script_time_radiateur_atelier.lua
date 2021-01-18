-----------------------------------------
-- Gestion des radiateurs
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

-- Variables
local sonde = 'Température atelier'
local thermostat = 'Thermostat atelier'
local radiateur = 'Radiateur atelier'

commandArray = {}

-- Recupere les minutes
minutes = Library.getCurrentMinutes()

if ((minutes - 1) % 5 == 0) then
    local temperature = tonumber(Library.split(otherdevices[sonde], ";")[0])
    local thermostatValue = tonumber(otherdevices[thermostat])

    if (temperature >= thermostatValue) then
        Library.onOffDevices([radiateur], 'Off', 'mode normal')
    end
end

return commandArray
