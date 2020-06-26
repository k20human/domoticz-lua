-- Permet toutes les 5 minutes de renvoyer la commande actuelle sensée etre appliquée aux modules en 433 ( sans retour d'etat )

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

commandArray = {}

-- Recupère les minutes
minutes = Library.getCurrentMinutes()

-- Toutes les 5 minutes
if (minutes == 0) or (minutes == 5) then

	-- Renforcement des envois de signal
	local check = {
		'Radiateur chambre Théa',
        'Radiateur salle de bain',
        'Radiateur salle à manger',
        'Radiateur salon',
        'Radiateur chambre Maxime',
        'Radiateur bureau',
		'Interrupteur caisson',
		'Imprimante 3D'
	}

	-- Parcours le Tableau
	for key, valeur in pairs(check) do
		print('CHECK : ' .. valeur .. ' -> ' .. otherdevices[valeur])
		commandArray[valeur] = otherdevices[valeur]
	end
end
