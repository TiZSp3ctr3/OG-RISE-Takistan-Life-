
_vcl  = vehicle player;
if (isNil "HORN_Playing") then	{ HORN_Playing = false;	};
_class = typeOf (vehicle (player));
_isbike = (configName(inheritsFrom(inheritsFrom (configFile >> "CfgVehicles" >> _class))) == "Bicycle");
_isdriver = (player == (driver _vcl));

if (HORN_Playing || _isbike || !_isdriver) exitWith {};
HORN_Playing = true;

if (isesu) then {
	[[],"mp_play_sound",[_vcl,60,"esuairhorn"]] call mp_aware_me;
} else {
	[[],"mp_play_sound",[_vcl,60,current_horn]] call mp_aware_me;
};

uiSleep 2.5;
HORN_Playing = false;
