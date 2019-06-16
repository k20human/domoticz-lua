package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')
local Json = (loadfile (Library.scriptPath() .. "/JSON.lua"))()

commandArray = {}
heartLeft = 'Coeur gauche'
heartRight = 'Coeur droit'
heartLeftId = 197
heartRightId = 198
ip = '192.168.1.93'

if devicechanged[heartLeft] or devicechanged[heartRight] then
    local side = ''
    local idx = 0
    local deviceName = ''

    if (devicechanged[heartLeft]) then
        side = 'left'
        idx = heartLeftId
        deviceName = heartLeft
    else
        side = 'right'
        idx = heartRightId
        deviceName = heartRight
    end

    if otherdevices[deviceName] == 'Off' then
        local runcommand = 'curl -X GET  "http://' .. ip .. ':80?side='  .. side .. '&stop=1'
        os.execute(runcommand)
    else
        local acolor = " "
        local loadData = 'curl "http://192.168.1.14:8080/json.htm?type=devices&rid=' .. idx .. '"'
        local jsondata = assert(io.popen(loadData))
        local jsondevices = jsondata:read('*all')
        jsondata:close()
        local jsonCPM = Json:decode(jsondevices)
        local acolor = jsonCPM.result[1].Color
        local level = jsonCPM.result[1].Level

        acolorj = acolor:gsub("}",",}")
        for k,v in acolorj:gmatch('"(.-)":(.-),') do
            if (k == 'b') then
                blue = v
            elseif (k == 'r') then
                red = v
            elseif (k == 'g') then
                green = v
            end
        end

        local runcommand = 'curl -X GET  "http://' .. ip .. ':80?side='  .. side .. '&r=' .. red .. '&g=' .. green .. '&b=' .. blue .. '&l=' .. level .. '"'
        os.execute(runcommand)
    end
end

return commandArray