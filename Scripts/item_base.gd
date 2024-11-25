extends Node2D


# Input process












# Set Color
func set_color(color: Vector2i):
	reset_color()
	# get atlas color here
	color.x *= 12
	var temp: TileSetAtlasSource = DrawSet.tileSet.get_source(0)
	self_modulate = temp.texture.data.get_pixelv(color)
	

# Reset Color
func reset_color():
	self_modulate = Color(1, 1, 1, 1)
