local server = require("server");
local win = require("win");

local hwnd = nil;

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