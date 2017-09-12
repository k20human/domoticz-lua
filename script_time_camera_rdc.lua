-----------------------------------------
-- Gestion de la caméra rdc
-----------------------------------------

-- Variables

local calendrier = 'Calendrier caméra rdc'

cameras = {
	'Caméra rdc'
}

commandArray = {}

function onOffCamera(command)
	for key, camera in pairs(cameras) do
		commandArray[camera] = command
	end
end

-- Recupere les minutes
time = os.time()
minutes = tonumber(os.date('%M',time))

if (minutes % 5 == 0) then
	-- Sécurité off
	if (otherdevices['Sécurité'] == 'Off') then
		print('Off camera rdc')
		onOffCamera('Off')
	-- Mode absence
	elseif (otherdevices['Sécurité'] == 'Absence') then
		print('On camera rdc')
		onOffCamera('On')
	-- Calendrier
	elseif (otherdevices['Sécurité'] == 'On') then
		if (otherdevices[calendrier] == 'On') then
			print('On camera rdc calendrier')
			onOffCamera('On')
		else
			print('Off camera rdc calendrier')
			onOffCamera('Off')
		end
	end
end

return commandArray
