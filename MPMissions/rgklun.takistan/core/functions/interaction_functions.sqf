///// Defaults //////

_copatm_interactions = [
	["Elect Police Cheif",'closedialog 0; ["chief"] spawn dialog_handler;',"iscop"],
	["Get Defense Mission",'[] execvm "core\missions\defense_mission.sqf";closedialog 0;',"!defense_active and iscop"],
	["Go To Airbase",' [] call goto_airbase',"iscop"],
	["Declare Martial Law",'[] call declare_martial_law; closedialog 0;',"(!martiallaw)"],
	["End Martial Law",'[] call end_martial_law; closedialog 0;',"martiallaw"],
	[format["Buy bank insurance ($%1)", ("bank_insurance" call INV_GetItemBuyCost)],'if( [player, "money"] call INV_GetItemAmount < ("bank_insurance" call INV_GetItemBuyCost))exitwith{player groupchat "not enough shekels"};if(buybi)exitwith{player groupchat "already buying insurance"};buybi = true;[player, "money", -("bank_insurance" call INV_GetItemBuyCost)] call INV_AddInventoryItem;[player, "bank_insurance", 1] call INV_AddInventoryItem;player groupchat format["you bought bank insurance for $%1", ("bank_insurance" call INV_GetItemBuyCost)];buybi = false;',"(true)"],
	["Private Storage",'closedialog 0; [player] call interact_private_storage_menu;',"true"]
];
_srt_tp_actions = [
	["Go To SRT Base",'player setpos (getmarkerpos "srt_base")',"srt and iscop"]
];
_gov_actions = [
	["Elect A President",'["president"] spawn dialog_handler;',"true"],
	["Change Laws",'["gesetz"] spawn dialog_handler;',"isPresident"],
	["Change Taxes",'["steuern"] call spawn;',"isPresident"],
	["Crime Log",'["coplog"] spawn dialog_handler;',"true"]
];
_vipActions = [
	["Escort VIP",'[VIPtarget] join (group player); player groupchat "escort the VIP to the police base before he is assassinated!";',"iscop"]
];
_mineActions = [
	["Process Resources",'[] call refinery_menu_open',"iscop"]
];

_blu_convoy = [
	["Steal Blufor Payroll",'convoy_has_cash=false; publicvariable "convoy_has_cash"; [player, "money", govconvoybonus] call INV_AddInventoryItem; player groupchat format["You stole $%1!", _cash];',"_driver = driver bluforconvoytruck; player distance bluforconvoytruck <= 7 and convoy_has_cash and (isciv or isins) and (!alive _driver or isnull _driver)"]
];

_opf_convoy = [
	["Steal Opfor Payroll",'opf_convoy_has_cash=false; publicvariable "opf_convoy_has_cash"; [player, "money", govconvoybonus] call INV_AddInventoryItem; player groupchat format["You stole $%1!", _cash];',"_driver = driver opforconvoytruck; player distance opforconvoytruck <= 7 and convoy_has_cash and (isciv or isins) and (!alive _driver or isnull _driver)"]
];

_gsActions = [
	["Purchase Lottery Ticket",'["lotto1", "lotto2", "lotto3", "lotto4"] execvm "lottodialog.sqf";',"true"]
];
_opfor_atm = [
	["Elect a Commander",'["commander"] spawn dialog_handler;',"true"],
	["Declare War",'[] call war_declare',"true"],
	["Get Defense Mission",'[] execvm "core\missions\Defence_Mission_Opf.sqf"; ',"!defense_active"]
];

_indyAtm = [
	["Get Bombing Mission",'[] execVM "Scripts\terror_bombing.sqf";',"true"],
	["Elect A Caliph",'["caliph"] spawn dialog_handler;',"true"]
	
];

vehicle_interactions = [
	["Impound Vehicle",'[interact_target,"impound"] call A_SCRIPT_IMPOUND',"iscop or isopf or isesu"],
	["Put Players In Vehicle",'[] call player_putincar',"player distance interact_target < 5"],
	["Unflip Vehicle",'[] spawn vehicle_unflip;',"player distance interact_target < 5 "],
	["Save Car From Carmagedon",'[] execvm "Scripts\safe_car.sqf";',"player distance interact_target < 5"],
	["Pull out",'(getpos player nearEntities [["Air", "Ship", "LandVehicle"], 5] select 0) execVM "pullout.sqf";',"count (crew interact_target) > 0 and ([interact_target] call INV_IsPlayerVehicle) and (call INV_IsArmed)"],
	[localize "STRS_addAction_vehicleinfo",'(getpos player nearEntities [["Air", "Ship", "LandVehicle"], 5] select 0) call A_SCRIPT_VEHINFO;',"([interact_target] call INV_IsPlayerVehicle) and (iscop or isopf or isStaff)"],
	[localize "STRS_addaction_trunk_check",'[] call vehicle_search',"not([player, interact_target] call vehicle_owner) and ([interact_target] call INV_IsPlayerVehicle) and (iscop or isopf)"],
	["Lock Storage",'[] call lock_vehicle_storage','[player,interact_target] call vehicle_owner and !(interact_target getVariable "storage_lock")'],
	["Unlock Storage",'[] call unlock_vehicle_storage','[player,interact_target] call vehicle_owner and (interact_target getVariable "storage_lock")'],
	["Check Drivers Licenses",'[player,interact_target] call interaction_vehicle_license_driver; closedialog 0','iscop or isopf'],
	["Ticket Driver",'[] call interaction_vehicle_ticket_driver','iscop or isopf']
	
];


