if (not(isNil "holster_functions_defined")) exitWith {};

holster_actions = [];

holster_pistol_in_hands = {
	([(currentWeapon player), "PistolCore"] call shop_weapon_inherits_from)
};

holster_smg_in_hands = {
	_weaponClass = currentWeapon player; 
	if !( _weaponClass in smg_array ) exitWith {false};
	true
};

holster_pistol_in_inventory =  {
	(([player, "pistol"] call INV_GetItemAmount) > 0)
};

holster_smg_in_inventory =  {
	(([player, "smg"] call INV_GetItemAmount) > 0)
};

holster_add_actions = {

	private["_holster_action", "_unholster_action"];
	
	_holster_action = player addAction ["Holster pistol", "noscript.sqf", format['[%1] call holster_hide_weapon;', player], 10, false, true,"", '_in_hands = (call holster_pistol_in_hands); _in_inv = (call holster_pistol_in_inventory); _in_hands && not(_in_inv)'];
	_unholster_action = player addAction ["Unholster pistol", "noscript.sqf", format['[%1] call holster_show_weapon;', player], 10, false, true,"", '_in_hands = (call holster_pistol_in_hands); _in_inv = (call holster_pistol_in_inventory); not(_in_hands) && _in_inv'];
	
	// SMG
	_holster_action_smg = player addAction ["Holster SMG", "noscript.sqf", format['[%1] call holster_hide_weapon_smg;', player], 10, false, true,"", '_in_hands = (call holster_smg_in_hands); _in_inv = (call holster_smg_in_inventory); _in_hands && not(_in_inv)'];
	_unholster_action_smg = player addAction ["Unholster SMG", "noscript.sqf", format['[%1] call holster_show_weapon_smg;', player], 10, false, true,"", '_in_hands = (call holster_smg_in_hands); _in_inv = (call holster_smg_in_inventory); not(_in_hands) && _in_inv'];

	
	holster_actions = [_holster_action, _unholster_action,_unholster_action_smg,_holster_action_smg];
};

holster_remove_actions = {	
	{	
		private["_action_id"];
		_action_id = _x;
		player removeAction _action_id;
	} forEach holster_actions;
};

holster_hide_weapon = {	
	if (not(call holster_pistol_in_hands)) exitWith {
		player groupChat format["You have no pistol in your hands to holster"];
	};
	
	if ((call holster_pistol_in_inventory)) exitWith {
		player groupChat format["You already have a pistol in your inventory"];
	};
	
	INV_InventarPistol = currentWeapon(player);
	player removeWeapon INV_InventarPistol;
	[player, 'pistol', 1] call INV_SetItemAmount;
};

holster_hide_weapon_smg = {	
	if (not(call holster_smg_in_hands)) exitWith {
		player groupChat format["You have no smgs in your hands to holster"];
	};
	
	if ((call holster_smg_in_inventory)) exitWith {
		player groupChat format["You already have a pistol in your inventory"];
	};
	
	INV_InventarSmg = currentWeapon(player);
	player removeWeapon INV_InventarSmg;
	[player, 'smg', 1] call INV_SetItemAmount;
};

holster_show_weapon = {
	if (not(call holster_pistol_in_inventory)) exitWith {
		player groupChat format["You have no pistol in your inventory"];
		INV_InventarPistol = "";
	};
	
	if (call holster_pistol_in_hands) exitWith {
		player groupChat format["Cannot unholster inventory pistol, you already have a pistol in your hands"];
	};

	
	if (isNil "INV_InventarPistol") exitWith {
		player groupChat format["The type of pistol in your inventory is unknown, removing it"];
		[player, 'pistol', 0] call INV_SetItemAmount;
	};
	
	
	if (INV_InventarPistol == "") exitWith {};
	
	if ((currentWeapon player != primaryWeapon player) and (currentWeapon player != "")) then {
		_holder = createVehicle ["weaponholder", (getPosATL player), [], 0, "NONE"];
		_pos = [ (getPosATL player) select 0, (getPosATL player) select 1, ((getPosATL player) select 2) + 0.05 ];
		_holder setPosATL _pos;
		_holder addWeaponCargoGlobal [currentWeapon player, 1];
		player removeWeapon (currentWeapon player);
	};
	
	player addWeapon INV_InventarPistol;
	player selectWeapon INV_InventarPistol;
	[player, 'pistol', 0] call INV_SetItemAmount;
	INV_InventarPistol = "";
	player action ["switchweapon", player, player, 0];
	
};

holster_show_weapon_smg = {
	if (not(call holster_smg_in_inventory)) exitWith {
		player groupChat format["You have no smg in your inventory"];
		INV_InventarSmg = "";
	};
	
	if (call holster_smg_in_hands) exitWith {
		player groupChat format["Cannot unholster inventory smg, you already have a smg in your hands"];
	};
	
	if (isNil "INV_InventarSmg") exitWith {
		player groupChat format["The type of pistol in your inventory is unknown, removing it"];
		[player, 'smg', 0] call INV_SetItemAmount;
	};
	
	if (INV_InventarSmg == "") exitWith {};
	
	if (primaryWeapon player != "") then {
		_holder = createVehicle ["weaponholder", (getPosATL player), [], 0, "NONE"];
		_pos = [ (getPosATL player) select 0, (getPosATL player) select 1, ((getPosATL player) select 2) + 0.05 ];
		_holder setPosATL _pos;
		_holder addWeaponCargoGlobal [primaryWeapon player, 1];
		player removeWeapon (primaryWeapon player);
	};
	
	
	player addWeapon INV_InventarSmg;
	player selectWeapon INV_InventarSmg;
	[player, 'smg', 0] call INV_SetItemAmount;
	INV_InventarSmg = "";
	player action ["switchweapon", player, player, 0];
};


holster_functions_defined = false;