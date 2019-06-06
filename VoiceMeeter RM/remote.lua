local server = require("server");
local win = require("win");

local hwnd = nil;
local path = "C:\\Users\\mozzi\\Desktop\\Programme\\UnifiedRemote_VoiceMeeter_EXE\\voicemeeter_unified_remote.dat"

function mysplit(inputstr, sep)
        if sep == nil then
                sep = "&";
        end
        local t={};
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str);
        end
        return t;
end

function initVM()
	local success = win.post(hwnd, 30001, 30001, 30001);
	
	local file = io.open(path, "r");
	local line = file:read();
	print(line);
	-- print(type(line)); -- Output: String
	file:close();
	
	local t = mysplit(line,"&");
	--print(table.maxn(t));  -- Returns 60 -> Also Index 1 bis 60
	for i = 1,60,1 do
		print(t[i]);
		szParamName = mysplit(t[i], "=");
		
		if (szParamName[1] == "Strip[0].Gain") then
			layout.strip1.progress = (szParamName[2] * 10 + 500) / 2.5;

		elseif (szParamName[1] == "Strip[0].A1") then
			if (szParamName[2] == "1") then
				layout.strip01B01.checked = true;
			else
				layout.strip01B01.checked = false;
			end

		elseif (szParamName[1] == "Strip[0].A2") then
			if (szParamName[2] == "1") then
				layout.strip01B02.checked = true;
			else
				layout.strip01B02.checked = false;
			end

		elseif (szParamName[1] == "Strip[0].A3") then
			if (szParamName[2] == "1") then
				layout.strip01B03.checked = true;
			else
				layout.strip01B03.checked = false;
			end

		elseif (szParamName[1] == "Strip[0].B1") then
			if (szParamName[2] == "1") then
				layout.strip01B04.checked = true;
			else
				layout.strip01B04.checked = false;
			end

		elseif (szParamName[1] == "Strip[0].B2") then
			if (szParamName[2] == "1") then
				layout.strip01B05.checked = true;
			else
				layout.strip01B05.checked = false;
			end

		elseif (szParamName[1] == "Strip[0].Mono") then
			if (szParamName[2] == "1") then
				layout.strip01B06.checked = true;
			else
				layout.strip01B06.checked = false;
			end

		-- elseif (szParamName[1] == "Strip[0].Solo") then
		--    if (szParamName[2] == "1") then
		--		layout.strip01B07.checked = true;
		--	else
		--		layout.strip01B07.checked = false;
		--	end
		--
		elseif (szParamName[1] == "Strip[0].Mute") then
			if (szParamName[2] == "1") then
				layout.strip01B08.checked = true;
			else
				layout.strip01B08.checked = false;
			end

		elseif (szParamName[1] == "Strip[1].Gain") then
			layout.strip2.progress = (szParamName[2] * 10 + 500) / 2.5;

		elseif (szParamName[1] == "Strip[1].A1") then
			if (szParamName[2] == "1") then
				layout.strip02B01.checked = true;
			else
				layout.strip02B01.checked = false;
			end

		elseif (szParamName[1] == "Strip[1].A2") then
			if (szParamName[2] == "1") then
				layout.strip02B02.checked = true;
			else
				layout.strip02B02.checked = false;
			end

		elseif (szParamName[1] == "Strip[1].A3") then
			if (szParamName[2] == "1") then
				layout.strip02B03.checked = true;
			else
				layout.strip02B03.checked = false;
			end

		elseif (szParamName[1] == "Strip[1].B1") then
			if (szParamName[2] == "1") then
				layout.strip02B04.checked = true;
			else
				layout.strip02B04.checked = false;
			end

		elseif (szParamName[1] == "Strip[1].B2") then
			if (szParamName[2] == "1") then
				layout.strip02B05.checked = true;
			else
				layout.strip02B05.checked = false;
			end

		elseif (szParamName[1] == "Strip[1].Mono") then
			if (szParamName[2] == "1") then
				layout.strip02B06.checked = true;
			else
				layout.strip02B06.checked = false;
			end

		elseif (szParamName[1] == "Strip[1].Solo") then
			if (szParamName[2] == "1") then
				layout.strip02B07.checked = true;
			else
				layout.strip02B07.checked = false;
			end

		elseif (szParamName[1] == "Strip[1].Mute") then
			if (szParamName[2] == "1") then
				layout.strip02B08.checked = true;
			else
				layout.strip02B08.checked = false;
			end

		elseif (szParamName[1] == "Strip[2].Gain") then
			layout.strip3.progress = (szParamName[2] * 10 + 500) / 2.5;

		elseif (szParamName[1] == "Strip[2].A1") then
			if (szParamName[2] == "1") then
				layout.strip03B01.checked = true;
			else
				layout.strip03B01.checked = false;
			end

		elseif (szParamName[1] == "Strip[2].A2") then
			if (szParamName[2] == "1") then
				layout.strip03B02.checked = true;
			else
				layout.strip03B02.checked = false;
			end

		elseif (szParamName[1] == "Strip[2].A3") then
			if (szParamName[2] == "1") then
				layout.strip03B03.checked = true;
			else
				layout.strip03B03.checked = false;
			end

		elseif (szParamName[1] == "Strip[2].B1") then
			if (szParamName[2] == "1") then
				layout.strip03B04.checked = true;
			else
				layout.strip03B04.checked = false;
			end

		elseif (szParamName[1] == "Strip[2].B2") then
			if (szParamName[2] == "1") then
				layout.strip03B05.checked = true;
			else
				layout.strip03B05.checked = false;
			end

		elseif (szParamName[1] == "Strip[2].Mono") then
			if (szParamName[2] == "1") then
				layout.strip03B06.checked = true;
			else
				layout.strip03B06.checked = false;
			end

		elseif (szParamName[1] == "Strip[2].Solo") then
			if (szParamName[2] == "1") then
				layout.strip03B07.checked = true;
			else
				layout.strip03B07.checked = false;
			end

		elseif (szParamName[1] == "Strip[2].Mute") then
			if (szParamName[2] == "1") then
				layout.strip03B08.checked = true;
			else
				layout.strip03B08.checked = false;
			end

		elseif (szParamName[1] == "Strip[3].Gain") then
			layout.strip4.progress = (szParamName[2] * 10 + 500) / 2.5;

		elseif (szParamName[1] == "Strip[3].A1") then
			if (szParamName[2] == "1") then
				layout.strip04B01.checked = true;
			else
				layout.strip04B01.checked = false;
			end

		elseif (szParamName[1] == "Strip[3].A2") then
			if (szParamName[2] == "1") then
				layout.strip04B02.checked = true;
			else
				layout.strip04B02.checked = false;
			end

		elseif (szParamName[1] == "Strip[3].A3") then
			if (szParamName[2] == "1") then
				layout.strip04B03.checked = true;
			else
				layout.strip04B03.checked = false;
			end

		elseif (szParamName[1] == "Strip[3].B1") then
			if (szParamName[2] == "1") then
				layout.strip04B04.checked = true;
			else
				layout.strip04B04.checked = false;
			end

		elseif (szParamName[1] == "Strip[3].B2") then
			if (szParamName[2] == "1") then
				layout.strip04B05.checked = true;
			else
				layout.strip04B05.checked = false;
			end

		elseif (szParamName[1] == "Strip[3].MC") then
			if (szParamName[2] == "1") then
				layout.strip04B06.checked = true;
			else
				layout.strip04B06.checked = false;
			end

		elseif (szParamName[1] == "Strip[3].Solo") then
			if (szParamName[2] == "1") then
				layout.strip04B07.checked = true;
			else
				layout.strip04B07.checked = false;
			end

		elseif (szParamName[1] == "Strip[3].Mute") then
			if (szParamName[2] == "1") then
				layout.strip04B08.checked = true;
			else
				layout.strip04B08.checked = false;
			end

		elseif (szParamName[1] == "Strip[4].Gain") then
			layout.strip5.progress = (szParamName[2] * 10 + 500) / 2.5;

		elseif (szParamName[1] == "Strip[4].A1") then
			if (szParamName[2] == "1") then
				layout.strip05B01.checked = true;
			else
				layout.strip05B01.checked = false;
			end

		elseif (szParamName[1] == "Strip[4].A2") then
			if (szParamName[2] == "1") then
				layout.strip05B02.checked = true;
			else
				layout.strip05B02.checked = false;
			end

		elseif (szParamName[1] == "Strip[4].A3") then
			if (szParamName[2] == "1") then
				layout.strip05B03.checked = true;
			else
				layout.strip05B03.checked = false;
			end

		elseif (szParamName[1] == "Strip[4].B1") then
			if (szParamName[2] == "1") then
				layout.strip05B04.checked = true;
			else
				layout.strip05B04.checked = false;
			end

		elseif (szParamName[1] == "Strip[4].B2") then
			if (szParamName[2] == "1") then
				layout.strip05B05.checked = true;
			else
				layout.strip05B05.checked = false;
			end

		elseif (szParamName[8] == "Strip[4].MC") then
			if (szParamName[2] == "1") then
				layout.strip05B06.checked = true;
			else
				layout.strip05B06.checked = false;
			end

		elseif (szParamName[1] == "Strip[4].Solo") then
			if (szParamName[2] == "1") then
				layout.strip05B07.checked = true;
			else
				layout.strip05B07.checked = false;
			end

		elseif (szParamName[1] == "Strip[4].Mute") then
			if (szParamName[2] == "1") then
				layout.strip05B08.checked = true;
			else
				layout.strip05B08.checked = false;
			end

		elseif (szParamName[1] == "Bus[0].Gain") then
			layout.bus1.progress = (szParamName[2] * 10 + 500) / 2.5;

		elseif (szParamName[1] == "Bus[0].Mono") then
			if (szParamName[2] == "1") then
				layout.bus01B01.checked = true;
			else
				layout.bus01B01.checked = false;
			end

		elseif (szParamName[1] == "Bus[0].Mute") then
			if (szParamName[2] == "1") then
				layout.bus01B02.checked = true;
			else
				layout.bus01B02.checked = false;
			end

		elseif (szParamName[1] == "Bus[1].Gain") then
			layout.bus2.progress = (szParamName[2] * 10 + 500) / 2.5;

		elseif (szParamName[1] == "Bus[1].Mono") then
			if (szParamName[2] == "1") then
				layout.bus02B01.checked = true;
			else
				layout.bus02B01.checked = false;
			end

		elseif (szParamName[1] == "Bus[1].Mute") then
			if (szParamName[2] == "1") then
				layout.bus02B02.checked = true;
			else
				layout.bus02B02.checked = false;
			end

		elseif (szParamName[1] == "Bus[2].Gain") then
			layout.bus3.progress = (szParamName[2] * 10 + 500) / 2.5;

		elseif (szParamName[1] == "Bus[2].Mono") then
			if (szParamName[2] == "1") then
				layout.bus03B01.checked = true;
			else
				layout.bus03B01.checked = false;
			end

		elseif (szParamName[1] == "Bus[2].Mute") then
			if (szParamName[2] == "1") then
				layout.bus03B02.checked = true;
			else
				layout.bus03B02.checked = false;
			end

		elseif (szParamName[1] == "Bus[3].Gain") then
			layout.bus4.progress = (szParamName[2] * 10 + 500) / 2.5;

		elseif (szParamName[1] == "Bus[3].Mono") then
			if (szParamName[2] == "1") then
				layout.bus04B01.checked = true;
			else
				layout.bus04B01.checked = false;
			end

		elseif (szParamName[1] == "Bus[3].Mute") then
			if (szParamName[2] == "1") then
				layout.bus04B02.checked = true;
			else
				layout.bus04B02.checked = false;
			end

		elseif (szParamName[1] == "Bus[4].Gain") then
			layout.bus5.progress = (szParamName[2] * 10 + 500) / 2.5;

		elseif (szParamName[1] == "Bus[4].Mono") then
			if (szParamName[2] == "1") then
				layout.bus05B01.checked = true;
			else
				layout.bus05B01.checked = false;
			end

		elseif (szParamName[1] == "Bus[4].Mute") then
			if (szParamName[2] == "1") then
				layout.bus05B02.checked = true;
			else
				layout.bus05B02.checked = false;
			end
			
		end
		
		-- if String contains Bus[x].gain then mysplit(t[x],"="); set value to button or strip;
	end
