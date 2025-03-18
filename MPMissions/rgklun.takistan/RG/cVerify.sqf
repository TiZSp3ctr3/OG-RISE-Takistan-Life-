/*
	cVerify.sqf
	[RISE] Sp3ctr3
	Verifies stat save exists and directs stat creation
*/ 

if (isNil "iscop" or isNil "isopf" or isNil "isins" or isNil "isciv" or isNil "isesu") exitWith {player groupChat "You are glitched. Stats will not be saved"};

titleText ["Verifying Stats","PLAIN"];
[format ["%1_persistent",(getPlayerUID player)], format ["%1_persistent",(getPlayerUID player)], "logins", "NUMBER", player] call sendToServer;

uiSleep 10;

if (statsVerified) then {
	titleText ["Stats Verified","PLAIN"];
	uiSleep 1;
	statsCreated = true;

} else {
	titleText ["Stats not verified","PLAIN"];
	uiSleep 1;
	[] execVM "RG\cCreateStats.sqf";
};

