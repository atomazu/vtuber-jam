class_name BuildingManager
extends Node

var _buildings: Dictionary = {}
var _root: Node2D
var selected_building = ""
var _factory = BuildingFactory.new()

func _init(root: Node2D = null):
	_root = root


func _ready() -> void:
	if _root == null:
		_root = get_tree().get_first_node_in_group("bm_root")


func building_intersects(building: Building, cell: Vector2) -> bool:
	var building_rect = Rect2(cell, building.size)
	
	for other in _buildings:
		if other != building:
			var other_rect = Rect2(Grid.world_to_grid(other.position), other.size)
			if building_rect.intersects(other_rect):
				return true
	return false


func add_building(building, cell: Vector2) -> void:
	if building is BuildingFactory.Type:
		building = _factory.create_bulding(building)
	
	if not building_intersects(building, cell):
		_root.add_child(building)
		_buildings[building] = building
		building.place(Grid.grid_to_world(cell))
	else:
		push_warning("Building intersects, can't place! (Cell: %s)" % str(cell))


func remove_building(building: Building) -> void:
	if _buildings.has(building):
		_buildings.erase(building)
		building.remove()
	else:
		push_warning("Building isn't in building list!")


func has_building(building: Building) -> bool:
	return _buildings.has(building)


func get_building(cell: Vector2) -> Building:
	for building in _buildings:
		if building.position == Grid.grid_to_world(cell):
			return building
	return null