end

--@help Initialize Voicemeeter Controller Connection
events.create = function ()
	hwnd = win.find(nil, "VoiceMeeterRemote Controller");
	if(hwnd == nil or hwnd == 0) 
	then 
		print("ERROR Connecting");
		layout.strip1.text = "ERROR Connecting";
		layout.strip1.progress = "0";
	else
		print("Initialization Completed");
		initVM();
		
	end
	--print(hwnd);
	
	
end

actions.connect = function ()
	hwnd = win.find(nil, "VoiceMeeterRemote Controller");
	if(hwnd == nil or hwnd == 0) 
	then 
		print("ERROR Connecting");
		layout.strip1.text = "ERROR Connecting";
		layout.strip1.progress = "0";
	else
		print("Initialization Completed");
		initVM();
	end
	--print(hwnd);
end

-- Potentiometer

--@help Change Volume of Strip 01
actions.update01 = function (progress)
	print("Strip 01: " .. progress);
	local success = win.post(hwnd, 20001, 20101, progress);
	layout.strip1.text = (0 - (500 - progress*2.5)) / 10;
end

--@help Change Volume of Strip 02
actions.update02 = function (progress)
	print("Strip 02: " .. progress);
	local success = win.post(hwnd, 20001, 20102, progress);
	layout.strip2.text = (0 - (500 - progress*2.5)) / 10;
