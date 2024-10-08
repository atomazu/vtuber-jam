class_name BuildingManager
extends Node

var _buildings: Dictionary = {}


func can_place(building: Building, location: int) -> bool:
	return building.can_place()


func place(building: Building, location: int) -> void:
	_buildings[building] = building
	if building.can_place(location):
		building.place()


func remove(building: Building) -> void:
	_buildings.erase(building)
	if building.can_remove():
		building.remove()
