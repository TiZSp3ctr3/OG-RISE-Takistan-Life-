
_pos1 = getposatl bankvault1;
_pos2 = getposatl bankvault2;
_pos3 = getposatl bankvault3;
_pos4 = getposatl bankvault4;


_array = [_pos1,_pos2,_pos3,_pos4];
_dir = [getdir bankvault1,getdir bankvault2,getdir bankvault3,getdir bankvault4];

_select = round random (count _array - 1);
_pos = _array select _select;
_dir = _dir select _select;

safe1 setposatl _pos;
safe1 setDir _dir;

deleteVehicle bankvault1;
deleteVehicle bankvault2;
deleteVehicle bankvault3;
deleteVehicle bankvault4;

_entry = (round random 10);

if (_entry <= 5) then {
	deleteVehicle bankentry1;
};