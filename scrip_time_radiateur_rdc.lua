-----------------------------------------
-- Gestion des chauffages du rdc
-----------------------------------------

-- Variables

local hysteresis = 0.5 --Valeur seuil pour éviter que le relai ne cesse de commuter dans les 2 sens
local sonde = 'Température salon'
local thermostat = 'Thermostat salon'
local calendrier = 'Calendrier chauffage rdc'
local tempVacs = 10

radiateurs = {
	'Radiateur salon',
	'Radiateur salle à manger'
}

commandArray = {}

function onOffHeat(command)
	for key, radiateur in pairs(radiateurs) do
		commandArray[radiateur] = command
	end
end

function mySplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=0
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

-- Recupere les minutes
time=os.time()
minutes=tonumber(os.date('%M',time))

if (minutes % 5 == 0) then
	local temperature = tonumber(mySplit(otherdevices[sonde], ";")[0])
	local thermostatValue = tonumber(otherdevices[thermostat])
	
	print(thermostatValue)
	print(temperature)

	-- Mode vacances
	if (otherdevices['Vacances'] == 'On') then
		if (temperature <= (tempVacs - hysteresis) ) then
			print('On radiateur rdc vacances')
			onOffHeat('On')
		elseif (temperature >= (tempVacs + hysteresis) ) then
			print('Off radiateur rdc vacances')
			onOffHeat('Off')
		end
	-- Mode forcé
	elseif (otherdevices['Mode forcé radiateurs'] == 'On') then
		if (temperature <= (thermostatValue - hysteresis) ) then
			print('On radiateur rdc mode forcé')
			onOffHeat('On')
		elseif (temperature >= (thermostatValue + hysteresis) ) then
			print('Off radiateur rdc mode forcé')
			onOffHeat('Off')
		end
	-- Calendrier
	elseif (otherdevices['Vacances'] == 'Off') and (otherdevices['Mode forcé radiateurs'] == 'Off') then
		if (otherdevices[calendrier] == 'On') then
			if (temperature <= (thermostatValue - hysteresis) ) then
				print('On radiateur rdc calendrier')
				onOffHeat('On')
			elseif (temperature >= (thermostatValue + hysteresis) ) then
				print('Off radiateur rdc calendrier')
				onOffHeat('Off')
			end
		else
			print('Off radiateur rdc calendrier fin')
			onOffHeat('Off')
		end
	end
end

return commandArray
