if(isServer)exitWith{};
/*
	"Simple" Earplugs script by Halv

	Copyright (C) 2015  Halvhjearne

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.

	Contact : halvhjearne@gmail.com
*/
#include "settings.sqf";

waitUntil {!isNull (findDisplay 46)};
waitUntil {!dialog};

sleep 10;

if !(_txt isEqualTo "")then{
	systemChat _txt;
	hint _txt;
};

HALV_earplugtoggle = {
	_msg = "";
	_key = _this select 1;
	if(_key in (HALV_EarplugKeys select 0) || {_key in actionKeys _x}count(HALV_EarplugKeys select 1) > 0)then{
		_currentsoundlvl = soundVolume - 0.1;
		if(_currentsoundlvl < 0)then{
			_currentsoundlvl = 0;
		};
		1 fadeSound _currentsoundlvl;
		_msg = format["Volume Decreased (%1%2) ...",round(_currentsoundlvl*100),"%"];
		if(_currentsoundlvl isEqualTo 0)then{_msg = format["Muted (0%1) ...","%"];};
		hint _msg;
		systemChat _msg;
	};
	if(_key in (HALV_EarplugKeys select 2) || {_key in actionKeys _x}count(HALV_EarplugKeys select 3) > 0)then{
		_currentsoundlvl = soundVolume + 0.1;
		if(_currentsoundlvl > 1)then{
			_currentsoundlvl = 1;
		};
		_msg = format["Volume Increased (%1%2)...",round(_currentsoundlvl*100),"%"];
		1 fadeSound _currentsoundlvl;
		if(_currentsoundlvl isEqualTo 1)then{_msg = format["Full Volume (100%1)","%"];};
		hint _msg;
		systemChat _msg;
	};
};

_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArcadeMap\section_outrowin_ca.paa";
_txt = "Auto Earplugs On";
if(HALV_AUTOEARPLUGS)then{
	_pic = "\a3\Ui_f\data\gui\Rsc\RscDisplayArcadeMap\section_outroloose_ca.paa";
	_txt = "Auto Earplugs Off";
};

_action = player addAction [format["<img size='1.5'image='%1'/> <t color='#0096ff'>%2</t>",_pic,_txt],{
	if(HALV_AUTOEARPLUGS)then{
		HALV_AUTOEARPLUGS = false;
		player setUserActionText [_this select 2,"<img size='1.5'image='\a3\Ui_f\data\gui\Rsc\RscDisplayArcadeMap\section_outrowin_ca.paa'/> <t color='#0096ff'>Auto Earplugs On</t>"];
		cutText ["Auto earplugs off","PLAIN DOWN"];
	}else{
		HALV_AUTOEARPLUGS = true;
		player setUserActionText [_this select 2,"<img size='1.5'image='\a3\Ui_f\data\gui\Rsc\RscDisplayArcadeMap\section_outroloose_ca.paa'/> <t color='#0096ff'>Auto Earplugs Off</t>"];
		cutText ["Auto earplugs on","PLAIN DOWN"];
	};
},[], -20, false, true, _autohotkey, ""];

HALV_earplugsKeyDown = (findDisplay 46) displayAddEventHandler ["KeyDown",{_this call HALV_earplugtoggle}];

waitUntil{sleep 1;!(player isEqualTo (vehicle player))};

while{alive player}do{
	if(HALV_AUTOEARPLUGS)then{
		_isWalking = player isEqualTo (vehicle player);
		if(_isWalking)then{
			if(soundVolume < _HALV_autoUPDOWNVAL select 1)then{
				3 fadeSound (_HALV_autoUPDOWNVAL select 1);
				cutText [format["Earplugs removed ... Volume Increased (%1%2)",round((_HALV_autoUPDOWNVAL select 1)*100),"%"],"PLAIN DOWN"];
			};
		}else{
			if (soundVolume > _HALV_autoUPDOWNVAL select 0)then{
			_isPara = (vehicle player) isKindOf "ParachuteBase";
				if !(_isPara)then{
					3 fadeSound (_HALV_autoUPDOWNVAL select 0);
					cutText [format["Earplugs inserted ... Volume Decreased (%1%2)",round((_HALV_autoUPDOWNVAL select 0)*100),"%"],"PLAIN DOWN"];
				};
			};
		};
	};
	sleep 1;
};

waitUntil{sleep 1;!(alive player)};
player removeAction _action;

(findDisplay 46) displayRemoveEventHandler ["KeyDown", HALV_earplugsKeyDown];

3 fadeSound 1;

systemChat "Earplugs was removed ...";

waitUntil{sleep 1;(alive player)};

[] execVM __FILE__;
