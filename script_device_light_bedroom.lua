commandArray = {}

interupteur = 'Interrupteur lampes chambre parents'
lampe1 = 'Lampe chambre parents 1'
lampe2 = 'Lampe chambre parents 2'

lampe1Idx = '79'
lampe2Idx = '95'


if devicechanged[interupteur] and otherdevices[lampe1] == 'Off' then
    commandArray['OpenURL']='http://192.168.1.14:8080/json.htm?type=command&param=setcolbrightnessvalue&idx=' .. lampe1Idx .. '&hex=FFFFFF&brightness=100&iswhite=false'
    commandArray['OpenURL']='http://192.168.1.14:8080/json.htm?type=command&param=setcolbrightnessvalue&idx=' .. lampe2Idx .. '&hex=FFFFFF&brightness=100&iswhite=false'
elseif devicechanged[interupteur] and otherdevices[lampe1] ~= 'Off' then
    commandArray[lampe1] = 'Off'
    commandArray[lampe2] = 'Off'
end

return commandArray