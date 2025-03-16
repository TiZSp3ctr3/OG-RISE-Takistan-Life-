
_introTexts = [];

switch (true) do {
	case iscop : {
		_introTexts = [
			"TIP: In order to receive your points towards leveling up, You need to complete a patrol mission"
		
		];
	};	
	
};

if (isNil "_introTexts" or (count _introTexts < 1)) exitWith {};


{

	[_x] spawn hud_notification; 
	uiSleep 3;

} foreach _introTexts;

