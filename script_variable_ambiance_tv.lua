commandArray = {}

package.path = package.path .. ';' .. '/home/k20/domoticz/scripts/lua/?.lua'
Library = require('Library')

variable = 'Ambiance_TV'
lampe_tv = 'Lampe TV'
lampes = {
    'Lampe salon',
    'Lampe cuisine',
}

if (uservariablechanged[variable] ~= nil) then
    Library.onOffDevices(lampes, 'Off', '')
    Library.addToCommand('Group:' .. lampe_tv, 'On')
end

return commandArray