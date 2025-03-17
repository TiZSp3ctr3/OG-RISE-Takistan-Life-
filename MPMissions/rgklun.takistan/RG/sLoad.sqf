//===========================================================================
_loadFromDBClient =
"
	_array = _this;
	_uid = _array select 0;
	_uid_persist = format ['%1_persistent',getplayeruid player];
	
	if ((_uid != getplayeruid player) and (_uid != _uid_persist)) exitWith {};
	
	_varName = _array select 1;
	_varValue = _array select 2;
	if(isNil '_varValue') exitWith {};
	diag_log format['STAT INFO -> UID: %1 - VARNAME: %2 - VARVALUE: %3',_uid,_varName,_varValue];

	if (isNil 'iscop' or isNil 'isopf' or isNil 'isins' or isNil 'isciv' or isNil 'isesu') exitWith {};
	
	if(iscop) then
	{
		if(_varName == 'moneyAccountWest') then {[player, _varValue] call set_dynamiccuntflap;};
		if(_varName == 'WeaponsplayerWest') then {{player addWeapon _x} forEach _varValue;};
		if(_varName == 'MagazinesplayerWest') then {{player addMagazine _x} forEach _varValue;};
		if(_varName == 'backpack_west') then {[player,_varValue] call player_set_backpack_gear};
		if(_varName == 'LicensesWest') then {INV_LicenseOwner = _varValue;};
		if(_varName == 'InventoryWest') then {[player, _varValue] call player_set_inventory;};
		if(_varName == 'privateStorageWest') then {[player,'private_storage', _varValue] call player_set_array;};
		if(_varName == 'FactoryWest') then {INV_Fabrikowner = _varValue;};
		if(_varName == 'HolsterSMG_West') then {INV_InventarSmg = _varValue};
		if(_varName == 'HolsterPistol_West') then {INV_InventarPistol = _varValue};
		if(_varName == 'LockedPack_West') then {backpack_gear = _varValue; if (count backpack_gear > 0) then {backpack_locked = true};};
		if(_varName == 'rank_west') then {player setVariable ['faction_rank',_varValue,true]; player_rank = _varValue};
		if(_varName == 'JailTime') then {player_jailtime = _varValue;};
		if(_varName == 'police_agreement') then {call compile format ['police_agreement = %1',_varValue];};
		if(_varName == 'player_certified_west') then {call compile format ['player_certified = %1',_varValue];};
	};
	if(isopf) then
	{
		if(_varName == 'moneyAccountEast') then {[player, _varValue] call set_dynamiccuntflap;};
		if(_varName == 'LicensesEast') then {INV_LicenseOwner = _varValue;};
		if(_varName == 'InventoryEast') then {[player, _varValue] call player_set_inventory;};
		if(_varName == 'WeaponsplayerEast') then {{player addWeapon _x} forEach _varValue;};
		if(_varName == 'MagazinesplayerEast') then {{player addMagazine _x} forEach _varValue;};
		if(_varName == 'backpack_east') then {[player,_varValue] call player_set_backpack_gear};
		if(_varName == 'privateStorageEast') then {[player, 'private_storage', _varValue] call player_set_array;};
		if(_varName == 'FactoryEast') then {INV_Fabrikowner = _varValue;};
		if(_varName == 'HolsterSMG_East') then {INV_InventarSmg = _varValue;};
		if(_varName == 'HolsterPistol_East') then {INV_InventarPistol = _varValue;};
		if(_varName == 'LockedPack_East') then {backpack_gear = _varValue; if (count backpack_gear > 0) then {backpack_locked = true};};
		if(_varName == 'rank_east') then {player setVariable ['faction_rank',_varValue,true]; player_rank = _varValue};
		if(_varName == 'JailTime') then {player_jailtime = _varValue;};
	};
	if(isins) then
	{
		if(_varName == 'moneyAccountRes') then {[player, _varValue] call set_dynamiccuntflap;};
		if(_varName == 'WeaponsplayerRes') then {{player addWeapon _x} forEach _varValue;};
		if(_varName == 'MagazinesplayerRes') then {{player addMagazine _x} forEach _varValue;};
		if(_varName == 'backpack_un') then {[player,_varValue] call player_set_backpack_gear};
		if(_varName == 'LicensesRes') then {INV_LicenseOwner = _varValue;};
		if(_varName == 'InventoryRes') then {[player, _varValue] call player_set_inventory;};
		if(_varName == 'privateStorageRes') then {[player, 'private_storage', _varValue] call player_set_array;};
		if(_varName == 'FactoryRes') then {INV_Fabrikowner = _varValue;};
		if(_varName == 'HolsterSMG_Res') then {INV_InventarSmg = _varValue;};
		if(_varName == 'HolsterPistol_Res') then {INV_InventarPistol = _varValue;};
		if(_varName == 'LockedPack_Res') then {backpack_gear = _varValue; if (count backpack_gear > 0) then {backpack_locked = true};};
		if(_varName == 'rank_un') then {player setVariable ['faction_rank',_varValue,true]; player_rank = _varValue};
		if(_varName == 'JailTime') then {player_jailtime = _varValue;};
	};
	if(isciv or isesu) then
	{
		if(_varName == 'moneyAccountCiv') then {[player, _varValue] call set_dynamiccuntflap;};
		if(_varName == 'WeaponsplayerCiv') then {{player addWeapon _x} forEach _varValue;};
		if(_varName == 'MagazinesplayerCiv') then {{player addMagazine _x} forEach _varValue;};
		if(_varName == 'backpack_civ') then {[player,_varValue] call player_set_backpack_gear};
		if(_varName == 'LicensesCiv') then {INV_LicenseOwner = _varValue;};
		if(_varName == 'InventoryCiv') then {[player, _varValue] call player_set_inventory;};
	    if(_varName == 'privateStorageCiv') then {[player, 'private_storage', _varValue] call player_set_array;};
		if(_varName == 'Fabrikablage1_storage') then {[player,'Fabrikablage1', _varValue] call player_set_array;};
		if(_varName == 'AircraftFactory1_storage') then {[player,'AircraftFactory1', _varValue] call player_set_array;};
		if(_varName == 'Fabrikablage3_storage') then {[player,'Fabrikablage3', _varValue] call player_set_array;};
		if(_varName == 'Fabrikablage4_storage') then {[player,'Fabrikablage4', _varValue] call player_set_array;};
		if(_varName == 'FactoryCiv') then {INV_Fabrikowner = _varValue;};
		if(_varName == 'HolsterSMG_Civ') then {INV_InventarSmg = _varValue;};
		if(_varName == 'HolsterPistol_Civ') then {INV_InventarPistol = _varValue;};
		if(_varName == 'JailTime') then {player_jailtime = _varValue;};
		if(_varName == 'WarrantsCiv') then {[_varValue] call player_load_warrants;};
		if(_varName == 'rank_esu') then {player setVariable ['faction_rank',_varValue,true]; player_rank = _varValue};
		
		
	};
	
	if(_varName == 'shares') then {[_varValue] call stocks_load};
	if(_varName == 'logins') then {player_logins = _varValue};
	if(_varName == 'player_total_playtime') then {player_total_playtime = _varValue};
	if(_varName == 'online_during_hacker') then {online_during_hacker = _varValue};
	if(_varName == 'suspended_west') then {call compile format ['player_suspended = %1',_varValue];};
	if(_varName == 'suspended_time_west') then {player_suspended_time = _varValue};
";

loadFromDBClient = compile _loadFromDBClient;
//===========================================================================
_sendToServer =
"
	accountToServerLoad = _this;
	publicVariableServer 'accountToServerLoad';
";

sendToServer = compile _sendToServer;
//===========================================================================
"accountToClient" addPublicVariableEventHandler
{
	(_this select 1) spawn loadFromDBClient;
};
//===========================================================================

statFunctionsLoaded = 1;
