-- Permet toutes les 30 minutes de renvoyer la commande actuelle sensée etre appliquée aux modules en 433 ( sans retour d'etat )

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

commandArray = {}

-- Recupère les minutes
minutes = Library.getCurrentMinutes()

-- Toutes les 30 minutes
if (minutes == 0) or (minutes == 30) then

	-- Renforcement des envois de signal
	local check = {
		'Radiateur chambre bébé',
		'Radiateur salon',
		'Radiateur salle à manger',
		'Radiateur salle de bain'
	}

	-- Parcours le Tableau
	for key, valeur in pairs(check) do
		print('CHECK : ' .. valeur .. ' -> ' .. otherdevices[valeur])
		commandArray[valeur] = otherdevices[valeur]
	end
end
