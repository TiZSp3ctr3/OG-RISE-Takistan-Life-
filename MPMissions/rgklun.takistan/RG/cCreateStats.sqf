/*
	cCreateStats.sqf
	[RISE] Sp3ctr3
	Creates default entries in stat database if they dont already exist
*/ 

titleText ["Creating Stats","PLAIN"];

[getPlayerUID player, getPlayerUID player, "moneyAccountWest", startmoney] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "backpack_west", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "WeaponsPlayerWest", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "MagazinesPlayerWest", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "LicensesWest", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "InventoryWest", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "privateStorageWest",[]] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "FactoryWest", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "HolsterSMG_West", ""] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "HolsterPistol_West", ""] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "LockedPack_West", []] call fn_SaveToServer;
			
[getPlayerUID player, getPlayerUID player, "moneyAccountEast", startmoney] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "backpack_east", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "WeaponsPlayerEast", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "MagazinesPlayerEast", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "LicensesEast", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "InventoryEast", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "privateStorageEast",[]] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "FactoryEast", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "HolsterSMG_East", ""] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "HolsterPistol_East", ""] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "LockedPack_East", []] call fn_SaveToServer;

[getPlayerUID player, getPlayerUID player, "moneyAccountRes", startmoney] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "backpack_un",[]] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "WeaponsPlayerRes", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "MagazinesPlayerRes", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "LicensesRes", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "InventoryRes", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "privateStorageRes",[]] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "FactoryRes", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "HolsterSMG_Res", ""] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "HolsterPistol_Res", ""] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "LockedPack_Res", []] call fn_SaveToServer;

[getPlayerUID player, getPlayerUID player, "moneyAccountCiv", startmoney] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "backpack_civ",[]] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "WeaponsPlayerCiv", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "MagazinesPlayerCiv", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "LicensesCiv", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "InventoryCiv", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "privateStorageCiv",[]] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "Fabrikablage1_storage", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "AircraftFactory1_storage", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "Fabrikablage3_storage", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "Fabrikablage4_storage", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "FactoryCiv", []] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "WarrantsCiv", [] call player_save_warrants] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "HolsterSMG_Civ", ""] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "HolsterPistol_Civ", ""] call fn_SaveToServer;
[getPlayerUID player, getPlayerUID player, "shares",[]] call fn_SaveToServer;

[format ["%1_persistent",getPlayerUID player],format ["%1_persistent",getPlayerUID player], "rank_un", 0] call fn_SaveToServer;
[format ["%1_persistent",getPlayerUID player], format ["%1_persistent",getPlayerUID player], "rank_esu", 0] call sendToServer;
[format ["%1_persistent",getPlayerUID player],format ["%1_persistent",getPlayerUID player], "player_total_playtime", 0] call fn_SaveToServer;
[format ["%1_persistent",getPlayerUID player], format ["%1_persistent",getPlayerUID player], "suspended_west",false] call fn_SaveToServer;
[format ["%1_persistent",getPlayerUID player], format ["%1_persistent",getPlayerUID player], "suspended_time_west",0] call fn_SaveToServer;
[format ["%1_persistent",getPlayerUID player], format ["%1_persistent",getPlayerUID player], "rank_east", 0] call fn_SaveToServer;
[format ["%1_persistent",getPlayerUID player], format ["%1_persistent",getPlayerUID player], "player_certified_west",false] call fn_SaveToServer;
[format ["%1_persistent",getPlayerUID player], format ["%1_persistent",getPlayerUID player], "rank_west",0] call fn_SaveToServer;

[format ["%1_persistent",getplayeruid player], format ["%1_persistent",getplayeruid player], "logins", 1] call fn_SaveToServer;
[format ["%1_persistent",getplayeruid player], format ["%1_persistent",getplayeruid player], "online_during_hacker", 0] call fn_SaveToServer;

uiSleep 2;
titleText ["Stats Created","PLAIN"];

statsVerified = true;
statsCreated = true;
