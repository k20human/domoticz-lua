commandArray = {}

beaconHome = 0
security = 'Sécurité'

print('Modification d\'un Nut')

for variableName, variableValue in pairs(uservariables) do
    if string.sub(variableName, 1, 3) == "Nut" and variableValue ~= "AWAY" then
      beaconHome = beaconHome + 1
    end
end

print(beaconHome .. ' Nut à la maison')

if otherdevices[security] == 'Absence' and beaconHome >= 1 then -- switch Off Alarm because 1 beacon come back Home
    commandArray[security] = 'On'
    print('Auto désactivation alarme')
elseif otherdevices[security] ~= 'Absence' and beaconHome == 0 then -- switch On Alarm because all beacon are away
    commandArray[security] = 'Absence'
    print('Auto activation alarme')
end

return commandArray

