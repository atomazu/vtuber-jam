extends Node2D


var cell_size = 32
var grid_display: GridDisplay

func _ready() -> void:
	grid_display = GridDisplay.new()
	grid_display.cell_size = Vector2(cell_size, cell_size)
	add_child(grid_display)


func screen_to_grid(pos: Vector2) -> Vector2:
	return pos / cell_size


func grid_to_screen(pos: Vector2) -> Vector2:
	return pos * cell_size


func get_mouse_cell() -> Vector2:
	return round(get_global_mouse_position() / cell_size)


func get_mouse_global() -> Vector2:
	return get_global_mouse_position()
