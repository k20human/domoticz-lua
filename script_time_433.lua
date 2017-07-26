-- Permet toutes les 30 minutes de renvoyer la commande actuelle sensée etre appliquée aux modules en 433 ( sans retour d'etat )

commandArray = {}

-- Recupere les minutes
time=os.time()
minutes=tonumber(os.date('%M',time))
hours=tonumber(os.date('%H',time))

-- Toutes les 30 minutes
------------------------------------------------------------------------
if (minutes == 0) or (minutes == 30) then

	print('# Lancement du check à '..hours..'h'..minutes)

	-- Renforcement des envois de signal
	------------------------------------------------------------------------------
	print('Check de tous les materiels rfxcom (sans retour d\'etat)');

	local check = {
		'Radiateur chambre bébé',
		'Prise TV'
	}

	-- Parcours le Tableau
	for key, valeur in pairs(check) do
		print ('CHECK : ' .. valeur .. ' -> ' .. otherdevices[valeur])
		commandArray[valeur] = otherdevices[valeur]
	end
end
