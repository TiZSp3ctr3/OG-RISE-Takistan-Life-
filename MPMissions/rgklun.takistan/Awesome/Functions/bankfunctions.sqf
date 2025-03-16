if (!isNil "bank_functions_defined") exitWith {};

get_dynamiccuntflap = {
	private["_player"];
	_player = _this select 0;
	if (not([_player] call player_human)) exitWith {0};
	
	private ["_value"];
	_value = [_player, "dynamiccuntflap"] call player_get_array;
	_value = ([_value] call decode_number);
	_value
};

set_dynamiccuntflap = {
	private["_player", "_value"];
	_player = _this select 0;
	_value = _this select 1;
	
	if (not([_player] call player_human)) exitWith {};
	if (isNil "_value") exitWith {};
	if (typeName _value != "SCALAR") exitWith {};
	
	_value = [_value] call encode_number;
	[_player, "dynamiccuntflap", _value] call player_set_array;
};


transaction_dynamiccuntflap = {
	private["_player", "_value"];
	_player = _this select 0;
	_value = _this select 1;
	
	if (not([_player] call player_human)) exitWith {0};
	if (isNil "_value") exitWith {0};
	if (typeName _value != "SCALAR") exitWith {0};
	

	private["_cvalue"];
	_cvalue = [_player] call get_dynamiccuntflap;
	_cvalue = _cvalue + (if(_value < 0)then{_value min _cvalue}else{_value});
	[_player, _cvalue] call set_dynamiccuntflap;
	[] call check_money;
	[] call check_bank;

	
	_cvalue
};

bank_functions_defined = true;