end

--@help Change Volume of Strip 03
actions.update03 = function (progress)
	print("Strip 03: " .. progress);
	local success = win.post(hwnd, 20001, 20103, progress);
	layout.strip3.text = (0 - (500 - progress*2.5)) / 10;
end

--@help Change Volume of Strip 04
actions.update04 = function (progress)
	print("Strip 04: " .. progress);
	local success = win.post(hwnd, 20001, 20104, progress);
	layout.strip4.text = (0 - (500 - progress*2.5)) / 10;
end

--@help Change Volume of Strip 05
actions.update05 = function (progress)
	print("Strip 05: " .. progress);
	local success = win.post(hwnd, 20001, 20105, progress);
	layout.strip5.text = (0 - (500 - progress*2.5)) / 10;
end

-- BUS
--@help Change Volume of Bus 01
actions.update06 = function (progress)
	print("Bus 01: " .. progress);
	local success = win.post(hwnd, 20002, 20201, progress);
	layout.bus1.text = (0 - (500 - progress*2.5)) / 10;
end

--@help Change Volume of Bus 02
actions.update07 = function (progress)
	print("Bus 02: " .. progress);
	local success = win.post(hwnd, 20002, 20202, progress);
	layout.bus2.text = (0 - (500 - progress*2.5)) / 10;
