_vcltp=false;
_vcl = _this select 0;
_art = _this select 1;

if(_art == "spawn_remove")then {
	_crew = crew _vcl;
	{
		_x action ["Eject",_vcl];
	} forEach _crew;
	//if ((count crew _vcl) > 0) exitWith {};
	
	uiSleep 1;
	
	if(_vcl distance impoundarea2 < 10)exitwith{};
	if(!alive _vcl)exitwith{deleteVehicle _vcl;};

	_vcl setpos [(getPosATL impoundarea1 select 0)-(random 50)+(random 50), (getPosATL impoundarea1 select 1)-(random 50)+(random 50), getPosATL impoundarea1 select 2];

	format['hint format["%1 has been impounded for blocking a spawn",  %1]', _vcl] call broadcast;
	_vcl setdamage 0;
	_vcl engineOn false;
	_vcl setvehiclelock "locked";
};

if(_art == "impound")then {
	if (isNil "_vcl") exitWith {};

	if ((count crew _vcl) > 0) exitWith {
		player groupChat "The vehicle is not empty!"
	};

	if(_vcl distance impoundarea2 < 30) exitwith {
		player groupchat "the vehicle is already impounded!"
	};	
	
	if(_vcl distance impoundarea1 < 500) exitwith {
		player groupchat "the vehicle is already impounded!"
	};
/*
	if(_vcl iskindof "air")exitwith { 
		player groupchat "you cannot impound this vehicle!"
	};
*/

	//if(!alive _vcl)exitwith{player groupchat "you cannot impound this wreck!"};
	if(!alive _vcl) exitwith {
		player groupchat "Removing Wreck"; deleteVehicle _vcl; 
	};

	_incarpark = false;

	//{if ((player distance (_x select 0)) < (_x select 1)) then {_incarpark = true};} forEach INV_VehicleGaragen;
	{if (_vcl in (list _x)) then {_incarpark = true};} foreach INV_VehicleGaragen;

	if(_incarpark) exitwith {
		player groupchat "this vehicle is in a carpark. you cannot impound it!"
	};

	_vcl setpos [(getPosATL impoundarea1 select 0)-(random 50)+(random 50), (getPosATL impoundarea1 select 1)-(random 50)+(random 50), getPosATL impoundarea1 select 2];
	player groupChat localize "STRS_inventar_impound_success";

	
	format['server globalChat format[localize "STRS_inventar_impound_gesehen", "%1", "(%2)", %3]', name player, player, _vcl] call broadcast;
	
	_message =  format [localize "STRS_inventar_impound_gesehen", name player, player, _vcl];
	[_message,"Impound"] call mp_log;
	
	[player, "money", 1000] call INV_AddInventoryItem;
	player groupchat "You have earned $1000 for impounding a vehicle.";
	
	
	_vcl setdamage 0;
	_vcl engineOn false;
	_vcl setvehiclelock "locked";
	
	interact_target = nil;
};

if(_art == "buy")then {

	_vcl = call compile format["%1", _vcl];
	_money = [player] call get_dynamiccuntflap;
	_infos = (typeof _vcl) call INV_GetItemArray;
	_price = _infos call INV_GetItemBuyCost;
	_price = _price * impoundpaycoef;
	
	if (isNil "_price") then {_price = 5000};
	
	if(_money < _price) exitwith {
		player groupChat format ["You do not have enough money to pay the $%1 fine for retrieveing your impounded vehicle",[_price,","] call format_integer];
	};
	
	if (_vcl isKindOf "Air") then {	
		
		if (player distance airimpoundspawn <= 30) then {_vcl setpos (getpos airimpoundspawn); _vcl setDir (getdir airimpoundspawn);};
		if (player distance airimpoundspawn_opf <= 30) then {_vcl setpos (getpos airimpoundspawn_opf); _vcl setDir (getdir airimpoundspawn_opf);};
	
	} else {
	
		if (player distance ccarspawn <= 30) then {_vcl setpos (getpos ccarspawn); _vcl setDir (getdir ccarspawn);};
		if (player distance impoundarea2 <= 30) then {_vcl setpos (getpos impoundarea2); _vcl setDir (getdir impoundarea2);};
		if (player distance impoundarea2_opf <= 30) then {_vcl setpos (getpos impoundarea2_opf); _vcl setDir (getdir impoundarea2_opf);};	
	};

			
	[player,-_price] call transaction_dynamiccuntflap;
	player groupchat format["You payed the $%1 fine and retrieved your vehicle!", _price];
};

