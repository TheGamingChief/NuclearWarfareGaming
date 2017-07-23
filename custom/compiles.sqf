if (isServer) then {
	diag_log "Loading custom server compiles";	
};

if (!isDedicated) then {
	diag_log "Loading custom client compiles";
	
	fnc_usec_selfactions = compile preprocessFileLineNumbers "custom\fn_selfActions.sqf";
	player_humanityMorph = compile preprocessFileLineNumbers "custom\player_humanityMorph.sqf";
    player_selectSlot = compile preprocessFileLineNumbers "scripts\click_actions\ui_selectSlot.sqf";
	player_useMeds = compile preprocessFileLineNumbers "scripts\click_actions\player_useMeds.sqf";
	player_gearSet = compile preprocessFileLineNumbers "custom\player_gearSet.sqf";
	player_wearClothes = compile preprocessFileLineNumbers "custom\player_wearClothes.sqf";
};