end

--@help Change Volume of Bus 03
actions.update08 = function (progress)
	print("Bus 03: " .. progress);
	local success = win.post(hwnd, 20002, 20203, progress);
	layout.bus3.text = (0 - (500 - progress*2.5)) / 10;
end

--@help Change Volume of Bus 04
actions.update09 = function (progress)
	print("Bus 04: " .. progress);
	local success = win.post(hwnd, 20002, 20204, progress);
	layout.bus4.text = (0 - (500 - progress*2.5)) / 10;
end

--@help Change Volume of Bus 05
actions.update10 = function (progress)
	print("Bus 05: " .. progress);
	local success = win.post(hwnd, 20002, 20205, progress);
	layout.bus5.text = (0 - (500 - progress*2.5)) / 10;
end

-- Audio Route Buttons

--Strip 01

--@help Switch A1
actions.strip01A1 = function (checked)
	if(checked) then 
		print("Button 01 A1: true");
		local success = win.post(hwnd, 20003, 20301, 1);
	else
		print("Button 01 A1: false");
		local success = win.post(hwnd, 20003, 20301, 0);
	end
end

--@help Switch A2
actions.strip01A2 = function (checked)
	if(checked) then 
		print("Button 01 A2: true");
		local success = win.post(hwnd, 20003, 20302, 1);
	else
		print("Button 01 A2: false");
		local success = win.post(hwnd, 20003, 20302, 0);
	end
end

--@help Switch A3
actions.strip01A3 = function (checked)
	if(checked) then 
		print("Button 01 A3: true");
		local success = win.post(hwnd, 20003, 20303, 1);
	else
		print("Button 01 A3: false");
		local success = win.post(hwnd, 20003, 20303, 0);
	end
end

--@help Switch B1
actions.strip01B1 = function (checked)
	if(checked) then 
		print("Button 01 B1: true");
		local success = win.post(hwnd, 20003, 20306, 1);
	else
		print("Button 01 B1: false");
		local success = win.post(hwnd, 20003, 20306, 0);
	end
