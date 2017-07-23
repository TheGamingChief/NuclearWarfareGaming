[] spawn {
	if (isNil "smokingWeed") then {smokingWeed = false;};
	if (smokingWeed) exitWith {closeDialog 0; systemChat "Sorry dude, I can't let you smoke so much at one time. Get some scooby snacks then take another hit!";};
	smokingWeed = true;
	closeDialog 0;
	player removeMagazine "ItemKiloHemp";
	playSound "bong";
	sleep 6;
	playSound "cough";
	systemChat "You just took a fat hit! Feel the high kick in! (lasts 90 seconds)";

	disableSerialization;
	dayz_sourceBleeding = objNull;
	r_player_blood = r_player_blood + 3000;
	r_player_inpain = false;
	r_player_infected = false;
	r_player_injured = false;
	dayz_hunger = dayz_hunger + 0.4;
	dayz_thirst = dayz_thirst + 0.4;
	dayz_temperatur = 37;
	r_fracture_legs = false;
	r_fracture_arms = false;
	r_player_loaded = false;
	r_player_cardiac = false;
	r_player_lowblood = false;
	r_player_timeout = 0;
	r_handlercount = 0;
	r_interrupt = false;
	r_doLoop = false;
	r_drag_sqf = false;
	r_self = false;
	r_action = false;
	r_action_unload = false;
	r_player_handler = false;
	r_player_handler1 = false;
	disableUserInput false;
	'dynamicBlur' ppEffectAdjust [0];
	'dynamicBlur' ppEffectCommit 5;
	player setHit['Legs',0];
	player setVariable['messing',[dayz_hunger,dayz_thirst],true];
	player setVariable['USEC_infected',false,true];
	player setVariable['USEC_injured',false,true];
	player setVariable['USEC_inPain',false,true];
	player setVariable['USEC_isCardiac',false,true];
	player setVariable['USEC_lowBlood',false,true];
	player setVariable['hit_legs',0,true];
	player setVariable['hit_hands',0,true];
	player setVariable['medForceUpdate',true,true];
	_display = uiNameSpace getVariable 'DAYZ_GUI_display';
	_control = _display displayCtrl 1303;
	_control ctrlShow false;
	_display = uiNameSpace getVariable 'DAYZ_GUI_display';
	_control = _display displayCtrl 1203;
	_control ctrlShow false;
	player setdamage 0;
	0 fadeSound 1;

	playSound "cough";
	sleep 3;
	playSound "cough";
	sleep 3;
	playSound "cough";


	Remove_Drug_effects =
	{
		{ppEffectDestroy _x;} forEach (_this select 0);
		ppEffectDestroy ppe2;
		ppEffectDestroy ppe3;
		setaperture 0;
		smokingWeed = false;
		systemChat "Shit dude, your high wore off :(";
	};

	_time = time;
	_effects = [];
	while {true} do
	{
		ppe2 = ppEffectCreate ["chromAberration", 1555];
		_effects = _effects + [ppe2];
		ppe2 ppEffectAdjust [random 0.25,random 0.25,true];
		ppe2 ppEffectCommit 1;
		ppe2 ppEffectEnable true;
		ppe3 = ppEffectCreate ["radialBlur", 1556];
		_effects = _effects + [ppe3];
		ppe3 ppEffectEnable true;
		ppe3 ppEffectAdjust [random 0.02,random 0.02,0.15,0.15];
		ppe3 ppEffectCommit 1;
		sleep random(1);
		if (_time + 60 < time) exitWith {[_effects] call Remove_Drug_effects;};
	};
};