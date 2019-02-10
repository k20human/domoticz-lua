-- Gère automatiquement le radiateur de Théa en fonction de son store

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

commandArray = {}

calendrier = 'Calendrier chauffage chambre Théa'
gestion = 'Gestion chauffage chambre Théa'
store = 'Store Théa'

if devicechanged[store] then
	-- Ouverture du store
	if otherdevices[store] == 'Open' then
		-- Si la gestion du chauffage est active on repasse en 'On'
		if (otherdevices[gestion] ~= 'Off') then
			Library.addToCommand(gestion, 'Set Level: 30')

			local heure = Library.getCurrentHours()
			if heure <= 12 then
				Library.addToCommand(calendrier, 'Off')
			end
		-- Si la gestion du chauffage est inactive on s'assure qu'elle est en 'Off'
		elseif (otherdevices[gestion] == 'Off') then
			Library.addToCommand(gestion, 'Set Level: 0')
		end
	-- Fermeture store
	else
		-- Si la gestion du chauffage est active et qu'on est pas en période de chauffe, mode forcé
		if (otherdevices[gestion] ~= 'Off' and otherdevices[calendrier] == 'Off') then
			Library.addToCommand(gestion, 'Set Level: 10')
		-- Si la gestion du chauffage est active et qu'on est en période de chauffe, 'On'
		elseif (otherdevices[gestion] ~= 'Off' and otherdevices[calendrier] == 'On') then
			Library.addToCommand(gestion, 'Set Level: 30')
		-- Si la gestion du chauffage est inactive on s'assure qu'elle est en 'Off'
		elseif (otherdevices[gestion] == 'Off') then
			Library.addToCommand(gestion, 'Set Level: 0')
		end
	end
end

return commandArray
