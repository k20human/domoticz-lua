-----------------------------------------
-- Gestion de la caméra rdc
-----------------------------------------

-- Variables

local calendrier = 'Calendrier Caméra rdc'

cameras = {
	'cam_rdc'
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
		onOffCamera('off')
	-- Calendrier
	else
		if (otherdevices[calendrier] == 'On') then
			print('On camera rdc calendrier')
			onOffCamera('on')
		else
			print('Off camera rdc calendrier')
			onOffCamera('off')
		end
	end
end

return commandArray
