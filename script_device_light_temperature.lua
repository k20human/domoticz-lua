commandArray = {}
DomDevice = 'Température lampes';
IP1 = '192.168.1.32';
IP2 = '192.168.1.33';
PORT = '55443'

if devicechanged[DomDevice] then
    if (devicechanged[DomDevice] == 'Off') then
        DomValue = 0;
        runcommandoff = "sudo echo -ne '{\"id\":1,\"method\":\"set_power\", \"params\":[\"off\", \"smooth\", 500]}\\r\\n' | nc -w1 " .. IP1 .. " " .. PORT .. "";
        os.execute(runcommandoff);

        runcommandoff = "sudo echo -ne '{\"id\":1,\"method\":\"set_power\", \"params\":[\"off\", \"smooth\", 500]}\\r\\n' | nc -w1 " .. IP2 .. " " .. PORT .. "";
        os.execute(runcommandoff);
    else
        DomValue = otherdevices_svalues[DomDevice];
        CalcValue = ((DomValue - 1) * 48) + 1700;
    end

    if CalcValue == nil then CalcValue = 0 end

    runcommand = " sudo echo -ne '{\"id\":1, \"method\":\"set_scene\",\"params\":[\"ct\"," .. CalcValue .. ", 75]}\\r\\n' | nc -w1 " .. IP1 .. " " .. PORT .. "";
    os.execute(runcommand);

    runcommand = " sudo echo -ne '{\"id\":1, \"method\":\"set_scene\",\"params\":[\"ct\"," .. CalcValue .. ", 75]}\\r\\n' | nc -w1 " .. IP2 .. " " .. PORT .. "";
    os.execute(runcommand);

    print(runcommand)
    print("Color Temp= " .. CalcValue);
end
return commandArray