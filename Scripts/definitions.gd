extends Node


# BRUSH FUNCTORS

func hundred_percent(_x,_y) -> bool:
	return true

func horizontal_lines(_x,_y) -> bool:
	return _y % 2 == 0

func vertical_lines(_x,_y) -> bool:
	return _x % 2 == 0

func fifty_percent(_x,_y) -> bool:
	return (_x + _y) % 2 == 0

func twentyfive_percent(_x,_y) -> bool:
	return (_y % 2 == 1 && _x % 4 == 0) || (_y % 2 == 0 && _x % 4 == 2)

# FUNCTOR LIST
var masks = [hundred_percent, horizontal_lines, vertical_lines, fifty_percent, twentyfive_percent]