end

--@help Switch B2
actions.strip01B2 = function (checked)
	if(checked) then 
		print("Button 01 B2: true");
		local success = win.post(hwnd, 20003, 20307, 1);
	else
		print("Button 01 B2: false");
		local success = win.post(hwnd, 20003, 20307, 0);
	end
end

--@help Switch Mono
actions.strip01mono = function (checked)
	if(checked) then 
		print("Button 01 Mono: true");
		local success = win.post(hwnd, 20003, 20309, 1);
	else
		print("Button 01 Mono: false");
		local success = win.post(hwnd, 20003, 20309, 0);
	end
end

--@help Switch Solo // Not used, but implemented for later use
actions.strip01solo = function (checked)
	if(checked) then 
		print("Button 01 Solo: true");
		local success = win.post(hwnd, 20003, 20310, 1);
	else
		print("Button 01 Solo: false");
		local success = win.post(hwnd, 20003, 20310, 0);
	end
end

--@help Switch Mute
actions.strip01mute = function (checked)
	if(checked) then 
		print("Button 01 Mute: true");
		local success = win.post(hwnd, 20003, 20311, 1);
	else
		print("Button 01 Mute: false");
		local success = win.post(hwnd, 20003, 20311, 0);
	end
end

--Strip 02

--@help Switch A1
actions.strip02A1 = function (checked)
	if(checked) then 
		print("Button 02 A1: true");
		local success = win.post(hwnd, 20004, 20301, 1);
	else
		print("Button 02 A1: false");
		local success = win.post(hwnd, 20004, 20301, 0);
	end
end

--@help Switch A2
actions.strip02A2 = function (checked)
	if(checked) then 
		print("Button 02 A2: true");
		local success = win.post(hwnd, 20004, 20302, 1);
	else
		print("Button 02 A2: false");
		local success = win.post(hwnd, 20004, 20302, 0);
	end
end

--@help Switch A3
actions.strip02A3 = function (checked)
	if(checked) then 
		print("Button 02 A3: true");
		local success = win.post(hwnd, 20004, 20303, 1);
	else
		print("Button 02 A3: false");
		local success = win.post(hwnd, 20004, 20303, 0);
	end
end

--@help Switch B1
actions.strip02B1 = function (checked)
	if(checked) then 
		print("Button 02 B1: true");
		local success = win.post(hwnd, 20004, 20306, 1);
	else
		print("Button 02 B1: false");
		local success = win.post(hwnd, 20004, 20306, 0);
	end
end

--@help Switch B2
actions.strip02B2 = function (checked)
	if(checked) then 
		print("Button 02 A2: true");
		local success = win.post(hwnd, 20004, 20307, 1);
	else
		print("Button 02 A2: false");
		local success = win.post(hwnd, 20004, 20307, 0);
	end
end

--@help Switch Mono
actions.strip02mono = function (checked)
	if(checked) then 
		print("Button 02 Mono: true");
		local success = win.post(hwnd, 20004, 20309, 1);
	else
		print("Button 02 Mono: false");
		local success = win.post(hwnd, 20004, 20309, 0);
	end
end

--@help Switch Solo
actions.strip02solo = function (checked)
	if(checked) then 
		print("Button 02 Solo: true");
		local success = win.post(hwnd, 20004, 20310, 1);
	else
		print("Button 02 Solo: false");
		local success = win.post(hwnd, 20004, 20310, 0);
	end
end

--@help Switch Mute
actions.strip02mute = function (checked)
	if(checked) then 
		print("Button 02 Mute: true");
		local success = win.post(hwnd, 20004, 20311, 1);
	else
		print("Button 02 Mute: false");
		local success = win.post(hwnd, 20004, 20311, 0);
	end
end

--Strip 03

--@help Switch A1
actions.strip03A1 = function (checked)
	if(checked) then 
		print("Button 03 A1: true");
		local success = win.post(hwnd, 20005, 20301, 1);
	else
		print("Button 03 A1: false");
		local success = win.post(hwnd, 20005, 20301, 0);
	end
end

