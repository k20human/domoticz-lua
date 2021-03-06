local Library = {}

function Library.scriptPath()
   local str = debug.getinfo(2, "S").source:sub(2)

   return str:match("(.*/)") or "."
end

local Json = (loadfile (Library.scriptPath() .. "/JSON.lua"))()

function Library.getUserVar(userVar)
    local var = uservariables[userVar]
    local userVarErr = 0;

    if var == nil then
        print("User variable not set for : " .. userVar)
        userVarErr = userVarErr + 1
    end

    return var
end

function Library.fileExists(file)
    local f = io.open(file, "rb")

    if f then
        f:close()
    end

    return f ~= nil
end

function Library.round(num, idp)
    local mult = 10 ^ (idp or 0)

    return math.floor(num * mult + 0.5) / mult
end

function Library.getValue(text, getNr)
    local part = 1
    local myValue = ''

    for match in (text .. ';'):gmatch("(.-)" .. ';') do
        if part == getNr then
            myValue = tonumber(match)
        end

        part = part + 1
    end
    return myValue
end

-- replace the last character
function Library.enumClear(text)
    local a = string.len(text)
    local b = string.sub(text, a, a)

    if b == "," or b == " " then
        text = string.sub(text, 1, a - 1)
    end

    return text
end

function Library.convertTime(timestamp)
    local y, m, d, H, M, S = timestamp:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")

    return os.time { year = y, month = m, day = d, hour = H, min = M, sec = S }
end

function Library.getDayNumberOfWeek()
    return tonumber(os.date("*t").wday)
end

function Library.getCurrentHours()
    local time = os.time()

    return tonumber(os.date('%H',time))
end

function Library.getCurrentMinutes()
    local time = os.time()

    return tonumber(os.date('%M',time))
end

function Library.timeDiff(time1, time2)
    if string.len(time1) > 12 then
        time1 = Library.ConvTime(time1)
    end

    if string.len(time2) > 12 then
        time2 = Library.ConvTime(time2)
    end

    local resTime = os.difftime(time1, time2)

    return resTime
end

function Library.blinkLight(light, times)
    times = times or 2

    local cmd1 = 'Off'
    local cmd2 = 'On'
    local pause = 0

    if (otherdevices[light] == 'Off') then
        cmd1 = 'On'
        cmd2 = 'Off'
    end

    for i = 1, times do
        commandArray[#commandArray + 1] = { [light] = cmd1 .. ' AFTER ' .. pause }
        pause = pause + 3
        commandArray[#commandArray + 1] = { [light] = cmd2 .. ' AFTER ' .. pause }
        pause = pause + 3
    end
end

function Library.tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end

    return false
end

function Library.addToCommand(device, command)
    commandArray[#commandArray +1] = { [device] = command}
end

function Library.disableGroups(scenes)
    for _, value in pairs(scenes) do
        commandArray['Group:' .. value] = "Off"
    end
end

function Library.onOffDevices(devices, command, message)
	for key, device in pairs(devices) do
		commandArray[device] = command
        print(command .. ' ' .. device .. ' ' .. message)
	end
end

function Library.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end

    local t = {}
    local i = 0

    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end

    return t
end

function Library.sendEmail(title, body)
    local path = Library.scriptPath()

    if Library.fileExists(path .. '/config.json') then
        local file = io.open(path .. '/config.json', "r")
        local contents = Json:decode(file:read( "*a" ))

        commandArray[#commandArray +1] = { ['SendEmail'] = title .. '#' .. body .. '#' .. contents.email }

        io.close(file)
    else
        print('Can\'t send email, missing config file')
    end
end

function Library.sleep(s)
  local ntime = os.clock() + s
  repeat until os.clock() > ntime
end

function Library.readTvVolume(tvIp, tvPort)
    local JSON = assert(loadfile '/home/k20/domoticz/scripts/lua/JSON.lua')()

    local volumeRead = assert(io.popen('curl http://' .. tvIp .. ':' .. tvPort .. '/6/audio/volume'))
    local volumeJson = volumeRead:read('*all')
    volumeRead:close()
    local volume = JSON:decode(volumeJson)

    return volume.current
end

function Library.setTvKey(tvIp, tvPort, key)
    local runcommand = 'curl -X POST -H "Content-Type: application/json" -d \'{"key":"' .. key .. '"}\' http://' .. tvIp .. ':' .. tvPort .. '/6/input/key'
    os.execute(runcommand)
end

function Library.setTvDigit(tvIp, tvPort, number)
    local digit = ''

    if number == 0 then
        digit = 'Digit0'
    elseif number == 1 then
        digit = 'Digit1'
    elseif number == 2 then
        digit = 'Digit2'
    elseif number == 3 then
        digit = 'Digit3'
    elseif number == 4 then
        digit = 'Digit4'
    elseif number == 5 then
        digit = 'Digit5'
    elseif number == 6 then
        digit = 'Digit6'
    elseif number == 7 then
        digit = 'Digit7'
    elseif number == 8 then
        digit = 'Digit8'
    elseif number == 9 then
        digit = 'Digit9'
    end

    local runcommand = 'curl -X POST -H "Content-Type: application/json" -d \'{"key":"' .. digit .. '"}\' http://' .. tvIp .. ':' .. tvPort .. '/6/input/key'
    os.execute(runcommand)
end

return Library