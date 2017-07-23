/*
rewrited by juandayz for epoch 1.6
put together for DayZ Epoch
Credits to Shogun338 from Insurrection gaming
modified for separate "gather weed" script
*/

private ["_vehicle","_inVehicle","_countplayers","_gearmenu","_playerPos","_nearWeed","_weed","_objectID","_objectUID"];
_playerPos = getPosATL player;
_hempqty = {_x == "ItemKiloHemp"} count magazines player;
_nearWeed = count nearestObjects [_playerPos, ["fiberplant"], 4] > 0;
_weed = nearestObject [player, "fiberplant"];

if !(_nearWeed) exitWith {
 systemChat("Needs be near of a FiberPlant");
};
if (_hempqty > 2) exitWith { 
    systemChat("YOure Full of Drugs");
};
if (player getVariable["combattimeout",0] >= diag_tickTime) exitWith {
dayz_actionInProgress = false; 
systemChat("Not in combat mode");
};
_vehicle = vehicle player;
_inVehicle = (_vehicle != player);
_countplayers = count nearestObjects [player, ["CAManBase"], 7];
if (_inVehicle) exitWith {
 systemChat("you cannot do it in a vehicle");
 };
if (_countplayers > 1) exitWith {

  systemChat("Nearest player action cancelled");
 };





	disableSerialization;
	_gearmenu = FindDisplay 106;
	_gearmenu CloseDisplay 106;
	player playActionNow "Medic";
	r_interrupt = false;
	sleep 6;
	//uncoment all comented lines if u have somekind of issue
	//_objectID = _weed getVariable["ObjectID","0"];
	//_objectUID = _weed getVariable["ObjectUID","0"];
	deleteVehicle _weed;
	//[_objectID,_objectUID] call server_deleteObj;
	//PVDZ_obj_Destroy = [_objectID,_objectUID,_weed];
    //publicVariableServer "PVDZ_obj_Destroy";
	player addMagazine "ItemKiloHemp";
	sleep 2;
	 systemChat("NICE LETS SMOKE OR SELL");

