class agreement_dialog {
	idd = 1200;
	movingEnable = true;
	controlsBackground[] = {agreement_background, agreement_background_frame};
	objects[] = { };
	controls[] = {button_accept, button_decline, agreement_body, agreement_link};
	
	class agreement_background: RscBackground
	{
		idc = 1800;
		x = 0.385156 * safezoneW + safezoneX;
		y = 0.29 * safezoneH + safezoneY;
		w = 0.205078 * safezoneW;
		h = 0.525 * safezoneH;
	};	
	
	class agreement_background_frame: RscBGRahmen
	{
		idc = 1800;
		text = "RISE PD Police Agreement";
		x = 0.385156 * safezoneW + safezoneX;
		y = 0.29 * safezoneH + safezoneY;
		w = 0.205078 * safezoneW;
		h = 0.525 * safezoneH;
	};
	class button_accept: RscButton
	{
		idc = 1600;
		text = "I Agree";
		action = "police_agreement = true";
		x = 0.393359 * safezoneW + safezoneX;
		y = 0.7625 * safezoneH + safezoneY;
		w = 0.0902344 * safezoneW;
		h = 0.035 * safezoneH;
	};
	class button_decline: RscButton
	{
		idc = 1601;
		text = "I Decline";
		action = "failMission ""END1"";";
		x = 0.491797 * safezoneW + safezoneX;
		y = 0.7625 * safezoneH + safezoneY;
		w = 0.0902344 * safezoneW;
		h = 0.035 * safezoneH;
	};
	class agreement_body: RscStructuredText
	{
		idc = 1000;
		text = "Agreement here";
		x = 0.393359 * safezoneW + safezoneX;
		y = 0.3075 * safezoneH + safezoneY;
		w = 0.188672 * safezoneW;
		h = 0.385 * safezoneH;
	};
	class agreement_link: RscEdit
	{
		idc = 1001;
		text = "";
		x = 0.393359 * safezoneW + safezoneX;
		y = 0.71 * safezoneH + safezoneY;
		w = 0.188672 * safezoneW;
		h = 0.035 * safezoneH;
		tooltip = "A link to our rules page";
	};
};



