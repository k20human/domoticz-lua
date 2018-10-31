-----------------------------------------
-- Gestion des chaines de la TV (Google Home)
-----------------------------------------

commandArray = {}

tvIp = '192.168.1.36'
tvPort = '1925'
tvVariable = 'TvChannel'
channels = {
    ['1'] = 'tf1',
    ['2'] = 'france2',
    ['3'] = 'france3',
    ['5'] = 'france5',
    ['6'] = 'm6',
    ['8'] = 'c8',
    ['9'] = 'w9',
    ['10'] = 'tmc',
    ['11'] = 'nt1',
    ['12'] = 'nrj12',
    ['14'] = 'france4',
    ['17'] = 'cstar',
    ['18'] = 'gulli',
    ['20'] = 'hd1',
    ['22'] = '6ter',
    ['23'] = 'numero23',
    ['24'] = 'rmc'
}

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

if (uservariablechanged[tvVariable] ~= nil) then
    local tvChannel = uservariables[tvVariable]:lower():gsub("%s+", "")

    for number, channel in pairs(channels) do
        if (tvChannel == number or channel == tvChannel) then
            -- Convert string to digit
            if (number:len() == 1) then
               Library.setTvDigit(tvIp, tvPort, tonumber(number))
            else
                Library.setTvDigit(tvIp, tvPort, tonumber(string.sub(number, 1, 1)))
                Library.setTvDigit(tvIp, tvPort, tonumber(string.sub(number, 2)))
            end
            break
        end
    end
end 

return commandArray