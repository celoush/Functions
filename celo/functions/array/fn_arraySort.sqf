/************************************************************
  Array Sort
	By Celoush

This function sort array with Quicksort algorithm.

Example:
array = [3,2,1,4]
array call BIS_fnc_arrSort

array is now [1,2,3,4]
************************************************************/

private["_qsort_swap","_qsort_partition","_qsort","_quicksort"];

_quicksort = {

	_qsort_swap = {
		private["_left", "_right", "_temp", "_array"];
		_array = _this select 0;
		_left = _this select 1;
		_right = _this select 2;
		_temp = _array select _left;
		_array set [_left, (_array select _right)];
		_array set [_right, _temp];
	};

	_qsort_partition = {
	   private["_left", "_right", "_pivot", "_pivot_value", "_i", "_store_index", "_array"];
	   _array =  _this select 0;
	   _left = _this select 1;
	   _right = _this select 2;
	   _pivot = _this select 3;
	   
	   _pivot_value = _array select _pivot;
	   
		[_array, _pivot, _right] call _qsort_swap;
		_store_index = _left;
		_i = _left;
		while { _i <= (_right - 1) } do {
			if ((_array select _i) < _pivot_value) then {
				[_array, _i, _store_index] call _qsort_swap;
				_store_index = _store_index + 1;
			};
			_i = _i + 1;
		};

		[_array, _store_index, _right] call _qsort_swap;
		_store_index
	};

	_qsort = {
		private["_left", "_right", "_pivot", "_array"];

		_array = _this select 0;
		_left  = _this select 1;
		_right = _this select 2;

		if (not(_left < _right)) exitWith { _array };

		_pivot = floor((_left + _right)/2);
		_pivot = ([_array, _left, _right, _pivot] call _qsort_partition);
	 
		[_array, _left, (_pivot - 1)] call _qsort;
		[_array, (_pivot + 1), _right] call _qsort;
	};

	[_this, 0, ((count _this) - 1)] call _qsort;

};

_this call _quicksort;
