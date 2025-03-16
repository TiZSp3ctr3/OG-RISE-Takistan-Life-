patrolling = true;

while {patrolling} do {
	_location =  coppatrolarray select round random (count coppatrolarray - 1);
	_marker = createMarkerLocal ["patrolmarker",_location];
	"patrolmarker" setmarkertypelocal "warning";
	"patrolmarker" setmarkercolorlocal "coloryellow";
	"patrolmarker" setmarkersizelocal [1, 1];
	"patrolmarker" setmarkertextlocal "Patrol point";
	
	
	_patrol = ["Patrol","Head to the marked location on your map",_location] call  task_create;
	player sidechat "A patrol area has been marked. Head over there.";
	
	_distance = getpos player distance _location;
	
	waitUntil {player distance _location <= 30};
	
	deleteMarkerLocal "patrolmarker";
	
	[_patrol,true] call task_complete;
	_moneyearned = (ceil(_distance * patrolmoneyperkm));
	[player, _moneyearned] call transaction_dynamiccuntflap;
	[player, 2 ,false] call player_increase_rank;
	player sidechat format["You earned $%1 for patroling. A new point will be added in 5 seconds.", _moneyearned];
	
	uiSleep 5;
};

