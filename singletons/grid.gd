extends Node2D

var cell_size = 16
var grid_size = Vector2(65, 65)
var _grid_display: GridDisplay
var _draw_queue = []


func _ready() -> void:
	_grid_display = get_tree().get_first_node_in_group("grid_display")
	update_grid_display()


func update_grid_display() -> void:
	_grid_display.cell_size = Vector2(cell_size, cell_size)
	_grid_display.grid_size = grid_size
	_grid_display.position = -(grid_size * cell_size) / 2
	_grid_display.queue_redraw()


func world_to_grid(pos: Vector2) -> Vector2:
	return pos / cell_size


func grid_to_world(pos: Vector2) -> Vector2:
	return pos * cell_size - Vector2.ONE * cell_size / 2


func get_mouse_cell() -> Vector2:
	return round(get_global_mouse_position() / cell_size)


func get_mouse_global() -> Vector2:
	return get_global_mouse_position()


func highlight_cell(pos: Vector2) -> void:
	if (pos.x > -grid_size.x / 2 and pos.x < grid_size.x / 2
	and pos.y > -grid_size.y / 2 and pos.y < grid_size.y / 2):
		var rect = Rect2(grid_to_world(pos), Vector2(cell_size, cell_size))
		_draw_queue.append({"rect": rect})
	queue_redraw()


func _draw() -> void:
	for item in _draw_queue:
		draw_rect(item.rect, Color(1, 1, 1, 0.1), true)
		_draw_queue.erase(item)


func toggle_grid(grid: bool, border: bool = true) -> void:
	_grid_display.draw_border = border
	_grid_display.draw_grid = grid


func update_opacity(opacity: float):
	_grid_display.border_color.a = opacity
	_grid_display.hline_color.a = opacity
	_grid_display.vline_color.a = opacity
