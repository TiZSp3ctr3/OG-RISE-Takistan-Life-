


if (isServer) then {
	convoywaittime = 45; // Minutes
	convoyfailtime = 1200; // Seconds
	_spawns  = [[convspawn1, 10], [convspawn2, 10], [convspawn3, 10], [convspawn4, 10], [convspawn5, 10]];
	
	while {true} do {
	
		uiSleep (convoywaittime * 60);
	
		convoy_has_cash = true;
		publicVariable "convoy_has_cash";
		
		_spawn = _spawns select round random (count _spawns - 1);
		_position = (_spawn select 0);
		
		bluforconvoytruck = createVehicle ["MTVR_DES_EP1", (getPosATL _position), [], 0, "NONE"];
		bluforconvoytruck setDir getdir _position;
		bluforconvoytruck setVehicleInit 'bluforconvoytruck = this; this setVehicleVarName "bluforconvoytruck"; clearWeaponCargo this; clearMagazineCargo this;';
		processInitCommands;
		publicVariable "bluforconvoytruck";
		bluforconvoytruck setVariable ["car_save",true,true];
		bluforconvoytruck setVariable ["isPlayerVehicle",true,true];
		
		_markerobj = createMarker ["convoy",[0,0]];																				
		_markername = "convoy";																														
		_markerobj setMarkerShape "ICON";								
		"convoy" setMarkerType "Marker";										
		"convoy" setMarkerColor "ColorRed";																														
		"convoy" setMarkerText "North Takistan Government Truck";
		
		format ['
			if (iscop) then {
				convoytask = ["Secure Government Convoy","Deliver the government convoy to the blufor base for a cash payout"] call task_create;
			};
		'] call broadcast;
		
		_success = true;
		_timed_out = false;
		_delivered = false;
		_destroyed = false;
		_cash_stolen = false;
		
		_message = format ["The North Takistan Government convoy truck has arrived. Blufor must secure it!"];
		format ['hint "%1"; server globalChat "%1";',_message] call broadcast;
	
		_timer = 0;
		while {true} do {
			"convoy" setmarkerpos getpos bluforconvoytruck;	
			if !(alive bluforconvoytruck) exitWith {_destroyed = true};
			if !(convoy_has_cash) exitWith {_cash_stolen = true};
			if ((bluforconvoytruck distance copbase1 <= 50) and (speed bluforconvoytruck <= 5)) exitWith {_delivered = true};
			if (_timer >= convoyfailtime) exitWith {_timed_out = true};
			
			uiSleep 1;
			_timer = _timer + 1;
		};
		
		if (_timed_out) then {
			_message = format ["The northern government convoy has left. The next one will arrive in %1 minutes",convoywaittime];
			_success =	false;
		};	
		if (_cash_stolen) then {
			_message = format ["The northern government convoy has been robbed. The next one will arrive in %1 minutes",convoywaittime];
			_success = false;
		};	
		if (_delivered) then {
			_success = true;
			_message = format ["The northern government convoy has arrived safely at the blufor base. The next will arrive in %1 minutes",convoywaittime];
			format ['
				if (iscop) then {
					[player, %1] call transaction_dynamiccuntflap;
					player sideChat "You received $%2 for a sucessfull convoy delivery";
				};
			
			',govconvoybonus,[govconvoybonus,","] call format_integer] call broadcast;
		};	
		if (_destroyed) then {
			_message = format ["The northern government convoy has been destroyed. The next one will arrive in %1 minutes",convoywaittime];
			_success = false;
		};
		if !(isNil "_message") then {
			format ['hint "%1"; server globalChat "%1";',_message] call broadcast;
		};
		
		format ['
			if (iscop) then {
				if !(isNil "convoytask") then {
					[convoytask,%1,false] call task_complete;
				};
			};
		',_success] call broadcast;
		
		deleteVehicle bluforconvoytruck;
		deleteMarker "convoy";
		
		uiSleep 10;
	};
};