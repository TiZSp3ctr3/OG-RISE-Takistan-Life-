


if (isServer) then {
	convoywaittime = 45; // Minutes
	convoyfailtime = 1200; // Seconds
	_spawns  = [[opfconvspawn1, 10], [opfconvspawn2, 10], [opfconvspawn3, 10], [opfconvspawn4, 10], [opfconvspawn5, 10], [opfconvspawn6, 10]];
	
	uiSleep (60 * 22); // Delay by 22 minutes so that the opfor and blufor convoy loops wont be spamming chat with messages
	
	while {true} do {
	
		uiSleep (convoywaittime * 60);
	
		opf_convoy_has_cash = true;
		publicVariable "opf_convoy_has_cash";
		
		_spawn = _spawns select round random (count _spawns - 1);
		_position = (_spawn select 0);
		
		opforconvoytruck = createVehicle ["MAZ_543_SCUD_TK_EP1", (getPosATL _position), [], 0, "NONE"];
		opforconvoytruck setDir getdir _position;
		opforconvoytruck setVehicleInit 'opforconvoytruck = this; this setVehicleVarName "opforconvoytruck"; clearWeaponCargo this; clearMagazineCargo this;';
		processInitCommands;
		publicVariable "opforconvoytruck";
		opforconvoytruck setVariable ["car_save",true,true];
		opforconvoytruck setVariable ["isPlayerVehicle",true,true];
		
		_markerobj = createMarker ["opf_convoy",[0,0]];																				
		_markername = "opf_convoy";																														
		_markerobj setMarkerShape "ICON";								
		"opf_convoy" setMarkerType "Marker";										
		"opf_convoy" setMarkerColor "ColorRed";																														
		"opf_convoy" setMarkerText "South Takistan Government Truck";
		
		format ['
			if (isopf) then {
				convoytask = ["Secure Government Convoy","Deliver the government convoy to the opfor base for a cash payout"] call task_create;
			};
		'] call broadcast;
		
		_success = true;
		_timed_out = false;
		_delivered = false;
		_destroyed = false;
		_cash_stolen = false;
		
		_message = format ["The South Takistan Government convoy truck has arrived. Opfor must secure it!"];
		format ['hint "%1"; server globalChat "%1";',_message] call broadcast;
	
		_timer = 0;
		while {true} do {
			"opf_convoy" setmarkerpos getpos opforconvoytruck;	
			if !(alive opforconvoytruck) exitWith {_destroyed = true};
			if !(opf_convoy_has_cash) exitWith {_cash_stolen = true};
			if ((opforconvoytruck distance opfbase1 <= 50) and (speed opforconvoytruck <= 5)) exitWith {_delivered = true};
			if (_timer >= convoyfailtime) exitWith {_timed_out = true};
			
			uiSleep 1;
			_timer = _timer + 1;
		};
		
		if (_timed_out) then {
			_message = format ["The southern government convoy has left. The next one will arrive in %1 minutes",convoywaittime];
			_success = false;
		};	
		if (_cash_stolen) then {
			_message = format ["The southern government convoy has been robbed. The next one will arrive in %1 minutes",convoywaittime];
			_success = false;
		};	
		if (_delivered) then {
			_message = format ["The southern government convoy has arrived safely at the opfor base. The next will arrive in %1 minutes",convoywaittime];
			_success = true;
			format ['
				if (isopf) then {
					[player, %1] call transaction_dynamiccuntflap;
					player sideChat "You received $%2 for a sucessfull convoy delivery";
				};
			
			',govconvoybonus,[govconvoybonus,","] call format_integer] call broadcast;
		};	
		if (_destroyed) then {
			_message = format ["The southern government convoy has been destroyed. The next one will arrive in %1 minutes",convoywaittime];
			_success = false;
		};
		if !(isNil "_message") then {
			format ['hint "%1"; server globalChat "%1";',_message] call broadcast;
		};
		
		format ['
			if (isopf) then {
				if !(isNil "convoytask") then {
					[convoytask,%1,false] call task_complete;
				};
			};
		',_success] call broadcast;
		
		deleteVehicle opforconvoytruck;
		deleteMarker "opf_convoy";
		
		uiSleep 10;
	};
};