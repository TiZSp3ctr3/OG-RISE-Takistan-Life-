mp_group_chat_message =
{
	_message = _this select 0;
	player groupchat _message;
};

mp_remote_code = {
	_code = _this select 0;
	if (isNil "_code") exitWith {};
	
	[] spawn compile _code;
};
mp_framework_init_fnc = {
	mp_framework_init_complete = true;
};

mp_play_sound =
{
	_source = _this select 0;
	_distance = _this select 1;
	_sound = _this select 2;
	
	if (player distance _source <= _distance) then {
		_source say3D _sound;
	};
};
mp_side_chat_message =
{
	_message = _this select 0;
	player sideChat _message;
};

mp_global_chat_message =
{
	_message = _this select 0;
	server globalchat _message;
};

mp_esu_message =
{
	if !(isesu) exitWith {};
	_message = _this select 0;
	server globalchat _message;
	titleText [format["%1", _message], "PLAIN DOWN"];
};

mp_server_message =
{
	_message = _this select 0;
	server globalchat _message;
	titleText [format["%1", _message], "PLAIN DOWN"];
};
mp_hint =
{
	_text = _this select 0;
	hint _text;
};
mp_anim_sync =
{
	private ["_unit","_mode","_animation"];
	_unit = _this select 0;
	_mode = _this select 1;
	_animation = _this select 2;

	if (_mode == "switchmove") then {_unit switchMove _animation};
	if (_mode == "playmove") then {_unit playmove _animation};
};

mp_compile_code =
{	
	
	_code = _this select 0;
	call compile _code;
};

mp_screen_message =
{
	_message = _this select 0;
	titleText [format["%1", _message], "PLAIN DOWN"];
};


mp_start_force_ts =
{
	player enablesimulation false;
	Invulnerability = true;
	blackscreen = true;
	titletext ["You are required to join our teamspeak server! The address is TS3.RISE-GAMING.COM", "black"];
};

mp_stop_force_ts =
{
	player enablesimulation true;
	Invulnerability = false;
	blackscreen = false;
	titletext ["", "PLAIN DOWN", 0];
};


mp_staff_init =
{
	_staff_level = _this select 0;
	switch (_staff_level) do
	{
		case "dev": {
		isdeveloper = true;
			if !(donator2 || donator3 || donator4 || isvip) then {
				isdon = true;
				donator1 = true;
				startmoneh = 550000;
			};
		};
		case "snadmin": {
		issnadmin = true;
			if !(donator2 || donator3 || donator4 || isvip) then {
				isdon = true;
				donator1 = true;
				startmoneh = 550000;
			};
		};
		case "admin": {
		isadmin = true;
			if !(donator2 || donator3 || donator4 || isvip) then {
				isdon = true;
				donator1 = true;
				startmoneh = 550000;
			};
		};
		case "mod": {
		ismod = true;
			if !(donator2 || donator3 || donator4 || isvip) then {
				isdon = true;
				donator1 = true;
				startmoneh = 550000;
			};
		};
		case "tsh": {
			istsh = true;
			if !(donator2 || donator3 || donator4 || isvip) then {
				isdon = true;
				donator1 = true;
				startmoneh = 550000;
			};
		};
		default {};
	};
	isstaff = (isdeveloper or issnadmin or isadmin or ismod);
	if (isstaff) then {osf=true; srt=true;pmc=true;vice=true;
		_message = format ["%1 logged onto the server",name player];
		[_message, "Admin Login"] call mp_log;
	};
	if((_slot in adminslots) && not(isStaff)) then {   player groupChat "You are not in the whitelist for this slot."; uiSleep 8; failMission "END1";};
};

