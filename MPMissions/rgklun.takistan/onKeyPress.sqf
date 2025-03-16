#include "Awesome\Functions\dikcodes.h"


stunned_allowed_actions = ["Chat", "NextChannel", "PrevChannel", "VoiceOverNet", "ShowMap", "PushToTalkAll", "PushToTalkCommand", "PushToTalkDirect", "PushToTalkGroup", "PushToTalkSide", "PushToTalkVehicle", "PushToTalkAll", "PushToTalk"];

agony_allowed_actions = ["Chat", "NextChannel", "PrevChannel"];

keyboard_get_stunned_allowed_keys = {
	private["_keys"];

	_keys = [];
	{
		private["_action"];
		_action = _x;
		_keys = _keys + (actionKeys _action);
	} forEach stunned_allowed_actions;
	_keys
};

keyboard_get_agony_allowed_keys = {
	private["_keys"];

	_keys = [];
	{
		private["_action"];
		_action = _x;
		_keys = _keys + (actionKeys _action);
	} forEach agony_allowed_actions;
	if ( time > ((player getVariable ["FA_AST", 0]) + 60)) then {
			_keys set[count _keys, "IngamePause"];
		};
	_keys
};

keyboard_animation_handler = {

	if(!INV_shortcuts) exitWith { false };
	if(arrested) exitWith{ false };
	if (([player, (vehicle player)] call mounted_player_inside)) exitWith { false };
	_state = animationState player;
	if (_state in player_vulnerable_states) exitWith { player groupChat "You are not allowed to access this currently."};
	if(dialog) exitWith {closeDialog 0;};
	[] call animations_dialog_open;
	true
};
dispatch_handler = {
	dispatch_response = true;
};

keyboard_tlr_keys_handler = {
	private["_key_spam"];
	_key_spam = false;
	if (isNil "handling_tlr_toggle") then {
		handling_tlr_toggle = true;
	}
	else { if ( handling_tlr_toggle) then {
		_key_spam = true;
	};};
	if (_key_spam) exitWith {};

	if (INV_shortcuts) then {
		titletext["TLR keys off", "PLAIN DOWN"];
		call A_actionsremove;
		INV_shortcuts = false;
	}
	else {
		titletext["TLR keys on", "PLAIN DOWN"];
		call A_actions;
		INV_shortcuts = true;
	};

	handling_tlr_toggle = false;
	true
};

keyboard_lock_unlock_handler = {
	if(!INV_shortcuts) exitWith { false };
	private["_vcls", "_vcl"];
	_vcls = nearestobjects [getpos player, ["LandVehicle", "Air", "ship"], 25];
	_vcl = _vcls select 0;

	if (vehicle player != player) then {
		_vcl = vehicle player;
	};

	if (not([player, _vcl] call vehicle_owner)) exitWith {
		player groupchat "You do not have the keys to this vehicle.";
		true
	};

	[_vcl] call keys_use;
	true;
};

keyboard_trunk_handler = {
	if(!INV_shortcuts) exitWith { false };
	if(dialog) exitWith {closeDialog 0; false };

	private["_vcls", "_vcl"];
	_vcls = nearestobjects [getpos player, ["LandVehicle", "Air", "ship", "TKOrdnanceBox_EP1"], 25];
	_vcl = _vcls select 0;

	if !(alive _vcl) exitwith {
			player groupchat "Vehicle is destroyed.";
		};


	private["_inside_vehicle"];
	_inside_vehicle = not((vehicle player) == player);
	if (_inside_vehicle) exitWith {
		player groupChat format["You must be outside the vehicle to use the trunk"];
	};

	private["_vehicle"];
	_vehicle = cursorTarget;
	if (isNil "_vehicle") exitWith {false};
	if (typeName _vehicle != "OBJECT") exitWith {false};
	if (not(_vehicle isKindOf "LandVehicle" || _vehicle isKindOf "Air" || _vehicle iskindOf "Ship" || _vehicle isKindOf "TKOrdnanceBox_EP1")) exitWith {false};

	private["_distance"];
	_distance = _vehicle distance player;
	if (_distance > 10 ) exitWith {false};
	if (_distance > 5 ) exitWith {
		player groupChat format["You need to be closer to the vehicle to use the trunk"];
	};



	if(not([player, _vehicle] call vehicle_owner)) exitWith {
		player groupchat "You do not have the keys to this vehicle.";
		false
	};

	if (([_vehicle] call trunk_in_use)) exitWith {
		player groupChat format["This vehicle's trunk is being used by %1", ([_vehicle] call trunk_user)];
		false
	};

	[_vehicle] call trunk_open;
	[player, _vehicle] call interact_vehicle_storage_menu;
	true
};

