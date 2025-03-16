
tips_disabled = false;

tip_array = [

];

tip_faction_rules = [

];

tip_generic = [
	"If you cant open the interaction menu on a player, look at their feet",
	"Pressing E on a player will open the interaction menu",
	"You can press E on an unlocked vehicle to enter it quickly",
	"Ctrl + F will hit a player",
	"You can invest in stocks using your phone",
	"In the bottom right of the screen are our ts and website address",
	"Tilde (`) will open your phone",
	"Always carry a repair kit or medkit. You never know when you'll need one",
	"Pressing T near a vehicle will open its trunk",
	"Civilians and Insurgents lose their items upon death",
	"If you are in a police vehicle you are KOS to cops and insurgents",
	"You can holster pistols and some primary weapons",
	"The government convoy is a good source of money",
	"Civilians are KOS in armed vehicles",
	"You may run someone over if they shoot at your vehicle",
	"The legal flight alitiude over a city is 150 meters",
	"Pressing L will will unlock the nearest vehicle that you have keys for",
	"Be very careful while processing meth, Meth is highly explosive",
	"Loitering at a checkpoint or police operation is a ticketable offense",
	"Speed limits are 50 in town and 90 outside",
	"Purchasing the PMC or BAF addons will increase model, texture, and sound quality",
	"You can adjust your viewdistance by using the settings app on your phone",
	"You can recover impounded vehicles from the North and South impound lots",
	"Watch your back, Takistan is a dangerous and unforgiving place",
	"You can change your skin at any clothes shop",
	"You can press the Left Windows key to interact with vehicles and some objects",
	"You can change your shouts / saytexts in the settings menu of your phone",
	"You can paint your vehicles at any marked paint shop",
	"You can give keys to vehicles by using the keychain app on your phone",
	"It is illegal for civilians to be past the double bargates at jail",
	"Don't trust people you don't know",
	"Pressing J will bring up your task that you have avaliable"
	
];

tip_rules = [
	"As Blufor or Opfor you may not use hydras or launchers on infantry",
	"NLR is 10 minutes",
	"Gunstore is now a safezone again",
	"Non VICE/SRT Police must remain in marked police vehicles",
	"You must roleplay at all times",
	"Be respectful to all players",
	"Racism is a perm ban",
	"Any type of cheating / hacking / exploiting are perm bans",
	"If an admin request you to join teamspeak you must do so",
	"Opfor, Blufor, and Insurgent require you to be on teamspeak",
	"The president may only be armed with a handgun",
	"Do not mess with anyone in the admin skin",
	"The Blackmarket is NOT a KOS Zone!"
	
];

switch(true) do {
	case iscop : {
		tip_array = [
			"Ctrl + F will activate your sirens",
			"Ctrl + H will sound your airhorn",
			"Shift + H will change the sound your airhorn makes",
			"Pressing O near a bargate will open it if you're in a vehicle",
			"Any weapon that fires an explosive projectile is always illegal",
			"Holsterable SMGs count as pistols",
			"Any full auto rifle requires an assault rifle license",
			"Do not stun players with their hands up",
			"Roleplay whenever possible",
			"People will cooperate better if you are curteous",
			"Minimum alitude for aircraft is 150m",
			"You should only fire your weapon in self defense",
			"Insurgents cannot shoot you if you are visibly unarmed",
			"You can check the registration of a vehicle by opening the interaction menu",
			"Pressing J will bring up your task that you have avaliable"
		];
	};		
	case isciv : {
		tip_array = [
			"You can produce vehicles at the vehicle factory in the North",
			"You can produce weapons at the weapon factory in the South",
			"The blackmarket is a great place to get quality equipment",
			"You can buy legal and illegal steroids at the pharmacy",
			"You can sell stolen organs for a profit",
			"You can complete hostage missions and assasination missions for money",
			"Being in a gang area is KOS to rival gangs",
			"You can rob gas stations and the bank",
			"You can get shape charges at the blackmarket",
			"You can get a delivery mission at the shipping depot",
			"You can rob the government convoy",
			"You can contract PMC for many different purposes",
			"You can declare gang war through the gang menu if you are the leader"
			
		];
	};
	
	case isins : {
		tip_array = [
			"Police may not shoot you if you are visbily unarmed",
			"Roadside IEDs are a good way to kill infidels",
			"Working as a team is always better than being alone",
			"You can place car bombs in vehicles",
			"Need Money? Try mining",
			"Using a suppressed weapon will not give away your position as easy",
			"You can ask civilians to fund your actions",
			"Stealth is the key to a good operation",
			"May Allah be with you",
			"You can battlecry by scrolling",
			"You CANNOT Attack the Police Academy, in ANY way!"
			
		];
	};		
	
	case isopf : {
		tip_array = [
			"Ctrl + F will activate your sirens",
			"Ctrl + H will sound your airhorn",
			"Pressing O near a bargate will open it if you're in a vehicle",
			"Shift + H will change the sound your airhorn makes",
			"Any weapon that fires an explosive projectile is always illegal",
			"Holsterable SMGs count as pistols",
			"Any full auto rifle requires an assault rifle license",
			"Do not stun players with their hands up",
			"Roleplay whenever possible",
			"People will cooperate better if you are curteous",
			"Minimum alitude for aircraft is 150m",
			"You should only fire your weapon in self defense",
			"Insurgents cannot shoot you if you are visibly unarmed",
			"You can tax civilians up to $150,000 for entry into the south",
			"You can check the registration of a vehicle by opening the interaction menu"
		];
	};	
	
	case isesu : {
		tip_array = [
			"Collecting bodies is a good way to make money",
			"Deliver bodys in groups, It takes longer to do it idividually",
			"Roadside Assistance kits have unlimited uses",
			"First Aid Kits have unlimited uses",
			"Make sure police officers are done processing a body before taking it",
			"Drive safely",
			"Use road cones and barriers to direct traffic around an area",
			"Ctrl + F activates your sirens",
			"Ctrl + H sounds your airhorn",
			"You do not require a passport to cross the border",
			"You recieve points for delivering bodies",
			"You should call the police if anyone tampers with a body"
		];
	};
};

tip_array = tip_array + tip_generic;
tip_array = tip_array + tip_rules;
tip_array = tip_array + tip_faction_rules;

tip_loop = {

	while {true} do {
		uiSleep 360;
		if (tips_disabled) exitWith {};		
		_text = tip_array select round random (count tip_array - 1);
		
		if !(isNil "_text") then {
			[format ["TIP: %1",_text]] spawn hud_notification;
		};
	};		
};


[] spawn tip_loop;