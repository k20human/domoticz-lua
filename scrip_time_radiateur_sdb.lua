-----------------------------------------
-- Gestion des chauffages sdb
-----------------------------------------

-- Variables

local calendrier = 'Calendrier chauffage sdb'

radiateurs = {
	'Radiateur salle de bain'
}

commandArray = {}

function onOffHeat(command)
	for key, radiateur in pairs(radiateurs) do
		commandArray[radiateur] = command
	end
end

-- Recupere les minutes
time = os.time()
minutes = tonumber(os.date('%M',time))

if (minutes % 5 == 0) then
	-- Mode vacances
	if (otherdevices['Gestion radiateurs'] == 'Vacances') then
		print('Off radiateur sdb vacances')
		onOffHeat('Off')
	-- Calendrier
	elseif (otherdevices['Gestion radiateurs'] == 'On') then
		if (otherdevices[calendrier] == 'On') then
			print('On radiateur sdb calendrier')
			onOffHeat('On')		
		else
			print('Off radiateur sdb calendrier')
			onOffHeat('Off')
		end
	end
end

return commandArray