keyboard_ziptied_check = {
	(([player, "ziptied"] call player_get_bool))
};

keyboard_stunned_check = {
	(([player, "isstunned"] call player_get_bool))
};

keyboard_restrained_check = {
	if (iscop or isopf) exitWith {false};
	(([player, "restrained"] call player_get_bool) or ([player, "ziptied"] call player_get_bool));
};

keyboard_agony_check = {
		player getVariable ["FA_inAgony", false];
	};


keyboard_interact_handler = {
	private["_ctrl"];
	_ctrl = _this select 0;

	if (!INV_shortcuts) exitWith {false};
	if (keyblock) exitWith {false};
	if (dialog ) exitWith {closeDialog 0; false};
	if (arrested) exitWith{ false };

	private ["_civ", "_handled", "_i"];

	//INTERACTIONS WITH PLAYERS, AI, ATM
	for [{_i=1}, {_i < 3}, {_i=_i+1}] do {
		if(vehicle player != player) exitWith {false};
		_range = _i;
		_dirV = vectorDir vehicle player;
		_pos = player modelToWorld [0,0,0];
		_posFind = [(_pos select 0)+(_dirV select 0)*_range,(_pos select 1)+(_dirV select 1)*_range,(_pos select 2)+(_dirV select 2)*_range];
		_men    = nearestobjects [_posFind,["Man", "RUBasicAmmunitionBox", "UNBasicAmmunitionBox_EP1", "BarrelBase", "Barrels", "Infostand_2_EP1","Barrel5"], 1] - [player];
		_atms   = nearestObjects [_posFind,["Man", "Misc_cargo_cont_tiny", "BarrelBase", "Barrels"],2];
		_clothes= nearestObjects [_posFind,["Barrel5", "BarrelBase", "Barrels"],2];
		_clotheshop = _clothes select 0;
		_civ    = _men select 0;
		_atm	= _atms select 0;

		_handled = [player, _atm] call interact_atm;
		if (_handled) exitWith {};
		
		_handled = [player, _civ] call interact_chopshop;
		if (_handled) exitWith {};

		_handled = [player, _civ] call interact_human;
		if (_handled) exitWith {};

		_handled = [player, _civ] call interact_ai;
		if (_handled) exitWith {};

		_handled = [player, _clotheshop] call interact_clothes;
		if (_handled) exitWith {};
	};

	if(_handled) exitWith { true };

	//INTERACTIONS WITH VEHICLES
	private["_player_inside"];
	_player_inside = [player, (vehicle player)] call mounted_player_inside;
	//player groupChat format["_player_inside = %1", _player_inside];
	if (not(_player_inside) && not(_ctrl)) exitWith {
		private ["_vcl"];
		for [{_i=1}, {_i < 3}, {_i=_i+1}] do {
			_range = _i;
			_dirV = vectorDir vehicle player;
			_pos = player modelToWorld [0,0,0];
			_posFind = [(_pos select 0)+(_dirV select 0)*_range,(_pos select 1)+(_dirV select 1)*_range,(_pos select 2)+(_dirV select 2)*_range];
			_vcls    = nearestobjects [_posFind,["LandVehicle", "Air", "ship"], 5];
			_vcl     = _vcls select 0;
			if(not(isnull _vcl)) exitWith {_i = 4};
		};

		if(locked _vcl) exitWith { false };

		private["_entered"];
		_entered = [player, _vcl, true] call player_enter_vehicle;

		if (_entered) exitWith {
			 [] spawn {
				keyblock=true;
				uiSleep 1;
				keyblock=false;
			};
			true
		};
		false
	};


	_vcl  = vehicle player;

	if(_vcl != player) exitWith {
		if(locked _vcl) exitWith {
			player groupchat "The vehicle is locked. Disembark by pressing Control + E";
			false
		};
		if(speed _vcl > 30) exitWith {
			player groupchat "The vehicle is moving too fast";
			false
		};
		[player, _vcl, true] call player_exit_vehicle;
		true
	};

	true
};

