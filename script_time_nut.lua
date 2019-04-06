-----------------------------------------
-- Une fois par heure, verifie l'age des mesures des nuts
-----------------------------------------

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

commandArray = {}

-- Recupere les minutes et les heures
minutes = Library.getCurrentMinutes()
heures = Library.getCurrentHours()

if (minutes == 21) and (heures == 12) then

    local nuts = {
        'Nut_Marvel',
        'Nut_Katia',
        'Nut_Kevin'
    }

    -- Delai au dela duquel on alerte en secondes - 24h
    local alerte = 86400

    local emailTitle = '[Domoticz] Alerte sur Nuts'
    local mail = ''
    local nutsOffline = 0

    -- Parcours le Tableau de stemperatures
    if otherdevices['Vacances'] == 'Off' then
        for key, nut in pairs(nuts) do

            if uservariables[nut] == 'AWAY' then
                mail = mail .. 'Nut ' .. nut .. " -> surement plus de pile<br/>"
                nutsOffline = nutsOffline + 1
            end
        end

        if nutsOffline > 0 and nutsOffline ~= #nuts then
            Library.sendEmail(emailTitle, "Penser à changer les piles des nuts suivants :<br/><br/>" .. mail)
        end
    end
end
