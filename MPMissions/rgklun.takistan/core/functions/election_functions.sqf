
isChief = false;
isPresident = false;
isCommander = false;
isCaliph = false;

elections_run = true;
elections_term = 1800; // 30 Minutes - 1800
novoteself = true;

elections = [
	["",[],[]], // President
	["",[],[]], // Blufor Chief
	["",[],[]], // Opfor Commander
	["",[],[]] // Insurgent Caliph
	];

election_calculate = {

	private ["_array","_encumbent_unit","_election","_frontRunner","_previousVotes","_noVotes","_votes","_encumbent","_name","_count","_unit","_message","_winner_unit","_winner_unit"];
	_array = _this select 0;
	_election = _this select 1;
	diag_log format ["DEBUG: %1 | %2",_array, typeName _array];
	diag_log format ["DEBUG: %1 | %2",_election, typeName _election];
	
	_noVotes = false;
	_noEncumbent = false;
	
	diag_log format ["DEBUG: %1 | %2",_noVotes, typeName _noVotes];
	diag_log format ["DEBUG: %1 | %2",_noEncumbent, typeName _noEncumbent];
	
	_encumbent = _array select 0;
	_encumbent_unit = [_encumbent] call unit_by_name;
	_votes =  _array select 1;
	
	diag_log format ["DEBUG: %1 | %2",_encumbent, typeName _encumbent];
	diag_log format ["DEBUG: %1 | %2",_encumbent_unit, typeName _encumbent_unit];
	diag_log format ["DEBUG: %1 | %2",_votes, typeName _votes];
	
	if (_encumbent != "") then {
		_encumbent_unit = [_encumbent] call unit_by_name;
		_noEncumbent = true;
	};
	
	
	if (isNil "_array") exitWith {};
	if (isNil "_election") exitWith {};
	if (isNil "_encumbent") exitWith {};
	if (isNil "_votes") exitWith {};
	
	if (count _votes <= 0) then {_noVotes = true};
	
	if (_noVotes) exitWith {
		switch (_election) do {
			case 0 : {
				_message = format ["No one voted for a President. Polls are open"];
				format ['hint "%1";',_message] call broadcast;
			};			
			case 1 : {
				_message = format ["No one voted for a Police Chief. Polls are open"];
				format ['hint "%1";',_message] call broadcast;
			};			
			case 2 : {
				_message = format ["No one voted for an Opfor Commander. Polls are open"];
				format ['hint "%1";',_message] call broadcast;
			};			
			
			case 3 : {
				_message = format ["No one voted for a Caliph. Polls are open"];
				format ['hint "%1";',_message] call broadcast;
			};
		};
	};
	
	diag_log format ["DEBUG: %1 | %2",_message, typeName _message];
	
	if (isNil "_array") exitWith {};
	if (isNil "_election") exitWith {};
	
	_frontRunner = 0;
	_previousVotes = 0;
	
	for "_i" from 0 to (count _votes - 1) do {
		_name = (_votes select _i) select 0;
		_count = (_votes select _i) select 1;
		_unit = [_name] call unit_by_name;
	
		_exit = switch (true) do {
			case ((_election == 0) and ([_unit] call player_civilian)) : {false};
			case ((_election == 1) and ([_unit] call player_cop)) : {false};
			case ((_election == 2) and ([_unit] call player_opfor)) : {false};
			case ((_election == 3) and ([_unit] call player_insurgent)) : {false};
		};
		
		if (_exit) then {
			if !(isNil "_unit") then {
				if (_count > _previousVotes) then {
					_frontRunner = _i;
					_previousVotes = _count;
				};
			};
		};
	};
	
	_winner_name = (_votes select _frontRunner) select 0;
	_winner_unit = [_winner_name] call unit_by_name;
	
	if (isNil "_winner_name") exitWith {diag_log format ["DEBUG: ELECTION CALCULATE: Nil winner name"];};
	if (isNil "_winner_unit") exitWith {diag_log format ["DEBUG: ELECTION CALCULATE: Nil winner unit"];};
	
	switch (_election) do {
		case 0 : {
			CurrentPresident = str(_winner_unit); 
			format ['if (player == %1) then {isPresident = true};',_winner_unit] call broadcast;
			_message = format ["%1 - %2 has won the election for President with %3 votes",_winner_unit,_winner_name,_previousVotes];
			format ['hint "%1";',_message] call broadcast;
		}; // President
		
		case 1 : {
			CurrentChief = str(_winner_unit); 
			format ['if (player == %1) then {isChief = true};',_winner_unit] call broadcast;
			_message = format ["%1 - %2 has won the election for Police Chief with %3 votes",_winner_unit,_winner_name,_previousVotes];
			format ['hint "%1";',_message] call broadcast;
		}; // Chief
		case 2 : {
			CurrentCommander = str(_winner_unit); 
			format ['if (player == %1) then {isCommander = true};',_winner_unit] call broadcast;
			_message = format ["%1 - %2 has won the election for Opfor Commander with %3 votes",_winner_unit,_winner_name,_previousVotes];
			format ['hint "%1";',_message] call broadcast;
		}; // Commander
		
		case 3 : {
			CurrentCaliph = str(_winner_unit); 
			format ['if (player == %1) then {isCalip = true};',_winner_unit] call broadcast;
			_message = format ["%1 - %2 has won the election for Caliph with %3 votes",_winner_unit,_winner_name,_previousVotes];
			format ['hint "%1";',_message] call broadcast;
		}; // Caliph
	};
	
	_array = [_winner_name,[]];
	elections set [_election,_array];
};