keyboard_breakout_vehicle_handler = {
	if(!INV_shortcuts) exitWith {false};
	if (keyblock) exitWith {false};
	[player, (vehicle player)] spawn interact_vehicle_breakout;
	true
};

keyboard_siren_handler = {
	if(!INV_shortcuts) exitWith {false};
	private["_isDriver"];
	_isDriver = (driver(vehicle player) == player);
	if (not(_isDriver)) exitWith { false };
	_veh_name = [vehicle player, "item_name"] call vehicle_get_string;
	if (iscop or isopf  or isesu or (_veh_name in cop_car_names)) then
	{
		[0,0,0,["activate"]] execVM "siren.sqf";
	};
	true
};

keyboard_stun_handler = {
	if(!INV_shortcuts) exitWith {false};
	if(player distance default_flagpole < 200) exitWith {false};
	[3, player] call STUN_HANDLER;
	true
};

keyboard_cop_horn_handler = {
	if(!INV_shortcuts) exitWith {false};
	private["_isDriver"];
	_isDriver = (driver(vehicle player) == player);
	if (not(_isDriver)) exitWith { false };
	[0,0,0,["activate"]] execVM "Awesome\Scripts\policehorn.sqf";
	true
};
keyboard_cop_horn_change_handler = {
	if(!INV_shortcuts) exitWith {false};
	private["_isDriver"];
	_isDriver = (driver(vehicle player) == player);
	if (not(_isDriver)) exitWith { false };
	execVM "Scripts\change_horn.sqf";
	true
};

keyboard_main_dialog_handler = {
	if(!INV_shortcuts) exitWith {false};
	if(dialog) exitWith {closeDialog 0; false };
	["spielerliste"] spawn dialog_handler;
	true
};

keyboard_inventory_dialog_handler = {
	if(!INV_shortcuts) exitWith {false};
	if(dialog) exitWith {closeDialog 0; false};
	[player] spawn interact_inventory_menu;
	true
};

keyboard_retributions_handler = {
	if(!INV_shortcuts) exitWith {false};
	if(dialog) exitWith {closeDialog 0; false};
	["open"] spawn retributions_main;
	true
};

keyboard_surrender_handler = {
	if(!INV_shortcuts) exitWith {false};
	if(keyblock || vehicle player != player) exitWith {false};
	keyblock=true; [] spawn {
		uiSleep 2;
		keyblock=false;
	};
	player playmove "amovpercmstpssurwnondnon";
	[player] spawn stun_weapons_drop;
	true;
};

keyboard_switch_normal_handler = {
	if(!INV_shortcuts) exitWith {false};
	if(keyblock) exitWith {false};
	keyblock=true;
	[] spawn {
		uiSleep 2;
		keyblock=false;
	};

	[[], "mp_anim_sync", [player,"switchmove","normal"]] call mp_aware_me;

	true
};

keyboard_gangs_handler = {
	if(!INV_shortcuts) exitWith {false};
	if(dialog) exitWith {closeDialog 0; false};
	if (not(isciv) || isins || isopf) exitWith {false};
	["gangmenu"] spawn dialog_handler;
	true
};

keyboard_admin_menu_handler = {
	private ["_noMenu"];
	if(!INV_shortcuts) exitWith {false};
	
	if !(isStaff or istsh or supervisor) exitWith {false};
	
	if (dialog) then {
		closeDialog 0; 
		[player] execVM "adminconsolfill.sqf";
		createDialog "Main";
	} else {
		[player] execVM "adminconsolfill.sqf";
		createDialog "Main";
	};
	
	true
};

keyboard_cop_menu_handler = {
	if(!INV_shortcuts) exitWith {false};
	if(dialog) exitWith {closeDialog 0; false};
	if (not(iscop or isopf)) exitWith {false};
	if ([player] call player_get_dead) exitWith {};

	private["_inVehicle"];
	_inVehicle = (vehicle player != player);

	if (not(_inVehicle)) then {
		["copmenulite"] spawn dialog_handler;
	}
	else {
		["copmenu"] spawn dialog_handler;
	};

	true
};


