dispatch_locations = [
	["dispatch_rasman","Rasman"],
	["dispatch_truckstop","Truck Shop"],
	["dispatch_vehfactory","Vehicle Factory"],
	["dispatch_copbase","Cop Base"],
	["dispatch_atc","North ATC"],
	["dispatch_bank","Bank"],
	["dispatch_rubies","Ruby Mine"],
	["dispatch_gunshop","Gun Store"],
	["dispatch_civspawn","Civ Spawn"],
	["dispatch_refinery","Resource Refinery"],
	["dispatch_gs1","Gas Station 1"]
];


dispatch_crimes = [
	"Assault",
	"Murder",
	"Tampering With Body",
	"Gunshots",
	"Explosion",
	"Kidnapping",
	"Robbery",
	"Man With Gun",
	"Domestic",
	"Vehicle Theft",
	"Drugs"
];


dispatch_urgency = [
	"Urgent",
	"Medium",
	"Low Priority"
];


dispatch_report = {
	private ["_location","_type","_urgency","_callername"];
	_location = getpos player;
	_type = _this select 0;
	_urgency = _this select 1;
	_callername = name player;
	_location_string = [_location] call dispatch_get_location;
	if (isins or iscop) exitWith {};
	if ([player] call player_get_arrest) exitWith {player groupChat "You cannot call the police while in jail"};
	if (isNil "_type") exitWith {player groupChat format ["Please describe the crime"]};
	if (isNil "_urgency") then {_urgency = "low"};
	if (isNil "_callername") exitWith {};
		
	if !(dispatch_allowed) exitWith {player groupChat "You cannot call 911 right now"}; 
	
	dispatch_allowed = false;

	format ['
		if (iscop) then {
			[%1,%2,%3,%4] spawn dispatch_receive;
		};
	',_location,str(_type),str(_urgency),str(_callername)] call broadcast;

	_data = [_location_string,_type,_urgency,_callername];
	[_data] call dispatch_add_database_entry;

	player sideChat "You have called the police.";
	
	uisleep 360;
	dispatch_allowed = true;
};
dispatch_add_database_entry = {
	_data = _this select 0;
	_database = dispatch_database;
	if (isNil "_data") exitWith {};
	dispatch_database = dispatch_database + [_data];
	publicvariable "dispatch_database";

};


//[[0,0,0], "Explosions","Mothef Of God Hurry","[RISE] Sp3ctr3"] spawn dispatch_receive;

dispatch_receive = {

	private ["_location","_type","_urgency","_callername","_caller"];
	if !(iscop) exitWith {};

	_location = _this select 0;
	_location_string = [_location] call dispatch_get_location;
	_type = _this select 1;
	_urgency = _this select 2;
	_callername = _this select 3;

	if (isNil "_location") exitWith {};
	if (isNil "_type") exitWith {};
	if (isNil "_urgency") exitWith {};
	if (isNil "_callername") exitWith {};

	player say ["dispatchsound", 1];
	
	_details = format ["CALLER: %1 TYPE: %2 LOCATION: %3",_callername,_type,_location_string];
	
	_task = [format ["911 Call: %1 reported %2",_callername,_type],_details,_location] call task_create;
	
	waitUntil {player distance _location <= 30};
	
	[player, 2 ,false] call player_increase_rank;
	[_task,true,false] call task_complete;
	
	_message = format ["%1 responded to crime DETAILS: %2",name player,_details];
	[_message,"Crime Response"] call mp_log;
	player groupChat "You have responded to a 911 Call";
	
};




dispatch_get_location = {
	private ["_location","_data","_return","_marker","_string"];
	_location = _this select 0;
	_return = nil;
	{
		_data = _x;
		_marker = _data select 0;
		_string = _data select 1;

		if ((_location distance (getmarkerpos _marker)) <= 200) then {_return = _string};

	}foreach dispatch_locations;
	

	if (isNil "_return") then {_return = format ["GRID: %1",mapGridPosition _location];};

	_return
};