-- Une fois par heure, verifie l'age des mesures des sondes

commandArray = {}

-- Recupere les minutes
time=os.time()
minutes=tonumber(os.date('%M',time))

if (minutes == 0) then

    local temp = {
		'Température chambre bébé'
	}

    -- Delai au dela duquel on alerte en secondes
    local alerte = 3600

    local emailTitle = '[Domoticz] Alerte sur sonde temperature#'
	local mail = ''
    local trigger = 0

   -- Parcours le Tableau de stemperatures
   for key, sonde in pairs(temp) do

		s = otherdevices_lastupdate[sonde]
		
		-- returns a date time like 2013-07-11 17:23:12
		t1 = os.time()
		year = string.sub(s, 1, 4)
		month = string.sub(s, 6, 7)
		day = string.sub(s, 9, 10)
		hour = string.sub(s, 12, 13)
		minutes = string.sub(s, 15, 16)
		seconds = string.sub(s, 18, 19)

		t2 = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
		difference = (os.difftime (t1, t2))

		print ('CHECK Temperature : '.. sonde .. ' -> ' .. otherdevices[sonde] .. ' age = ' .. difference .. ' secondes')

		if(difference > alerte)then
			mail = mail .. 'Age de ' .. sonde .. ' -> ' .. difference .. " secondes !!<br/>"
			trigger = trigger + 1  
		end

	end
	
	if trigger > 0 then
		commandArray['SendEmail'] = emailTitle .. "Alerte âge sonde temperature<br/><br/>Attention aux sondes suivantes :<br/><br/>" .. mail .. '#k20human@gmail.com'
	end
end