keyboard_forward_tuning_handler = {
	private["_vcl", "_lvl", "_vel", "_spd"];
	_vcl = vehicle player;

	if (not(isEngineOn _vcl)) exitWith { false };

	if(_vcl iskindof "Motorcycle") then {
		_vel = velocity _vcl;
		_spd = speed _vcl;
		_vcl setVelocity [(_vel select 0) * 1.001, (_vel select 1) * 1.001, (_vel select 2) * 0.99];
	};

	_lvl = 0;
	_lvl = _vcl getvariable ["tuning", 0];
	if (_lvl == 0) exitWith {false};

	if( _vcl iskindof "LandVehicle") then {
		_vel = velocity _vcl;
		_spd = speed _vcl;
		switch _lvl do {
			case 1: {
				_vcl setVelocity [(_vel select 0) * 1.001, (_vel select 1) * 1.001, (_vel select 2)];
			};
			case 2: {
				_vcl setVelocity [(_vel select 0) * 1.002, (_vel select 1) * 1.002, (_vel select 2)];
			};
			case 3: {
				_vcl setVelocity [(_vel select 0) * 1.003, (_vel select 1) * 1.003, (_vel select 2)];
			};
			case 4: {
				_vcl setVelocity [(_vel select 0) * 1.004, (_vel select 1) * 1.004, (_vel select 2)];
			};
			case 5: {
				_vcl setVelocity [(_vel select 0) * 1.006, (_vel select 1) * 1.006, (_vel select 2)];
			};
			case 6: {
				_vcl setVelocity [(_vel select 0) * 1.008, (_vel select 1) * 1.008, (_vel select 2)];
			};
			case 7: {
				_vcl setVelocity [(_vel select 0) * 1.010, (_vel select 1) * 1.010, (_vel select 2)];
			};
			case 8: {
				_vcl setVelocity [(_vel select 0) * 0.800, (_vel select 1) * 0.800, (_vel select 2)];
			}
		};
	};

	false
};

keyboard_vehicle_nitro_handler = {
	private["_nos", "_vcl", "_spd", "_vel"];
	_vcl = vehicle player;

	_nos = 0;
	_nos = _vcl getvariable ["nitro", 0];
	if (_nos == 0) exitWith { false };
	if (not(isEngineOn _vcl)) exitWith { false };

	_vel  = velocity _vcl;
	_spd  = speed _vcl;
	_fuel = fuel _vcl;
	_vcl setVelocity [(_vel select 0) * 1.007, (_vel select 1) * 1.007, (_vel select 2) * 0.99];
	_vcl setfuel (_fuel - 0.0003);
	//player groupChat format["_fuel = %1", _fuel];
	false
};

keyboard_vehicle_interact_handler = {
	[] call interaction_handle;
};

keyboard_cop_speed_gun_handler = {
	if(!INV_shortcuts) exitWith {false};
	if (not(iscop or isopf or vehicleVarName player in pmcslots)) exitWith {false};
	SG_ON = !SG_ON;
	if (SG_ON) then
	{
		[] spawn speedgun_run;
	};
	true
};

keyboard_overlapping_actions = ["LeanLeft", "LeanLeftToggle", "LeanRight",  "LeanRightToggle"];
keyboard_overlapping_keys = [];
{
	private["_action"];
	_action = _x;
	keyboard_overlapping_keys = keyboard_overlapping_keys + (actionKeys _action);
} foreach keyboard_overlapping_actions;

keyboard_adminCheck = {(_this select 0) == DIK_F7};


