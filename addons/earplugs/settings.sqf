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

//================================ Settings ================================\\
//https://community.bistudio.com/wiki/ListOfKeyCodes
HALV_EarplugKeys = [
//keys to decrease sounds, default [0x0C],["User1"], wich is - on uk/us keyboard and + on northern eu keyboards + customkey "User1"
[0x0C],["User1"],
//keys to increase sounds, default [0x0D],["User2"] wich is + on uk/us and ´ on northern eu keyboards + customkey "User2"
[0x0D],["User2"]
];

//autoearplugs true = on when loading in, false = off when loading in
HALV_AUTOEARPLUGS = true;

//this is the hotkey to switch auto-earplugs on/off
_autohotkey = "User3";

_HALV_autoUPDOWNVAL = [
//auto volume when entering vehicle value fro 0 to 1, 0 = no sound, 1 = full sound
0.3,
//auto volume when exiting vehicle value fro 0 to 1, 0 = no sound, 1 = full sound
1
];

//info text show on login, "" to disable
_txt = "Earplugs Enabled, press + to increase or - reduce sounds (uk/us keyboard)...";
//============================== End Settings ==============================\\
