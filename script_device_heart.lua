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

    if (devicechanged[heartLeft]) then
        side = 'left'
        idx = heartLeftId
    else
        side = 'right'
        idx = heartRightId
    end
    
    local acolor = " "
    local loadData = 'curl "http://192.168.1.14:8080/json.htm?type=devices&rid=' .. idx .. '"'
    local jsondata = assert(io.popen(loadData))
    local jsondevices = jsondata:read('*all')
    jsondata:close()
    local jsonCPM = Json:decode(jsondevices)
    local acolor = jsonCPM.result[1].Color
    
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

    local runcommand = 'curl -X GET  "http://' .. ip .. ':80?side='  .. side .. '&r=' .. red .. '&g=' .. green .. '&b=' .. blue .. '"'
    print(runcommand)
    os.execute(runcommand)
end

return commandArray