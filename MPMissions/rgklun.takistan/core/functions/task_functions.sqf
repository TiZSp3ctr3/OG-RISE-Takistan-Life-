
/*	Examples
	killtsk = ["Kill Player","Go and kill that player",getpos srt_weapons] call task_create;

*/
task_create = {
	private ["_title","_location","_description","_task","_details"];
	_title = _this select 0;
	_description = _this select 1; 
	_location = _this select 2;

	
	if (isNil "_title") exitWith {diag_log "DEBUG: Task title not defined"};
	
	_task = player createSimpleTask [_title];
	
	if !(isNil "_description") then {
		_details = [_description,_title,_title];
		_task setSimpleTaskDescription _details;
	};
	if !(isNil "_location") then {
		_task setSimpleTaskDestination _location;
	};
	
	player setCurrentTask _task;
	_task setTaskState "Assigned";
	
	player groupChat format ["You have been assigned a new task : %1 Press J to view",_title];
	[format ["You have been assigned a new task : %1",_title]] spawn hud_notification;

	_task
};

task_complete = {
	_task = _this select 0;
	_state = _this select 1;
	_delete = _this select 2;
	
	if (isNil "_task") exitWith {};
	if (isNil "_state") exitWith {};
	if (isNil "_delete") then {_delete = true};
	_title = taskDescription _task;
	_title = (_title select 1);
	
	if (_state) then {
		_task setTaskState "Succeeded";
		player groupChat format ["You have completed task : %1, Well done.",_title];
		[format ["You have completed task : %1, Well done.",_title]] spawn hud_notification;
	} else {
		_task setTaskState "Failed";
		player groupChat format ["You have failed task : %1, Better luck next time.",_title];
		[format ["You have failed task : %1, Better luck next time.",_title]] spawn hud_notification;
	};
	if (_delete) then {
		player removeSimpleTask _task;
	};
};

task_functions_defined = true;