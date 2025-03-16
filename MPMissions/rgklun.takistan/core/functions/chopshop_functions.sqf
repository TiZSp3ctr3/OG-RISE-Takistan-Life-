
chop_shops = [chop_shop1,chop_shop2,chop_shop3,chop_shop4];
chop_wipe_cost = 7500;
chopshopcoef = 0.50;

// [] call open_chop_shop
open_chop_shop = {
	
	private ["_near"];
	_near = false;
	
	{
		if (player distance _x <= 10) then {
			_near = true;
		};
	} foreach chop_shops;
	
	if !(_near) exitWith {player groupChat "You are not near a chop shop"};
	
	_vehicles = nearestObjects [getposatl player,["Air","LandVehicle"], 10];
	if !(count _vehicles > 0) exitWith {player groupChat "No vehicles nearby"};

	
	disableSerialization;
	createDialog "chopshop";
	
	_display = findDisplay 1500;
	_list = _display displayCtrl 1501;
	_button = _display displayCtrl 1502;
	
	{
		_index = _list lbAdd format ["%1 (%2)",str(_x),[typeof _x] call ISSE_Cfg_VehicleName];
		_list lbSetData [_index,str(_x)];
	} foreach _vehicles;
};

chop_clear = {

	private ["_vehicle"];
	_vehicle = _this select 0;
	if (isNil "_vehicle") exitWith {};
	_vehicle = call compile format ["%1",_vehicle];
	if (isNull _vehicle) exitWith {player groupChat "No vehicle"};
	if (_vehicle distance player > 10) exitWith {player groupChat "Vehicle is too far away to chop"};
	
	if !([player,"money"] call INV_GetItemAmount >= chop_wipe_cost) exitWith {player groupChat "You do not have enough cash"};
	[player, "money", -(chop_wipe_cost)] call INV_AddInventoryItem;

	
	_last = [
		"Love","Dodd","Martin","Botterill","Allen","Harding","Verstappen","Lewin",
		"Acosta","Robertson","Cabrera","Hall","Garza","Oloughlin","Pollard","Fong",
		"Imes","Williams","Graham","Cohen","Marquez","Jansen","Grant","Harvey","Linkous",
		"Munoz","Guerrero","Carrigan","Cole","Christiane","Soper","Hensen","Taylor","Strobel","Lasalle","Joyce"
	];

	_first = [
		"Matt","Ashley","Trey","Ashleigh","Pete","Joseph","Matthew","Michael","Lewis","Mark",
		"Robert","Carl","Scott","Martin","Charles","Thomas","Nathan","Ralph","Dustin","Timothy",
		"Charlotte","Irene","Fannie","Tammy","Catherine","Rose","Jessica","Theresa","Anna",
		"Ruby","Ruth","Sherylynn","Anna","Juanita","Katina","Marie","Sara","Hattie","Carmella","Queen"
	];
	
	_first = _first select round random (count _first - 1);
	_last = _last select round random (count _last - 1);
	_name = format ["%1 %2",_first,_last];
	[_vehicle,_name] call vehicle_set_owner;
	
	player groupChat format ["You have forged your vehicles registration. It's now registered to %1",_name];
	
};

chop_vehicle = {
	private ["_vehicle"];
	_vehicle = _this select 0;
	if (isNil "_vehicle") exitWith {};
	_vehicle = call compile format ["%1",_vehicle];
	if (isNull _vehicle) exitWith {player groupChat "No vehicle"};
	
	if (_vehicle distance player > 10) exitWith {player groupChat "Vehicle is too far away to chop"};
		
	_infos = (typeof _vehicle) call INV_GetItemArray;
	_profit = _infos call INV_GetItemBuyCost;
	_profit = _profit * chopshopcoef;
	
	deleteVehicle _vehicle;
	
	[player,"money",_profit] call INV_AddInventoryItem;
	player groupChat format ["You have chopped this vehicle for $%1",[_profit,","] call format_integer];
};
