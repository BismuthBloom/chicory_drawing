extends Node

var paused: bool = false

var currColor: Vector2i = Vector2i(1,0)
var currPalette: int = 0
var currStyle: int = 0
var brushSize: int = 3

var drawState: bool = false

var xy_minmax = [Vector2i(0,0), Vector2i(160,90)]
var num_colors: int = 4

var tileSet: TileSet
