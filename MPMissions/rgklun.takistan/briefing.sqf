
player createDiarySubject ["changelog","Change Logs"];
player createDiarySubject ["controls","TLR Controls"];
player createDiarySubject ["bugs","Official Website"];
player createDiarySubject ["credits","TS3&Credits"];

player createDiaryRecord ["credits",
[
"",
"
TS3 Info;<br/>
Address: ts3.rise-gaming.com<br/>
<br/>
Official website: http://rise-gaming.com<br/>
Join the forums, make suggestions, report bugs and be sure to get on Teamspeak!<br/>



<br/>
Mission build: 4.1<br/>
Currently developed by: RISE Development Team<br/>
Thanks to all the people who helped testing<br/>
Also special thanks to all the developers who brought Takistan Life Revolution to what it is so far<br/>
"
]
];

player createDiaryRecord ["bugs",
[
"",
"
Please report bugs to the development team on the forums via the bugs section!<br/>
Website: http://rise-gaming.com<br/>
Teamspeak: ts3.rise-gaming.com<br/>
<br/>
<br/>
We look forward to playing with you!<br/>
"
]
];

player createDiaryRecord ["controls",
[
"",
"
Key: Function<br/>
Description<br/>
<br/>
General keys:<br/>
1: Stats<br/>
Displays basic info about the player and server. Tells you how much shekels you have, who is wanted, etc.
<br/>
2: Inventory<br/>
Shows items in player inventory. Allows you to drop, use, and give them to other people. (Note: to give another player a copy of your car keys, first press Use while Keychain is selected)
<br/>
3: Hands Up<br/>
Raises hands to indicate surrender. Police can search and handcuff a civilian while their hands are raised.
<br/>
4: Hands Down / Quick Draw<br/>
Cancels the current animation. Can be used to quick draw a weapon.
<br/>
5: Gang Menu (civs only)<br/>
Civs can access the gang menu to view, join and create gangs.
<br/>
`(tilde key (to the left of the 1 key): Cop Menu (cops only)<br/>
Cops can set bounties, release jailed civilians and more. When accessed in a vehicle, choosing Sat Cam in cop menu gives an overhead satellite view of the map.
<br/>
<br>F (in a vehicle): Toggle Siren On/Off (cops only)<br/>
Police can turn on a siren while driving vehicles to signal to civilians to pull over.
IMPORTANT: DO NOT USE THE SIRENS UNLESS YOU ARE RESPONDING TO AN EMERGENCY, AND DO NOT FORGET TO TURN IT OFF.
<br/>
E: Action<br/>
The basic action button.  Used to interact with shops, ATM's, and other players (while they are stunned and/or restrained).
<br/>
T: Access Vehicle Trunk<br/>
when you own a car or other vehicle, you can access that car's inventory by standing next to the car and pressing T.  You will then be shown two box's.  The left box is what is in the car, and the right box is what is in your inventory.  Highlight the object you want to transfer, then select the amount and press the button on the side that has the item.  Car's hold a certain amount of weight just like your charactor so be aware of what you stash in there.  Also, if your vehicle is destroyed then you will loose whatever you place in here.  Coppers can search for drugs or other ileagal items.  If they find them in your car it will disappear and the coppers gain shekels equal to the value of the drugs.
<br/>
F: Remove Safety<br/>
When unholstering a weapon, you may need to press F before it will fire. F is also a default ArmA 2 key that adjusts the firing mode of the weapon.
<br/>
Left shift+F: Pistol whip / Rifle butt<br/>
Disables and disarms another player, allowing you to rob them by pressing E. Only works if you have a weapon.
<br/>
0-0-6, 0-0-7, 0-0-8: shout outs<br/>
Press these buttons to shout out measages on the fly.  For civilians the default says ""Don't Shoot, I surrender!"".  For cops, it says a variety of things but mainly says, ""Put up your hands or your dead"" kinda thing.
<br/>
0-0: options<br/>
this should give you the options for video settings, shout outs, fix head bug, and even a quick-brief tutorial on TLR.""
<br/>
"
]
];


player createDiaryRecord ["changelog",
[
"RISE Gaming Takistan Life Changelog",
"
Added: Pressing V while halo jumping will deploy your parachute.
Fixed: Stunning at heights.
Fixed: Ejecting off the side of helicopters, not deploying chute properly.
Fixed: Take evidence scroll wheel command.
Changed: Moved VIP.
Changed: Moved bank.
Added: Opfor government convoy. <br/>
Changed: Blufor government convoy. <br/>
Changed: Changed 911 System to use the tasking functions. <br/>
Added: Ability to create, schedule, and complete tasks <br/>
"
]
];

player selectDiarySubject "changelog";