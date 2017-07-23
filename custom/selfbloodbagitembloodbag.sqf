private ["_blood","_lowBlood","_injured","_inPain","_animState","_started","_finished","_timer","_i","_isMedic","_duration","_rhVal","_bloodBagArrayNeeded","_BBneeded","_bbselect","_bloodBagNeeded","_badBag","_wholeBag","_bagFound","_forceClose","_bloodType","_rh","_bbarray_length","_bloodBagWholeNeeded","_haswholebag","_r","_transfusionInfection"];


_blood = player getVariable ["USEC_BloodQty", 0];
_lowBlood = player getVariable ["USEC_lowBlood", false];
_injured = player getVariable ["USEC_injured", false];
_inPain = player getVariable ["USEC_inPain", false];
if (time - dayz_lastSelfTransfusion <= DZE_selfTransfuse_Values select 2) exitWith {localize "str_actions_medical_18" call dayz_rollingMessages;};

call gear_ui_init;
closeDialog 0;

_bloodType = player getVariable ["blood_type", false];
_rh = player getVariable ["rh_factor", false];

_badBag = false;
_wholeBag = false;
_bagFound = false;
_BBneeded = false;
_forceClose = false;
_transfusionInfection = 75;
_transfusionInfection = ((random 100) < 75);
_bagUsed = "ItemBloodbag";


if (_blood <= 4000) then {
	_duration = 3;
	} else {
	_duration = 2;
};

_bloodBagWholeNeeded = "ItemBloodbag";
_wholeBag = true;
_badBag = false;

call fnc_usec_medic_removeActions;
r_action = false;

if (vehicle player == player) then {
	player playActionNow "Medic";
};

r_interrupt = false;
_animState = animationState player;
r_doLoop = true;
_started = false;
_finished = false;
_timer = diag_tickTime;
_i = 0;
_r = 0;

while {r_doLoop and (_i < 12)} do {
	_animState = animationState player;
	_isMedic = ["medic",_animState] call fnc_inString;

	if (((vehicle player != player) || _isMedic) and !_started) then {
		closeDialog 0;
		diag_log format ["TRANSFUSION: starting blood transfusion (%1 > %2)", name player, name player];
		diag_log format ["%1", _bagUsed];
		if (_bagUsed in magazines player) then { _bagFound = true; };
		if (!_bagFound) then {_forceClose = true;} else { player removeMagazine _bagUsed;};
		localize "str_actions_medical_transfusion_start" call dayz_rollingMessages;
		systemChat "=========================================================================================================";
		systemChat "You are using a universal blood bag, this will only give you 4k blood and has a 75% chance of infection!";
		systemChat "You can get a blood test kit from your local trader to determine your blood type.";
		systemChat "Once your blood type has been determined you can buy that type of blood to restore 12k with 0% chance of infection!";
		systemChat "=========================================================================================================";
		_started = true;
	};

	if (_started) then {
		if ((diag_tickTime - _timer) >= 1) then {
			_timer = diag_tickTime;
			_i = _i + 3;
			if (!_badBag) then {
				if (!_forceClose) then {
					if (!_wholeBag) then {
						_randomamount = round(random 60);
						r_player_blood = r_player_blood + 100 + _randomamount;
					} else {
						_randomamount = round(random 200);
						r_player_blood = (r_player_blood + (4000/4)) min r_player_bloodTotal;
					};

				};
			} else {
				if (!_forceClose and (_i >= 12)) then {
					[player, _duration] call fnc_usec_damageUnconscious;
				};
			};
		};
		if (vehicle player == player) then {
			if (!_isMedic) then {
				player playActionNow "Medic";
			};
		} else {
			uisleep 4;
		};
	};

	_blood = player getVariable ["USEC_BloodQty", 0];

	if (((_blood >= r_player_bloodTotal) and !_badBag and _bagFound) or (_i == 12)) then {
		diag_log format ["TRANSFUSION: completed blood transfusion successfully (_i = %1)", _i];
		dayz_lastSelfTransfusion = time;
		if (_transfusionInfection) then {r_player_infected = true; player setVariable["USEC_infected",true,true];};
		localize "str_actions_medical_transfusion_successful" call dayz_rollingMessages;
		r_doLoop = false;
	};

	if (r_interrupt or _forceClose) then {
		diag_log format ["TRANSFUSION: transfusion was interrupted (r_interrupt: %1 | distance: %2 | _i = %3)", r_interrupt, player distance player, _i];
		localize "str_actions_medical_transfusion_interrupted" call dayz_rollingMessages;
		r_doLoop = false;
	};

	uiSleep 0.1;
};

r_doLoop = false;

if (r_interrupt) then {
	r_interrupt = false;
	if (vehicle player == player) then {
		player switchMove "";
		player playActionNow "stop";
	};
};
