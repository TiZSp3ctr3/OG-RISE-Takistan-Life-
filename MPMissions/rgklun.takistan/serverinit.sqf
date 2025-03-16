	
	_h = [] execVM "Awesome\MyStats\persist.sqf";
	waitUntil{scriptDone _h};
	execvm "serverside\init.sqf";
	["server"] execVM "bombs.sqf";
	[] execVM "Scripts\gangs\gang_loop_server.sqf";
	[] execVM "core\loops\convoyloop.sqf";
	[] execVM "core\loops\convoyloopopf.sqf";
	[] execvm "core\loops\dog_loop.sqf";
	[] execvm "scripts\randombank.sqf";