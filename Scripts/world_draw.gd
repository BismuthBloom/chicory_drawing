extends TileMapLayer

class_name WorldDraw

# Brush Settings
var prev_pos: Vector2i
var curr_pos: Vector2i
var is_drawing: bool = false
var is_erasing: bool = false





func draw_high(pos0: Vector2i, pos1: Vector2i, color: Vector2i, funct = Definitions.hundred_percent):
	var d = pos1 - pos0
	var xi = 1
	if (d.x < 0):
		xi = -1
		d.x = -d.x
	var D = (2 * d.x) - d.y
	var x = pos0.x
	
	for y in range(pos0.y, pos1.y + 1):
		draw_around_point(Vector2i(x, y), color, funct)
		if (D > 0):
			x += xi
			D += 2 * (d.x - d.y)
		else:
			D += 2*d.x


func draw_low(pos0: Vector2i, pos1: Vector2i, color: Vector2i, funct = Definitions.hundred_percent):
	var d = pos1 - pos0
	var yi = 1
	if (d.y < 0):
		yi = -1
		d.y = -d.y
	var D = (2 * d.y) - d.x
	var y = pos0.y
	
	for x in range(pos0.x, pos1.x + 1):
		draw_around_point(Vector2i(x, y), color, funct)
		if (D > 0):
			y += yi
			D += 2 * (d.y - d.x)
		else:
			D += 2*d.y


# Line algorithm funciton
func custom_draw_line(prev_i: Vector2i, curr_i: Vector2i, color: Vector2i, funct = Definitions.hundred_percent):
	if (prev_i == curr_i):
		# Modify that pixel and return
		set_tile(curr_i, color, funct)
		return
	
	if (absi(curr_i.y - prev_i.y) < absi(curr_i.x - prev_i.x)):
		if (prev_i.x > curr_i.x):
			draw_low(curr_i, prev_i, color, funct)
		else:
			draw_low(prev_i, curr_i, color, funct)
	else:
		if (prev_i.y > curr_i.y):
			draw_high(curr_i, prev_i, color, funct)
		else:
			draw_high(prev_i, curr_i, color, funct)


func set_tile(pos: Vector2i, color: Vector2i, funct = Definitions.hundred_percent):
	if (funct.call(pos.x, pos.y)):
		set_cell(pos, DrawSet.currPalette, color)

func draw_around_point(pos: Vector2i, color: Vector2i, funct = Definitions.hundred_percent):
	set_tile(pos, color, funct)
	
	if (DrawSet.brushSize >= 2):
		set_tile(Vector2i(pos.x-1, pos.y), color, funct)
		set_tile(Vector2i(pos.x+1, pos.y), color, funct)
		set_tile(Vector2i(pos.x, pos.y-1), color, funct)
		set_tile(Vector2i(pos.x, pos.y+1), color, funct)
	
	if (DrawSet.brushSize >= 3):
		set_tile(Vector2i(pos.x-1, pos.y+1), color, funct)
		set_tile(Vector2i(pos.x-1, pos.y-1), color, funct)
		set_tile(Vector2i(pos.x-1, pos.y+1), color, funct)
		set_tile(Vector2i(pos.x-1, pos.y-1), color, funct)
















# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curr_pos = local_to_map(get_local_mouse_position())
	prev_pos = curr_pos
	DrawSet.tileSet = tile_set


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("Brush Menu") && !DrawSet.paused):
		pass
	if (Input.is_action_just_pressed("Reset")):
		clear()
	
	prev_pos = curr_pos 
	curr_pos = local_to_map(get_local_mouse_position())
	
	if (Input.is_action_just_pressed("ChangeColor")):
		DrawSet.currColor.x += 1
		if (DrawSet.currColor.x == DrawSet.num_colors + 1):
			DrawSet.currColor.x = 1
	
	if (Input.is_action_just_pressed("ChangeStyle")):
		DrawSet.currStyle += 1
		if (DrawSet.currStyle == Definitions.masks.size()):
			DrawSet.currStyle = 0
	
	# Sets status of line being drawn
	if (Input.is_action_just_pressed("Draw")):
		DrawSet.drawState = true
		is_drawing = true
	if (Input.is_action_just_pressed("Erase")):
		DrawSet.drawState = true
		is_erasing = true
	if (Input.is_action_just_released("Draw") || Input.is_action_just_released("Erase")):
		is_drawing = false
		is_erasing = false
		DrawSet.drawState = false
	
	if (is_drawing):
		custom_draw_line(prev_pos, curr_pos, DrawSet.currColor, Definitions.masks[DrawSet.currStyle])
	if (is_erasing):
		custom_draw_line(prev_pos, curr_pos, Vector2i(0,0), Definitions.masks[DrawSet.currStyle])
