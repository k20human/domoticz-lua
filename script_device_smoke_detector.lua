package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')
local Json = (loadfile (Library.scriptPath() .. "/JSON.lua"))()

commandArray = {}
smokeDetector = 'Détecteur fumée étage'

if devicechanged[smokeDetector] and otherdevices[smokeDetector] == 'On' then
    local emailTitle = '[Domoticz] Fumée détectée'
    local mail = 'De la fumée est détectée à l'étage'

    Library.sendEmail(emailTitle, mail)
end

return commandArray