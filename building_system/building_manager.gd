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
		var other_rect = Rect2(other.position, other.size)
		
		if building_rect.intersects(other_rect):
			return true
	
	return false


func add_building(type: BuildingFactory.Type, cell: Vector2) -> void:
	var building = _factory.create_bulding(type)
	
	if not building_intersects(building, cell):
		_root.add_child(building)
		_buildings[building] = building
		building.place(Grid.grid_to_screen(cell))


func remove_building(building: Building) -> void:
	_buildings.erase(building)
	building.remove()


func has_building(bulding: Building) -> bool:
	return bulding in _buildings


func get_building(cell: Vector2) -> Building:
	for building in _buildings:
		if building.position == Grid.grid_to_screen(cell):
			return building
	return null
