commandArray = {}
heartLeft = 'Coeur gauche';
heartRight = 'Coeur droit';
ip = '192.168.1.93';

if devicechanged[heartLeft] or devicechanged[heartRight] then
    local side = ''

    if (devicechanged[heartLeft]) then
        side = 'left'
    else
        side = 'right'
    end

    print(devicechanged[heartLeft])

    //local runcommand = 'curl -X GET  http://' .. ip .. ':80?side='  .. side .. '&r=' .. .. '&g=' .. .. '&b=' ..
    //os.execute(runcommand)
end

return commandArray