KeyUp_handler = {
	private["_handled", "_disp", "_key", "_shift", "_ctrl", "_alt"];

	_disp	= _this select 0;
	_key    = _this select 1;
	_shift  = _this select 2;
	_ctrl	= _this select 3;
	_alt	= _this select 4;

	afkTime = time;

	_handled = false;

	if (_key in(actionKeys "LookAround")) then {
		lookingAround = false;
	};

	if ((call keyboard_stunned_check) || (call keyboard_restrained_check) && !([_key] call keyboard_adminCheck)) exitWith {
		not(_key in (call keyboard_get_stunned_allowed_keys))
	};
	if (call keyboard_agony_check && !([_key] call keyboard_adminCheck)) exitwith {
		!(_key in (call keyboard_get_agony_allowed_keys))
	};


	if ((animationState player) == "shaftoe_c0briefing_otazky_loop6") then {
		player setPosATL (player getVariable "animation_position");
	};

	private["_inVehicle"];
	_inVehicle = ((vehicle player) != player);

	switch _key do {

		case DIK_Y: {
			if (([player] call player_get_arrest) or ([player] call player_get_mp_arrest)) exitWith {};
			_handled = [] call keyboard_animation_handler;
		};
		case DIK_F5: {
			_handled = [] call keyboard_tlr_keys_handler;
		};

		case DIK_DELETE:
		{
			_message = format ["%1 pressed the delete key.",name player];
			[_message, "Key Press"] call mp_log;
			if (!isstaff or ismod) exitwith {_handled = false;};
			_target = cursortarget;
			_var = _target getVariable ["nodelete",false];
			if not(_var) then {
				deleteVehicle cursorTarget;
			};
			_message = format["%1 deleted %2",(name player), _target];
			[_message, "Admin"] call mp_log;
			_handled = true;
		};


		case DIK_F8:
		{
			_handled = [] call hud_key_handle;
		};

		case DIK_T: {
			_handled = [] call keyboard_trunk_handler;
		};
		
		case DIK_O:
		{
			_handled = [] call gate_control;
		};		
		case DIK_E: {

			if (
				([player,"restrained"] call player_get_bool) or
				([player,"ziptied"] call player_get_bool) or
				([player] call player_get_arrest) or
				([player] call player_get_mp_arrest) or
				([player] call player_vulnerable)
			) exitWith {systemChat "You cannot do that right now."};

			if (player call unit_unmoveable) exitwith {};


			_handled = [_ctrl] call keyboard_interact_handler;
				
		};
		
		case DIK_V:
		{
			if (toLower (animationstate player) in [toLower "HaloFreeFall_FR",toLower "HaloFreeFall_FB",toLower "HaloFreeFall_BR",toLower "HaloFreeFall_BL",toLower "HaloFreeFall_non"]) then {
				[player] call halo_open_parachute;
			};
		};
		
		case DIK_GRAVE: {
			closedialog 0;
			_handled = [] call phone_open;
		};

		case DIK_1: {
			closedialog 0;
			_handled = [] call phone_open;
		};
		case DIK_2: {
			closedialog 0;
			_handled = [] call phone_open;
		};
		case DIK_3: {
			if (_inVehicle) exitWith {_handled=false;};
			_handled = [] call keyboard_surrender_handler;
		};
		case DIK_4: {

			if (iscop) then { _handle = createdialog "bait_car_dialog"};

		};
		case DIK_5: {
			closedialog 0;
			_handled = [] call phone_open;
		};

		case DIK_F6:	
		{
			[] spawn {
				if !(isStaff) exitWith {};
				if (esp_loop_toggle) exitWith {};
				_message = format ["%1 used temp esp.",name player];
				[_message, "Admin"] call mp_log;
				player groupChat "TEMP ESP ACTIVATED";
				player setVariable ["tempesp",true,true];
				[] spawn admin_temp_esp_activate;
				
				uiSleep 5;
				player groupChat "TEMP ESP DEACTIVATED";
				esp_loop_toggle = false;
				setGroupIconsVisible [false, false];
				player setVariable ["tempesp",false,true];
			};	
		};
			
		case DIK_SPACE:	{
			if (not(_ctrl)) exitWith {_handled = false;};
			
			if (_ctrl) then {
				_handled = [] call keyboard_lock_unlock_handler;
			};
		};
	};
	if (_inVehicle && _key == DIK_E) exitWith {
		_inVehicle
	};

	if (_key in keyboard_overlapping_keys) exitWith {
		false;
	};

	_handled
};



