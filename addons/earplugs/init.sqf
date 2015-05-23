/*
	"Simple" Earplugs script
	by Halv
*/

//================================ Settings ================================\\
//https://community.bistudio.com/wiki/ListOfKeyCodes
HALV_EarplugKeys = [
//key to decrease sounds, default 11 wich is - on uk keyboard
11,
//key to increase sounds, default 12 wich is + on uk keyboard
12
];
//info text show on login, "" to disable
_txt = "Earplugs Enabled, press + to increase or - reduce sounds (uk keyboard)...";

//============================== End Settings ==============================\\

waitUntil {!isNull (findDisplay 46)};
waitUntil {!dialog};

sleep 10;

if(_txt != "")then{
	systemChat _txt;
	hint _txt;
};

HALV_currentsoundlvl = 1;

HALV_earplugtoggle = {
	_msg = "";
	_key = _this select 1;
	if(_key == HALV_EarplugKeys select 0)then{
		HALV_currentsoundlvl = HALV_currentsoundlvl - 0.1;
		if(HALV_currentsoundlvl < 0)then{
			HALV_currentsoundlvl = 0;
		};
		_msg = format["Volume Decreased (%1%2) ...",round(HALV_currentsoundlvl*100),"%"];
		1 fadeSound HALV_currentsoundlvl;
		if(HALV_currentsoundlvl < 1 && isNil "HALV_earplugsInsereted")then{_msg = format["Earplugs inserted ... Volume Decreased (90%1)","%"];HALV_earplugsInsereted = true;};
		if(HALV_currentsoundlvl == 0)then{_msg = format["Volume (0%1) ...","%"];};
		hint _msg;
		systemChat _msg;
	};
	if(_key == HALV_EarplugKeys select 1)then{
		HALV_currentsoundlvl = HALV_currentsoundlvl + 0.1;
		if(HALV_currentsoundlvl > 1)then{
			HALV_currentsoundlvl = 1;
		};
		_msg = format["Volume Increased (%1%2)...",round(HALV_currentsoundlvl*100),"%"];
		1 fadeSound HALV_currentsoundlvl;
		if(HALV_currentsoundlvl == 1)then{_msg = format["Earplugs removed ... Volume (100%1)","%"];HALV_earplugsInsereted = nil;};
		hint _msg;
		systemChat _msg;
	};
};

HALV_earplugsKeyDown = (findDisplay 46) displayAddEventHandler ["KeyDown",{if(_this select 1 in HALV_EarplugKeys)then{_this call HALV_earplugtoggle};}];

waitUntil{sleep 1;!(alive player)};

(findDisplay 46) displayRemoveEventHandler ["KeyDown", HALV_earplugsKeyDown];
HALV_earplugtoggle = nil;
HALV_currentsoundlvl = nil;
HALV_earplugsInsereted = nil;
HALV_earplugsKeyDown = nil;
1 fadeSound 1;

systemChat "Earplugs was removed ...";
