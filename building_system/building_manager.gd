class_name BuildingManager
extends Node

var _buildings: Dictionary = {}
var _root: Node2D
var grid_size = 8


func _init(root: Node2D):
	_root = root


func intersects(building: Building, location: Vector2) -> bool:
	var building_rect = Rect2(location, building.size)
	
	for other in _buildings:
		var other_rect = Rect2(other.position, other.size)
		
		if building_rect.intersects(other_rect):
			return true
	
	return false


func add_building(building: Building, location: Vector2) -> void:
	_root.add_child(building)
	_buildings[building] = building
	if not intersects(building, location):
		building.place(location)


func remove_building(building: Building) -> void:
	_buildings.erase(building)
	if building.can_remove():
		building.remove()


func has_building(bulding: Building) -> bool:
	return bulding in _buildings


func get_building(location: Vector2) -> Building:
	for building in _buildings:
		if building.position == location:
			return building
	return null