--@help Switch A2
actions.strip03A2 = function (checked)
	if(checked) then 
		print("Button 03 A2: true");
		local success = win.post(hwnd, 20005, 20302, 1);
	else
		print("Button 03 A2: false");
		local success = win.post(hwnd, 20005, 20302, 0);
	end
end

--@help Switch A3
actions.strip03A3 = function (checked)
	if(checked) then 
		print("Button 03 A3: true");
		local success = win.post(hwnd, 20005, 20303, 1);
	else
		print("Button 03 A3: false");
		local success = win.post(hwnd, 20005, 20303, 0);
	end
end

--@help Switch B1
actions.strip03B1 = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20005, 20306, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20005, 20306, 0);
	end
end

--@help Switch B2
actions.strip03B2 = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20005, 20307, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20005, 20307, 0);
	end
end

--@help Switch Mono
actions.strip03mono = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20005, 20309, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20005, 20309, 0);
	end
end

--@help Switch Solo
actions.strip03solo = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20005, 20310, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20005, 20310, 0);
	end
end

--@help Switch Mute
actions.strip03mute = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20005, 20311, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20005, 20311, 0);
	end
end

--Strip 04

--@help Switch A1
actions.strip04A1 = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20006, 20301, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20006, 20301, 0);
	end
end

--@help Switch A2
actions.strip04A2 = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20006, 20302, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20006, 20302, 0);
	end
end

--@help Switch A3
actions.strip04A3 = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20006, 20303, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20006, 20303, 0);
	end
end

--@help Switch B1
actions.strip04B1 = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20006, 20306, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20006, 20306, 0);
	end
end

--@help Switch B2
actions.strip04B2 = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20006, 20307, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20006, 20307, 0);
	end
end

--@help Switch M.C.
actions.strip04mc = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20006, 20312, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20006, 20312, 0);
	end
end

--@help Switch Solo
actions.strip04solo = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20006, 20310, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20006, 20310, 0);
	end
end

--@help Switch Mute
actions.strip04mute = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20006, 20311, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20006, 20311, 0);
	end
end

--Strip 05

--@help Switch A1
actions.strip05A1 = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20007, 20301, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20007, 20301, 0);
	end
end

--@help Switch A2
actions.strip05A2 = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20007, 20302, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20007, 20302, 0);
	end
end

--@help Switch A3
actions.strip05A3 = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20007, 20303, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20007, 20303, 0);
	end
end

--@help Switch B1
actions.strip05B1 = function (checked)
if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20007, 20306, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20007, 20306, 0);
	end
end

--@help Switch B2
actions.strip05B2 = function (checked)
if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20007, 20307, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20007, 20307, 0);
	end
end

--@help Switch M.C.
actions.strip05mc = function (checked)
if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20007, 20312, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20007, 20312, 0);
	end
end

--@help Switch Solo
actions.strip05solo = function (checked)
if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20007, 20310, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20007, 20310, 0);
	end
end

--@help Switch Mute
actions.strip05mute = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20007, 20311, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20007, 20311, 0);
	end
end

-- Bus Buttons

--Bus 01

--@help Switch Mono
actions.bus01mono = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20011, 20309, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20011, 20309, 0);
	end
end

--@help Switch Mute
actions.bus01mute = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20011, 20311, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20011, 20311, 0);
	end
end

--Bus 02

--@help Switch Mono
actions.bus02mono = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20012, 20309, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20012, 20309, 0);
	end
end

--@help Switch Mute
actions.bus02mute = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20012, 20311, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20012, 20311, 0);
	end
end

--Bus 03

--@help Switch Mono
actions.bus03mono = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20013, 20309, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20013, 20309, 0);
	end
end

--@help Switch Mute
actions.bus03mute = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20013, 20311, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20013, 20311, 0);
	end
end

--Bus 04

--@help Switch Mono
actions.bus04mono = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20014, 20309, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20014, 20309, 0);
	end
end

--@help Switch Mute
actions.bus04mute = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20014, 20311, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20014, 20311, 0);
	end
end

--Bus 05

--@help Switch Mono
actions.bus05mono = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20015, 20309, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20015, 20309, 0);
	end
end

--@help Switch Mute
actions.bus05mute = function (checked)
	if(checked) then 
		print("Button: true");
		local success = win.post(hwnd, 20015, 20311, 1);
	else
		print("Button: false");
		local success = win.post(hwnd, 20015, 20311, 0);
	end
end