INV_MAX_ITEMS           = 1000000;
INV_MAX_DROPS	 		= 300;
INV_shortcuts           = true;
INV_SperrenVerbotArray  = [[copbase1, 250],[mosqueprop, 120] , [asairspawn, 30], [airfacspawn, 30],[redhelispawn, 100],[CopPrisonAusgang, 20]];

_handler = [] execVM "INVfunctions.sqf";
waitUntil {scriptDone _handler};
_handler = [] execVM "createfunctions.sqf";
waitUntil {scriptDone _handler};
_handler = [] execVM "carparks.sqf";
waitUntil {scriptDone _handler};
_handler = [] execVM "masterarray.sqf";
waitUntil {scriptDone _handler};
_handler = [] execVM "Awesome\Scripts\optimize_2.sqf";
waitUntil {scriptDone _handler};
_handler = [] execVM "Awesome\Scripts\shops.sqf";
waitUntil {scriptDone _handler};
_handler = [] execVM "Awesome\Shops\functions.sqf";
waitUntil {scriptDone _handler};
_handler = [] execVM "facharvest.sqf";
waitUntil {scriptDone _handler};
_handler = [] execVM "licensearray.sqf";
waitUntil {scriptDone _handler};

if (isClient) then {
	_handler = [] execVM "shopfarmfaclicenseactions.sqf";
};