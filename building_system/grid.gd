extends Node


var grid_size = 8


func screen_to_grid(pos: Vector2) -> Vector2:
    return pos / grid_size


func grid_to_screen(pos: Vector2) -> Vector2:
    return pos * grid_size


func get_mouse_cell() -> Vector2:
    return DisplayServer.mouse_get_position() / grid_size