lookingAround = false;
KeyDown_handler = {
	[] call button_pressed_evnt;
	//player groupChat format["KeyDown_handler %1", _this];
	private["_handled"];
	_handled = false;

	_disp	= _this select 0;
	_key    = _this select 1;
	_shift  = _this select 2;
	_ctrl	= _this select 3;
	_alt	= _this select 4;


	if (_key in(actionKeys "LookAround")) then {
		lookingAround = true;
	};


	if ((call keyboard_stunned_check) || (call keyboard_restrained_check)) exitWith {
		not(_key in (call keyboard_get_stunned_allowed_keys))
	};

	if (call keyboard_agony_check) exitwith {
		!(_key in (call keyboard_get_agony_allowed_keys))
	};

	//Fix for exploit using cross-arms animation, that allows players to glitch through walls
	if ((animationState player) == "shaftoe_c0briefing_otazky_loop6") then {
		player setPosATL (player getVariable "animation_position");
	};

	private["_inVehicle", "_isDriver"];
	_inVehicle = ((vehicle player) != player);
	_isDriver = ((driver (vehicle player)) == player);

	switch _key do {
		case DIK_ESCAPE: {
			["all"] call RG_fnc_iSave;
			_message = format ["%1 pressed the ESCAPE key!",name player];
			[] spawn abort_timer;
			[_message,"Keypress"] call mp_log;
		};
		case DIK_Y: {
			_handled = INV_shortcuts;
		};
		case DIK_TAB: {
			_handled = INV_shortcuts;
		};
		case DIK_T: {
			_handled = INV_shortcuts;
		};
		case DIK_E: {
			_handled = INV_shortcuts;
		};
		case DIK_GRAVE: {
			_handled = INV_shortcuts;
		};
		case DIK_1: {
			_handled = INV_shortcuts;
		};
		case DIK_2: {
			_handled = INV_shortcuts;
		};
		case DIK_3: {
			_handled = INV_shortcuts;
		};
		case DIK_4: {
			_handled = INV_shortcuts;
		};
		case DIK_5: {
			_handled = INV_shortcuts;
		};
		case DIK_6: {
			_handled = [] call dispatch_handler;
		};
		case DIK_F4: {
			if (_alt) then {
				_message = format ["%1 pressed ALT + F4", name player];
				[_message,"Keypress"] call mp_log;
			};
		};
		case DIK_U:{
			_handled = [] call keyboard_admin_menu_handler;
		};
		
		case DIK_F1:
		{
			if( isDeveloper ) then
			{
				[] call dev_console_open;
			};
			
			_handled = true;
		};

		case DIK_L:	{
				_handled = [] call keyboard_lock_unlock_handler;
		};

		case DIK_F: {
			if (not(_ctrl)) exitWith {_handled = false;};

			if (_inVehicle) then {
				_handled = [] call keyboard_siren_handler;
			}
			else { if (not(_inVehicle)) then{
				_handled = [] call keyboard_stun_handler;
			};};
		};

		case DIK_G: {
			if (not(_ctrl)) exitWith {_handled = false;};
			if (not((iscop or isopf or vehicleVarName player in pmcslots) && _inVehicle && _isDriver)) exitWith {_handled = false;};
			_handled = [] call keyboard_cop_speed_gun_handler;
		};

		case DIK_H: {
			if not((_ctrl) or (_shift)) exitWith {_handled = false;};

			if (_ctrl) exitWith {
				if (not((iscop or isopf or isesu)  && _inVehicle && _isDriver)) exitWith {_handled = false;};
				_handled = [] call keyboard_cop_horn_handler;
			};

			if (_shift) exitWith {
				if (not((iscop or isopf)  && _inVehicle && _isDriver)) exitWith {_handled = false;};
				_handled = [] call keyboard_cop_horn_change_handler;
			};
		};

		case DIK_W: {
			if(!_inVehicle) exitWith { false };
			_handled = [] call keyboard_forward_tuning_handler;
		};
		
		case DIK_Z: {
			if ((vehicle player == player) && (iscop or isopf)) then {
				if !(diving) then {
					if (speed player >= 18) then {
						[] spawn player_dive;
					};
				};
			};
		};

		case DIK_LSHIFT: {
			if(!_inVehicle) exitWith { false };
			_handled = [] call keyboard_vehicle_nitro_handler;
		};		
		case DIK_LWIN: {
			if(_inVehicle) exitWith { false };
			_handled = [] call keyboard_vehicle_interact_handler;
		};
	};


	if (_inVehicle && _key == DIK_E) exitWith {
		_inVehicle
	};

	if (_key in keyboard_overlapping_keys) exitWith {
		false;
	};

	_handled
};


keyboard_setup = {
	disableSerialization;
	private["_display"];
	_display = nil;
	waituntil {
		_display = findDisplay 46;
		if (isNil "_display") exitWith {false};
		if (isNull _display) exitWith {false};
		true
	};
	_display displaySetEventHandler ["KeyDown", "_this call KeyDown_handler"];
	_display displaySetEventHandler ["KeyUp", "_this call KeyUp_handler"];
};

call keyboard_setup;
