-----------------------------------------
-- Gestion du volume de la TV via variable (Google Home)
-----------------------------------------

commandArray = {}

ip = '127.0.0.1'
port = '8080'
printer = 'imprimante_3d'
printerID = 196

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

if uservariablechanged[printer] ~= nil then
    local hours = uservariables[printer]

    local addHours = os.date("%H") + 1 + hours
    local day = os.time{year=os.date("%Y"), month=os.date("%m"), day=os.date("%d"), hour=addHours, min=0, sec=0}

    local runcommand = 'curl -X GET \'http://' .. ip .. ':' .. port .. '/json.htm?type=command&param=addtimer&idx=' .. printerID .. '&active=true&timertype=5&hour=' .. os.date("%H", day) .. '&min=2&date=' .. os.date("%Y-%m-%d", day) .. '&randomness=false&command=1&days=1234567\''
    os.execute(runcommand)
end

return commandArray