// Always keep below the local vars
interactables = [
	[default_flagpole,20,[["Open Spawn Menu",'[] call open_spawn_menu',"true"]]],
	["prisonspawn",40,[["Place Charge",'[] spawn jail_break_function',"isciv or isins"]]],
	[bailflag,5,[["Pay Bail",'["bail"] spawn dialog_handler;',"isciv"]]],
	[rathaus,3,_gov_actions],
	
	[CopBank,5,_copatm_interactions],
	[atm5,5,_opfor_atm],
	[insurgent_atm,5,_indyAtm],
	
	[impoundbuy,5,[["Impound Lot",'[] call impound_retrieve',"true"]]],
	[copcar,5,[["Impound Lot",'[] call impound_retrieve',"true"]]],
	[impoundbuy_opf,5,[["Impound Lot",'[] call impound_retrieve',"true"]]],
	[airimpound,5,[["Impound Lot",'["Air"] call impound_retrieve',"true"]]],
	[airimpound_opf,5,[["Impound Lot",'["Air"] call impound_retrieve',"true"]]],
	
	[VIPTarget,15,_vipActions],
	
	[takistan_mine_1,5,_mineActions],
	
	[bluforconvoytruck,7,_blu_convoy],
	[opforconvoytruck,7,_opf_convoy],
	
	[fuelshop1,5,_gsActions],
	[fuelshop2,5,_gsActions],
	[fuelshop3,5,_gsActions],
	[fuelshop4,5,_gsActions],
	[fuelshop5,5,_gsActions],
	[fuelshop6,5,_gsActions],
	[fuelshop7,5,_gsActions],
	[fuelshop8,5,_gsActions],
	[fuelshop9,5,_gsActions],
	
	
	["hospital_entry",2,[["Enter Hospital",'player setpos (getmarkerPos "hospital_exit")',"true"]]],
	["hospital_exit",2,[["Exit Hospital",'player setpos (getmarkerPos "hospital_entry")',"true"]]],
	["hospital_entry2",2,[["Enter Hospital",'player setpos (getmarkerPos "hospital_exit2")',"true"]]],
	["hospital_exit2",2,[["Exit Hospital",'player setpos (getmarkerPos "hospital_entry2")',"true"]]],
	[srt_tp_stand,2,_srt_tp_actions]
];

///// Functions /////////

interaction_handle = {
	
	private ["_info","_distance"];
	_info = [] call interaction_get_vehicle_interactions;
	if !(count _info > 0) then {
		_info = [] call interaction_get_near_interactions;
	};
	
	if !(count _info > 0) then {
		_info = [] call interaction_get_player_interactions;
	};

	if (count _info <= 0) exitWith { systemChat format ["No Interactions Avaliable"];};
	
	_distance = _info select 1;
	_object = _info select 0;
	
	if (typeName _object == "STRING") then {
		if (player distance getmarkerpos _object > _distance) exitWith {systemChat format ["Interactable too far away"];};
	} else {
		if (player distance _object > _distance) exitWith {systemChat format ["Interactable too far away"];};
	};
	
	_info call interaction_menu_open;
};

interaction_get_player_interactions = {

	_array = [
		//["Open Phone",'[] call item_handy','(([player,"handy"] call INV_GetItemAmount) > 0) and phonetesting and !(([player,"ziptied"] call player_get_bool) or ([player,"restrained"] call player_get_bool) or ([player,"isstunned"] call player_get_bool))'],
		["Battle Cry",'[] execVM "Scripts\battlecry.sqf";','allow_battlecry and isins'],
		["Deploy Drone",'[] spawn taki_drone_deploy;','(typeOf unitBackpack player == "US_UAV_Pack_EP1" and drone_testing and !drone_deployed);'],
		["Control Drone",'[1] call taki_drone_control;','drone_deployed and drone_testing'],
		["Destroy Drone",'[] call taki_drone_destroy','drone_deployed and drone_testing'],
		["Lock Backpack",'[] call lock_backpack_storage','(typeOf unitBackpack player != "" and !backpack_locked)'],
		["Unlock Backpack",'[] call unlock_backpack_storage','(typeOf unitBackpack player != "" and backpack_locked)'],
		["Cancel Action",'working = false','working']

	];
	

	[player,1,_array]
};

