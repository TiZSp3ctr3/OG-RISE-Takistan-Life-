/*
	@file Version: 1.0
	@file Name: hud.hpp
	@file Author: [404] Deadbeat
	@file Created: 11/09/2012 04:23
	@file Args:
	Modified By [RISE] Montel Williams
*/

#define hud_status_idc 3600
#define hud_vehicle_idc 3601
#define respawn_MissionUptime_Text 3402

class RGHud {
	idd = -1;
    fadeout=0;
    fadein=0;
	duration = 20;
	name= "RGHud";
	onLoad = "uiNamespace setVariable ['RGHud', _this select 0]";

	class controlsBackground {
		class RGHud_Vehicle:w_RscText
		{
			idc = hud_vehicle_idc;
			type = CT_STRUCTURED_TEXT;
			size = 0.040;
			x = safeZoneX + (safeZoneW * (1 - (0.42 / SafeZoneW)));
                        y = safeZoneY + (safeZoneH * (1 - (0.35 / SafeZoneH)));
			w = 0.6; h = 0.70;
			colorText[] = {1,1,1,1};
			lineSpacing = 3;
			colorBackground[] = {0,0,0,0};
			text = "";
			shadow = 2;
			class Attributes {
				align = "right";
			};
		};
		class RGHud_Status:w_RscText
		{
			idc = hud_status_idc;
			type = CT_STRUCTURED_TEXT;
			size = 0.040;
			x = safeZoneX + (safeZoneW * (1 - (0.29 / SafeZoneW)));
            y = safeZoneY + (safeZoneH * (1 - (0.50 / SafeZoneH)));
			w = 0.29; h = 0.5;
			colorText[] = {1,1,1,1};
			lineSpacing = 3;
			colorBackground[] = {0,0,0,0};
			text = "";
			shadow = 2;
			class Attributes {
				align = "right";
			};
		};
		class MissionUptimeText:w_RscText
		{
			idc = respawn_MissionUptime_Text;
			type = CT_STRUCTURED_TEXT;
			size = 0.035;
			x = safeZoneX + (safeZoneW * (1 - (1.92 / SafeZoneW)));//More = left, Less = Right
			y = safeZoneY + (safeZoneH * (1 - (0.070 / SafeZoneH)));
			w = 1.92; h = 0.100;
			colorText[] = {1,1,1,1};
			lineSpacing = 3;
			colorBackground[] = {0,0,0,0};
			text = "";
			shadow = 1;
			class Attributes {
				align = "right";
			};
		};
	};
};