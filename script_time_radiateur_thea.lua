-- Eteint automatiquement le radiateur de Théa en fonction de certain critères

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

commandArray = {}

minutes = Library.getCurrentMinutes()
heures = Library.getCurrentHours()

gestion = 'Gestion chauffage chambre Théa'

-- Tous les soirs à 20h
if (minutes == 0) or (heures == 20) then
	-- Passer le chauffage en mode 'On', si :
	-- Il n'est pas en mode Off ou Mode Vacances
	if (otherdevices[gestion] ~= 'Vacances' and otherdevices[gestion] ~= 'Off') then
		Library.addToCommand(gestion, 'Set Level: 30')
	end
end

return commandArray
