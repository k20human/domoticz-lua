commandArray = {}

function tableContains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

check = {
	'Radiateur chambre bébé',
	'Radiateur salle de bain',
	'Radiateur salle à manger',
	'Radiateur salon'
}

for deviceName, deviceValue in pairs(devicechanged) do
	if tableContains(check, deviceName) then
		print ("Device based event fired on '"..deviceName.."', value '"..tostring(deviceValue).."'");
		
		if deviceValue == 'On' then
			commandArray[deviceName .. ' (matériel)'] = 'Off'
		elseif deviceValue == 'Off' then
			commandArray[deviceName .. ' (matériel)'] = 'On'
		end
	end
end

return commandArray
