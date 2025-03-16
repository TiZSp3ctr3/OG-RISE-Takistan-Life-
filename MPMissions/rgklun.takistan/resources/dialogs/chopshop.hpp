
class chopshop {

	idd = 1500;
	movingEnable = false;
	enableSimulation = true;

	class controlsBackground {
		
		class chop_background: RscBackground
		{
			idc = 1800;
			x = 0.401563 * safezoneW + safezoneX;
			y = 0.325 * safezoneH + safezoneY;
			w = 0.164062 * safezoneW;
			h = 0.49 * safezoneH;
		};

		class chop_background_frame: RscBgRahmen
		{
			idc = 1800;
			text = "Chop Shop";
			x = 0.401563 * safezoneW + safezoneX;
			y = 0.325 * safezoneH + safezoneY;
			w = 0.164062 * safezoneW;
			h = 0.49 * safezoneH;
		};
	};

	class controls
	{
		class chop_vehicles: RscListbox
		{
			idc = 1501;
			x = 0.409766 * safezoneW + safezoneX;
			y = 0.3425 * safezoneH + safezoneY;
			w = 0.147656 * safezoneW;
			h = 0.2975 * safezoneH;
			//onLBSelChanged = "_this call chop_update;";
		};

		class chop_chop: RscButton
		{
			idc = 1502;
			text = "Chop Vehicle";
			action = "[lbData [1501,lbCurSel 1501]] call chop_vehicle;";
			x = 0.409766 * safezoneW + safezoneX;
			y = 0.6575 * safezoneH + safezoneY;
			w = 0.147656 * safezoneW;
			h = 0.035 * safezoneH;
		};

		class chop_clear: RscButton
		{
			idc = 1503;
			text = "Forge Registration ($7,500)";
			action = "[lbData [1501,lbCurSel 1501]] call chop_clear;";
			x = 0.409766 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.147656 * safezoneW;
			h = 0.035 * safezoneH;
		};

		class chop_close: RscButton
		{
			idc = 1504;
			text = "Close";
			action = "closedialog 0";
			x = 0.409766 * safezoneW + safezoneX;
			y = 0.7625 * safezoneH + safezoneY;
			w = 0.147656 * safezoneW;
			h = 0.035 * safezoneH;
		};

	};
};
