private ["_messages","_timeout"];

_messages = [
	["Panthera Overpoch", "Welcome "+(name player)],
	["World", worldName],
	["Teamspeak", "TS.NuclearWarfareGaming.Com"],
	["Website/Forums", "NuclearWarfareGaming.Com"],
	["Server Rules", "Duping, glitching or using any<br />exploit will result in a<br />permanent ban."],
	["Server Rules", "No talking in side."],
	["Server Rules", "Two Heli’s and five cars per base/team, max of 3 player a team/base!<br />Hackers will be banned permanently"],
	["News", "Server now public!<br />Report any issues on the forums!<br />"]
];
 
_timeout = 5;
{
	private ["_title","_content","_titleText"];
	uiSleep 2;
	_title = _x select 0;
	_content = _x select 1;
	_titleText = format[("<t font='TahomaB' size='0.40' color='#a81e13' align='right' shadow='1' shadowColor='#000000'>%1</t><br /><t shadow='1'shadowColor='#000000' font='TahomaB' size='0.60' color='#FFFFFF' align='right'>%2</t>"), _title, _content];
	[
		_titleText,
		[safezoneX + safezoneW - 0.8,0.50],     //DEFAULT: 0.5,0.35
		[safezoneY + safezoneH - 0.8,0.7],      //DEFAULT: 0.8,0.7
		_timeout,
		0.5
	] spawn BIS_fnc_dynamicText;
	uiSleep (_timeout * 1.1);
} forEach _messages;