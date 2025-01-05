extends Node2D

var cell_size = 16
var grid_size = Vector2(65, 65)
var _grid_display: GridDisplay
var _draw_queue = []


func _ready() -> void:
	_grid_display = get_tree().get_first_node_in_group("grid_display")
	update_grid_display()
	Debug.add_debug_info("Cell Size", cell_size)
	Debug.add_debug_info("Grid Size", grid_size)


func _process(delta: float) -> void:
	highlight_cell(get_mouse_cell())


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
	if is_in_bounds(pos):
		var rect = Rect2(grid_to_world(pos), Vector2(cell_size, cell_size))
		_draw_queue.append({"rect": rect})
	queue_redraw()


func is_in_bounds(cell) -> bool:
	return (cell.x > -grid_size.x / 2 and cell.x < grid_size.x / 2
	and cell.y > -grid_size.y / 2 and cell.y < grid_size.y / 2)


func rect_in_bounds(rect: Rect2) -> bool:
	var half_size = rect.size / 2
	var top_left = rect.position - half_size
	var bottom_right = rect.position + half_size
	
	return (is_in_bounds(top_left) and 
			is_in_bounds(bottom_right) and
			is_in_bounds(Vector2(top_left.x, bottom_right.y)) and
			is_in_bounds(Vector2(bottom_right.x, top_left.y)))


func _draw() -> void:
	for item in _draw_queue:
		draw_rect(item.rect, Color(1, 1, 1, 0.1), true)
		_draw_queue.erase(item)


func toggle_grid(grid: bool, border: bool = true) -> void:
	_grid_display.draw_border = border
	_grid_display.draw_grid = grid


func update_opacity(opacity: float):
	#_grid_display.border_color.a = opacity
	_grid_display.hline_color.a = opacity
	_grid_display.vline_color.a = opacity


func get_opacity() -> float:
	return _grid_display.hline_color.a
