class schluessel {
    idd = -1;
    movingEnable = true;
	
    controlsBackground[] = {
        background
    };
	
    objects[] = { };

    controls[] = {
        schluesselliste, submit, submit2, cancel, button_wegwerfen, players,dummybutton
    };

    class background : RscBackground {
        x = 0.34; y = 0.11;
        w = 0.33; h = 0.81;
    };

    class schluesselliste : RscListBox {
        idc = 1;
        x = 0.35; y = 0.14;
        w = 0.31; h = 0.49;
        style = ST_CENTER;
    };

    class submit : RscButton {
        idc = 2;
        x = 0.35; y = 0.65;
        w = 0.31; h = 0.04;
        text = $STRD_inv_description_inventar_use;
    };   
	class players : RscCombo {
        idc = 6;
        x = 0.35; y = 0.70;
        w = 0.31; h = 0.04;
    };

    class submit2 : RscButton {
        idc = 5;
        x = 0.35; y = 0.75;
        w = 0.31; h = 0.04;
        text = $STRD_inv_description_inventar_schluessel_uebergabe;
    };

    class cancel : RscButton {
        idc = 3;
        x = 0.35; y = 0.80;
        w = 0.31; h = 0.04;
        text = $STRD_description_cancel;
        action = "closedialog 0";
    };

    class button_wegwerfen : RscButton {
        idc = 4;
        x = 0.35; y = 0.86;
        w = 0.31; h = 0.04;
        text = $STRD_inv_description_inventar_drop;
    };

    class dummybutton : RscDummy {
        idc = 1013;
    };
    
};
class handydialog{
    idd = -1;
    movingEnable = true;
	
    controlsBackground[] = {
        DLG_BACK1, background
    };
	
    objects[] = { };

    controls[] = {
        eingabefeld, kosten, submit, cancel, spielerliste, dummybutton
    };

    class DLG_BACK1: RscBackground  {
        x = 0.04; y = 0.30;
        w = 0.91; h = 0.13;
    };

    class background : RscBgRahmen {
        x = 0.04; y = 0.30;
        w = 0.91; h = 0.13;
        text = $STRD_description_handy_title;
    };

    class eingabefeld : RscEdit {
        idc = 1;
        x = 0.05; y = 0.33;
        w = 0.89; h = 0.04;
    };

    class kosten : RscText {
        idc = 4;
        x = 0.47; y = 0.38;
        w = 0.20; h = 0.04;
        text = $STRD_description_handy_cost;
    };

    class submit : RscButton {
        idc = 3;
        x = 0.26; y = 0.38;
        w = 0.20; h = 0.04;
        text = $STRD_description_handy_submit;
    };

    class cancel : RscButton {
        idc = 5;
        x = 0.74; y = 0.38;
        w = 0.20; h = 0.04;
        text = $STRD_description_cancel;
        action = "closedialog 0;";
    };

    class spielerliste : RscCombo {
        idc = 2;
        x = 0.05; y = 0.38;
        w = 0.20; h = 0.04;
    };

    class dummybutton : RscDummy {
        idc = 1016;
    };
    
};

class global_message_dialog { 
    idd = -1;
    movingEnable = true;
	
    controlsBackground[] = {
        DLG_BACK1, background
    };
	
    objects[] = { };

    controls[] = {
        eingabefeld, kosten, submit, cancel, dummybutton
    };

    class DLG_BACK1: RscBackground  {
        x = 0.04; y = 0.30;
        w = 0.91; h = 0.13;
    };

    class background : RscBgRahmen {
        x = 0.04; y = 0.30;
        w = 0.91; h = 0.13;
        text = "Write Global Message";
    };

    class eingabefeld : RscEdit {
        idc = 1;
        x = 0.05; y = 0.33;
        w = 0.89; h = 0.04;
    };

    class kosten : RscText {
        idc = 4;
        x = 0.47; y = 0.38;
        w = 0.20; h = 0.04;
        text = "Cost: $2,000";
    };

    class submit : RscButton {
        idc = 3;
        x = 0.26; y = 0.38;
        w = 0.20; h = 0.04;
        text = $STRD_description_handy_submit;
    };

    class cancel : RscButton {
        idc = 5;
        x = 0.74; y = 0.38;
        w = 0.20; h = 0.04;
        text = $STRD_description_cancel;
        action = "closedialog 0;";
    };
	
    class dummybutton : RscDummy {
        idc = 1016;
    };
    
};
class timebombconfig {
    idd = -1;
    movingEnable = true;
	
    controlsBackground[] = {
        DLG_BACK1, background
    };
	
    objects[] = {};

    controls[] = {
        slider, text, wert, submit, cancel, dummybutton
    };

    class DLG_BACK1: RscBackground {
        x = 0.04; y = 0.29;
        w = 0.91; h = 0.09;
    };

    class background : RscBgRahmen {
        x = 0.04; y = 0.29;
        w = 0.91; h = 0.09;
        text = $STRD_description_zeitbombenconfig_header;
    };

