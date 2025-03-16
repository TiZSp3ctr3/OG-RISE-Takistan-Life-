button_pressed_evnt =
{
	button_pressed = true;
};

button_pressed = false;

while {true} do
{
	if (isstaff or istsh or blackscreen) exitwith {};
	_t1 = diag_ticktime;
	_dir = direction player;
	while {(!button_pressed) and (_dir == (direction player))} do
	{
		_afk_time = (diag_ticktime - _t1);
		if (_afk_time >= 580) then
		{
			cutText ["You're AFK! Move or get kicked!", "PLAIN DOWN"];
			if (_afk_time >= 600) exitwith { call compile format ["custom_%1_kick","afk"];};
		};
		uiSleep 1;
	};
	button_pressed = false;
	uiSleep 10;
};