elections_loop = {

	waitUntil {!isNil "elections"};
	
	while {elections_run} do {
		uiSleep elections_term;

		for "_i" from 0 to (count elections - 1) do {
			_election = elections select _i;
			[_election,_i] call election_calculate;
			uiSleep 3;
		};

		publicVariable "elections";
		diag_log format ["DEBUG: Election loop ran."];
	};
};

elections_vote = {

	private ["_vote","_votes","_voters","_election_ref","_election","_encumbent","_vote_array","_vote_name","_vote_count","_present"];
	
	_vote = _this select 0;
	_vote =  call compile _vote;
	_vote = name _vote;
	
	if (novoteself and (_vote == name player) and (playerSide countside playableUnits > 3)) exitWith {player groupChat format ["You are not allowed to vote for yourself in this election"]};
	
	if (isNil "_vote" or (typeName _vote != "STRING")) exitWith {diag_log format ["DEBUG: ELECTIONS_VOTE: Nil _vote"];};
	
	switch (true) do {
		case isciv : {_election_ref = 0};
		case isesu : {_election_ref = 0};
		case iscop : {_election_ref = 1};
		case isopf : {_election_ref = 2};
		case isins : {_election_ref = 3};
	};

	_election = (elections select _election_ref);
	_encumbent = (_election select 0);
	_votes = (_election select 1);
	_voters = (_election select 2);
	
	if (name player in _voters) exitWith {player groupChat format ["You have already voted in this election."];};

	_voters = _voters + [name player];
	_present = false;
	
	for "_i" from 0 to (count _votes - 1) do {
	
		_vote_array = _votes select _i;
		_vote_name = _vote_array select 0;
		_vote_count = _vote_array select 1;
		
		if (_vote_name == _vote) then {
			_vote_count = _vote_count + 1;
			_vote_array = [_vote_name,_vote_count];
			_votes set [_i,_vote_array];
			_present = true;
		};	
	};
	
	if !(_present) then {
		_votes = _votes + [[_vote,1]];
	};
	
	player groupChat format ["You have voted for %1",_vote];

	_election = [_encumbent,_votes,_voters];
	elections set [_election_ref,_election];
	publicVariable "elections";
};

if (isServer) then {
	[] spawn elections_loop;
};