interaction_get_vehicle_interactions = {
	private ["_return"];
	interact_Target = (nearestObjects [player,["Air", "Ship", "LandVehicle"],5] select 0);
	if (isNil "interact_Target") then {
		_return = [];
	} else {
		_return = [interact_Target,5,vehicle_interactions];
	};
	_return
};

interaction_loop = {

	interactions_avaliable = false;
	interaction_loop_run = true;

	[] spawn interaction_loop_logic;
	[] spawn interaction_loop_notification;	
};

interaction_loop_logic = {
	while {interaction_loop_run} do {
		_bool = [] call interaction_get_near_interactions;
		_bool = (count _bool > 0);
		interactions_avaliable = _bool;
		uiSleep 1;
	};
};

interaction_loop_notification = {
	while {interaction_loop_run} do {
		waitUntil {interactions_avaliable};
		["Interactions Avaliable (LEFT WIN)"] spawn hud_notification; 
		waitUntil {!interactions_avaliable};
	};
};

interaction_get_near_interactions = {
	private ["_array","_object","_actions","_obj","_dst"];
	_array = [];
	_object = nil;
	_distance = nil;
	_actions = nil;
	
	for "_i" from 0 to (count interactables - 1) do {
		_entry = interactables select _i;
		_obj = _entry select 0;
		_dst = _entry select 1;
		
		if !(isNil "_obj") then { 
			if(typeName _obj == "STRING") then { 
				if (player distance (getmarkerpos _obj) <= _dst) then {
					_object = _obj;
					_distance = _dst;
					_actions = _entry select 2;
				};
			} else {
				if (player distance _obj <= _dst) then {
					_object = _obj;
					_distance = _dst;
					_actions = _entry select 2;
				};
			};
		};
	};
	
	if (isNil "_object" or isNil "_distance" or isNil "_actions") then {
		_array = [];
	} else {
		_array = [_object,_distance,_actions];
	};
	
	_array
};

interaction_menu_open = {
	disableSerialization;
	_object = _this select 0;
	_distance = _this select 1;
	_actions = _this select 2;
	_exit = false;
	
	// Checks
	if (isNil "_distance") then {_distance = 3};
	if (isNil "_object" or isNil "_actions") exitWith {diag_log "DEBUG: Interaction menu cannot open. Bad arguments"};
	
	if (typeName _object == "STRING") then {
		if (player distance (getmarkerpos _object) > _distance) then {_exit = true};
	} else {
		if (player distance _object > _distance) then {_exit = true};
	};
	
	if (dialog) then {closedialog 0};
	if (_exit) exitWith {};
	createDialog "interaction_menu";
	if ((count _actions - 1) > 12) then {diag_log "DEBUG: Too many actions for the interaction menu"};
	
	for "_i" from 0 to 12 do
	{
		ctrlShow [1601 + _i, false];
	};
	
	_lastButton = 0;
	{
			_interaction = _x;
			_title = _interaction select 0;
			_code = _interaction select 1;
			_bool = _interaction select 2;
			_display = findDisplay 1600;	
			
			if (call compile _bool) then {
				_ctrl = _display displayCtrl (1601 + _lastButton);
				_ctrl ctrlSetText _title;
				_ctrl ctrlShow true;
				_ctrl buttonSetAction _code;
				_lastButton = _lastButton + 1;
			};
	} forEach _actions;
};


interaction_vehicle_ticket_driver = {
	private ["_vehicle","_driver"];
	_vehicle = interact_target;
	_driver = driver _vehicle;
	if (isNull _driver) exitWith {player groupChat "There is no driver"};
	if (isNull _vehicle) exitWith {player groupChat "There is no vehicle"};
	
	civ_player_variable = _driver;
	["ticket_menu"] spawn dialog_handler; 
	closedialog 0;
	
};

interaction_vehicle_license_driver = {
	private ["_vehicle","_driver"];
	_vehicle = interact_target;
	_driver = driver _vehicle;
	if (isNull _driver) exitWith {player groupChat "There is no driver"};
	if (isNull _vehicle) exitWith {player groupChat "There is no vehicle"};
	
	civ_player_variable = _driver;
	[player,civ_player_variable] call interact_check_licenses;
	
};

interaction_vehicle_run_driver = {
	private ["_vehicle","_driver"];

};

//[] spawn interaction_loop;
