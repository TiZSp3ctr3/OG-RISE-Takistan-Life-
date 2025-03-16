class election_dialog {
	idd = -1;
	movingEnable = true;
	controlsBackground[] = {DLG_BACK1, background};
	objects[] = { };
	controls[] = {spielerliste, submit, cancel, dummybutton};

	class DLG_BACK1: Rscbackground	{
		x = 0.36; y = 0.06;
		w = 0.30; h = 0.80;		
	};

	class background : RscBgRahmen	{
		x = 0.36; y = 0.06;
		w = 0.30; h = 0.80;
		text = $STRD_description_wahl_header;
	};

	class spielerliste : RscListBox	{
		idc = 1;
		x = 0.38; y = 0.09;
		w = 0.27; h = 0.61;
	};

	class submit : RscButton {
		x = 0.42; y = 0.72;
		w = 0.20; h = 0.04;
		text = $STRD_description_wahl_submit;
		action = "[lbData [1, (lbCurSel 1)]] call elections_vote; closedialog 0";
	};
	
	class cancel : RscButton {
		x = 0.42; y = 0.79;
		w = 0.20; h = 0.04;

		text = $STRD_description_buyitem_close;
		action = "closedialog 0;";
	};

	class dummybutton : RscDummy {
		idc = 1070;
	};
};