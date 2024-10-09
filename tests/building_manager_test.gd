class_name BuildingManagerTest
extends Test

var root = Node2D.new()
var manager = BuildingManager.new(root)


func _init() -> void:
	add_test("Test Can Place", "test_can_place", true)


func _ready() -> void:
	add_child(root)


func test_placing_intersecting() -> bool:
	var building = Building.new("res://assets/test_building.png", Vector2.ONE * 4)
	
	# Empty field, should be able to place.
	if manager.intersects(building, Vector2.ZERO):
		return false
	
	manager.add_building(building, Vector2.ZERO)
	var other = Building.new("res://assets/test_building.png", Vector2.ONE * 4)
	
	# Building already there, shouldn't be able to place.
	if not other.intersects(building, Vector2.ZERO):
		return false

	return true