mp_pmc_init =
{
	_pmc = _this select 0;
	switch (_pmc) do
	{
		case "pmc": {pmc = true;};
		default {};
	};
};
mp_srt_init =
{
	_srt = _this select 0;
	switch (_srt) do
	{
		case "srt": {srt = true;};
		default {};
	};
};
mp_supervisor_init =
{
	_super = _this select 0;
	switch (_super) do
	{
		case "true": {supervisor = true;};
		default {};
	};
};
mp_osf_init =
{
	_osf = _this select 0;
	switch (_osf) do
	{
		case "osf": {osf = true;};
		default {};
	};
};
mp_vice_init =
{
	_vice = _this select 0;
	switch (_vice) do
	{
		case "vice": {vice = true;};
		default {};
	};
};
mp_donor_init =
{
	_donor = _this select 0;
	switch (_donor) do
	{
		case "1": {isdon = true; donator1 = true;
			startmoneh = 550000;
		};
		case "2": {isdon = true; donator2 = true;
			startmoneh = 600000;
			INV_CarryingCapacity = 100;
			INV_CarryingCapacityOld = 100;
		};
		case "3": {isdon = true; donator3 = true;
			startmoneh = 750000;
			INV_CarryingCapacity = 200;
			INV_CarryingCapacityOld = 200;
		};
		case "4": {isdon = true; donator4 = true;
			INV_CarryingCapacity = 300;
			INV_CarryingCapacityOld = 300;
			startmoneh = 1000000;
		};
		case "vip": {isdon = true; isvip = true;
			startmoneh = 1500000;
			INV_CarryingCapacity = 500;
			INV_CarryingCapacityOld = 500;
		};
		default {};
	};
};


mp_blacklist_init =
{
	blacklists = _this;
	
	_cop = blacklists select 0;
	_opf = blacklists select 1;
	_indy = blacklists select 2;
	_civ = blacklists select 3;
	
	if (_cop and playerSide == west) then {player groupChat "You are blacklisted from this faction"; uiSleep 2; failMission "END1"};
	if (_opf and playerSide == east) then {player groupChat "You are blacklisted from this faction"; uiSleep 2; failMission "END1"};
	if (_indy and playerSide == resistance) then {player groupChat "You are blacklisted from this faction"; uiSleep 2; failMission "END1"};
	if (_civ and playerSide == civilian) then {player groupChat "You are blacklisted from this faction"; uiSleep 2; failMission "END1"};
	
};
mp_online_during_hacker = {

	online_during_hacker = online_during_hacker + 1;
	[format ["%1_persistent",getplayeruid player], format ["%1_persistent",getplayeruid player], "online_during_hacker", online_during_hacker] call fn_SaveToServer;
	
};
mp_admin_query = {
	_sender = _this select 0;
	_name = name player;
	_uid = getplayeruid player;
	_info = [_name,_uid, player];
	_time =  player_playtime;
	_logins = player_logins;
	_hackings = online_during_hacker;
	_totaltime = player_total_playtime;
	_bankaccount = [player] call get_dynamiccuntflap; 
	_cash = [player, "money"] call INV_GetItemAmount;
	_weapons = weapons player;
	_donor = isdon;
	_vip = isvip;
	_vice = vice;
	_srt = srt;
	_osf = osf;
	_rank = player_rank;
	
	_flags = 0;
	
	// stuff to send to admin
	// play time - Money - Weapons - Login Times - Red Flags - Staff Var -
	
	if (_logins < 15) then {
		_flags = _flags + 1;
	};
	
	if (_time <= 3600) then {
		_flags = _flags + 1;
	};
	
	if (_hackings >= 2) then {
		_flags = _flags + 1;
	};	
	
	if (_totaltime <= 7200) then {
		_flags = _flags + 1;
	};
	

	_info2 = [_info,[_time,_logins,isStaff,_flags,_hackings,_totaltime,_bankaccount,_cash,_weapons,_donor,_vip,_vice,_srt,_osf,_rank]];
	[[_sender],"mp_admin_query_response",[_info2]] call mp_aware_me;

};

