extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("Brush Menu") && !DrawSet.paused):
		open_menu()
	elif (Input.is_action_just_pressed("Brush Menu") && DrawSet.paused):
		close_menu()

func open_menu():
	visible = true
	get_tree().paused = true
	DrawSet.paused = true

func close_menu():
	visible = false
	DrawSet.paused = false
	get_tree().paused = false


func _on_big_pressed() -> void:
	DrawSet.brushSize = 3


func _on_medium_pressed() -> void:
	DrawSet.brushSize = 2


func _on_small_pressed() -> void:
	DrawSet.brushSize = 1


func _on_100percent_pressed() -> void:
	DrawSet.currStyle = 0


func _on_horizontal_pressed() -> void:
	DrawSet.currStyle = 1


func _on_vertical_pressed() -> void:
	DrawSet.currStyle = 2


func _on_50percent_pressed() -> void:
	DrawSet.currStyle = 3


func _on_25percent_pressed() -> void:
	DrawSet.currStyle = 4


func _on_c1_pressed() -> void:
	DrawSet.currColor = Vector2i(1,0)


func _on_c2_pressed() -> void:
	DrawSet.currColor = Vector2i(2,0)


func _on_c3_pressed() -> void:
	DrawSet.currColor = Vector2i(3,0)


func _on_c4_pressed() -> void:
	DrawSet.currColor = Vector2i(4,0)
