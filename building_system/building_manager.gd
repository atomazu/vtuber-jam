class_name BuildingManager
extends Node

var _buildings: Dictionary = {}
var _root: Node2D

func _init(root: Node2D):
	_root = root


func can_place(building: Building, location: Vector2) -> bool:
	var building_rect = Rect2(location, building.size)
	
	for other in _buildings:
		var other_rect = Rect2(other.position, other.size)
		
		if building_rect.intersects(other_rect):
			return false
	
	return true


func place(building: Building, location: Vector2) -> void:
	_root.add_child(building)
	_buildings[building] = building
	if can_place(building, location):
		building.place(location)


func remove(building: Building) -> void:
	_buildings.erase(building)
	if building.can_remove():
		building.remove()


func can_remove(bulding: Building, location: Vector2) -> bool:
	return true