mp_admin_query_response = {
	_input = _this select 0;
	if (typeName _input != "ARRAY") exitWith {};
	
	_basic = _input select 0;
	_advanced = _input select 1;
	
	
	_name = _basic select 0;
	_uid = _basic select 1;
	_player = _basic select 2;
	
	diag_log _input;
	call compile format ['
		admin_query_response_%1 = %2;
		systemChat "Response Received from %3";
	',_player,_input,_name];

	
};
mp_admin_notify = {
	
	if (!isStaff) exitWith {};
	
	_string = _this select 0;
	
	hint _string;
	systemChat _string;
	titletext [_string, "PLAIN DOWN"];
};

mp_admin_query_refresh = {

	disableSerialization;
	_dialog = findDisplay 2200;
	_list = _dialog displayCtrl 1400;
	_text = _dialog displayCtrl 1000;

	_info = _list lbData (lbCurSel _list);
	_info = call compile _info;
	
	_basic = _info select 0;
	_advanced = _info select 1;
		
	_name = _basic select 0;
	_uid = _basic select 1;
	_unit = _basic select 2;
	
	if (isNil "_unit") then {_unit = "No Unit / Respawing"};
	
	_playtime =  _advanced select 0;
	_logins = _advanced select 1;
	_staff = _advanced select 2;
	_flags = _advanced select 3;
	_hackings = _advanced select 4;
	_totaltime = _advanced select 5;
	_bankaccount = _advanced select 6;
	_cash = _advanced select 7;
	_weapons = _advanced select 8;
	_donor = _advanced select 9;
	_vip = _advanced select 10;
	_vice = _advanced select 11;
	_srt = _advanced select 12;
	_osf = _advanced select 13;
	_rank = _advanced select 14;
	
	
	_text ctrlSetStructuredText parseText format ["
			<t align='left' font='Zeppelin32' size='1'>Player NAME: %1 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>Player UID: %2 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>Player UNIT: %3 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>Player PLAYTIME: %4 (mins) </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>Player TOTAL PLAYTIME: %5 (mins) </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>Player LOGINS: %6 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>Player STAFF: %7 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>Player FLAGS: %8 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>Player Online During Hacker Count: %9 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>BANK: $%10 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>CASH: $%11 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>WEAPONS: %12 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>DONOR: %13 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>VIP: %14 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>VICE: %15 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>SRT: %16 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>OSF: %17 </t> <br/>
			<t align='left' font='Zeppelin32' size='1'>RANK: %18 </t> <br/>
		",_name,_uid,_unit,
		round (_playtime / 60),
		round (_totaltime / 60),
		_logins,
		_staff,
		_flags,
		_hackings,
		[_bankaccount, ","] call format_integer,
		[_cash, ","] call format_integer,
		_weapons,
		_donor,
		_vip,
		_vice,
		_srt,
		_osf,
		_rank
	];
};
mp_admin_query_dump = {
	{
		_var = call compile format ["admin_query_response_%1",_x];
		if !(isNil "_var") then {
			diag_log format ["ADMIN QUERY: %1",_var];
			player groupChat format ["ADMIN QUERY: %1",_var];
		};
	} foreach playerstringarray;
};

mp_admin_query_open = {

	if !(createDialog "player_query_dialog") exitWith {hint "Dialog Error"};
	{
		call compile format ['
			disableSerialization;
			
			if !(isNil "admin_query_response_%1") then {
				_dialog = findDisplay 2200;
				_list = _dialog displayCtrl 1400;
				_text = _dialog displayCtrl 1000;
				
				_info = admin_query_response_%1;
				_basic = admin_query_response_%1 select 0;
				_advanced = admin_query_response_%1 select 1;
				
				_name = _basic select 0;
				_uid = _basic select 1;
				_unit = _basic select 2;
				
				_playtime =  _advanced select 0;
				_logins = _advanced select 1;
				_staff = _advanced select 2;
				_flags = _advanced select 3;
									
				_index = _list lbAdd _name;
				_list lbSetData [_index,"admin_query_response_%1"];
				
				
				if (_flags == 0) then {
					_list lbSetColor [_index, [0, 1, 0, 1]]; 
				};	
				if (_flags >= 1) then {
					_list lbSetColor [_index, [1, 1, 0, 1]];
				};	
				
				if (_flags >= 2) then {
					_list lbSetColor [_index, [1, 0.2, 0, 1]];
				};	
				
				if (_flags >= 3) then {
					_list lbSetColor [_index, [1, 0, 0, 1]];
				};
			};
			
		',_x];
	} foreach playerstringarray;
};

mp_system_chat_message =
{
	_message = _this select 0;
	systemChat _message;
};