    class slider : RscSliderH {
        idc = 1;
        x = 0.05; y = 0.32;
        w = 0.44; h = 0.04;
    };

    class text : RscText {
        idc = 2;
        x = 0.50; y = 0.32;
        w = 0.08; h = 0.04;
        style = ST_RIGHT;
        colorText[] = {1, 1, 1, 1};
			
        colorBackground[] = {0, 0, 0, 0};
		
        font = FontM;
        SizeEX = 0.02;
        text = $STRD_description_zeitbombenconfig_zeit;
    };

    class wert : RscText {
        idc = 3;
        x = 0.58; y = 0.32;
        w = 0.04; h = 0.04;
        style = ST_LEFT;
        colorText[] = { 1, 1, 1, 1};
        colorBackground[] = {0, 0, 0, 0};
		
        font = FontM;
        SizeEX = 0.02;
    };

    class submit : RscButton {
        idc = 4;
        x = 0.63; y = 0.32;
        w = 0.14; h = 0.04;
        text = $STRD_description_bombenconfig_plant;
    };

    class cancel : RscButton {
        idc = 5;
        x = 0.78; y = 0.32;
        w = 0.15; h = 0.04;
        text = $STRD_description_cancel;
        action = "closedialog 0";
    };

    class dummybutton : RscDummy {
        idc = 1011;
    };
    
};
class speedbombconfig {
    idd = -1;
    movingEnable = true;
	
    controlsBackground[] = {
        DLG_BACK1, background
    };
	
    objects[] = {};

    controls[] = {
        slider, text, wert, slider2, text2, wert2, submit, cancel, dummybutton
    };

    class DLG_BACK1: RscBackground {
        x = 0.04; y = 0.29;
        w = 0.91; h = 0.19;
    };

    class background : RscBgRahmen {
        x = 0.04; y = 0.29;
        w = 0.91; h = 0.19;
        text = $STRD_description_bombenconfig_header;
    };

    class slider : RscSliderH {
        idc = 1;
        x = 0.05; y = 0.32;
        w = 0.44; h = 0.04;
    };

    class text : RscText {
        idc = 2;
        x = 0.50; y = 0.32;
        w = 0.08; h = 0.04;
        style = ST_RIGHT;
        text = $STRD_description_bombenconfig_speed;
    };

    class wert : RscText {
        idc = 3;
        x = 0.58; y = 0.32;
        w = 0.04; h = 0.04;
    };

    class slider2 : RscSliderH {
        idc = 8;
        x = 0.05;y = 0.40;
        w = 0.44; h = 0.04;
    };

    class text2 : RscText {
        idc = 9;
        x = 0.50; y = 0.40;
        w = 0.08; h = 0.04;
        style = ST_RIGHT;
        text = $STRD_description_bombenconfig_speed2;
    };

    class wert2 : RscText {
        idc = 10;
        x = 0.58; y = 0.40;
        w = 0.04; h = 0.04;
    };

    class submit : RscButton {
        idc = 4;
        x = 0.65; y = 0.32;
        w = 0.14; h = 0.04;
        text = $STRD_description_bombenconfig_plant;
    };

    class cancel : RscButton {
        idc = 5;
        x = 0.80; y = 0.32;
        w = 0.15; h = 0.04;
        text = $STRD_description_cancel;
        action = "closedialog 0";
    };

    class dummybutton : RscDummy {
        idc = 1010;
    };
};


class remotebomb_remote
{
    idd = -1;
    
    movingEnable = true;
    
    controlsBackground[] = {
        DLG_BACK1, background
    };
    
    objects[] = {};
	
    controls[] = {
        text1, eingabefeld, submit, cancel, dummybutton
    };
    
    class DLG_BACK1: RscBackground {
        x = 0.38; y = 0.42;
        w = 0.24; h = 0.13;
    };
    
    class background : RscBgRahmen {
        x = 0.38;y = 0.42;
        w = 0.24; h = 0.13;
        text = "Stringtable";
    };
    
    class text1 : RscText {
        idc = 2;
        x = 0.39; y = 0.45;
        w = 0.08; h = 0.04;
        text = "Bomb Code: ";
    };
    
    class eingabefeld : RscEdit {
        idc = 1;
        x = 0.47; y = 0.45;
        w = 0.13; h = 0.04;
        onChar = "[_this, 1] call KeyPressHandler;";

    };

    class submit : RscButton {
        idc = 4;
        x = 0.39; y = 0.50;
        w = 0.10; h = 0.04;
        text = "Execute";
        action = "";
    };
    
    class cancel : RscButton {
        idc = 5;
        x = 0.51; y = 0.50;
        w = 0.10; h = 0.04;
        text = $STRD_description_cancel;
        action = "closedialog 0";
    };
    
    class dummybutton : RscDummy {
        idc = 1090;
    };
};


