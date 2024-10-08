class_name BuildingManagerTest
extends Test


func _init() -> void:
	add_test("Test Can Place", "test_can_place", true)


func test_can_place() -> bool:
	var root = Node2D.new()
	get_tree().get_root().add_child.call_deferred(root)
	
	var manager = BuildingManager.new(root)
	var building = Building.new("res://assets/test_building.png", Vector2.ONE * 4)
	
	root.queue_free()
	return manager.can_place(building, Vector2(0, 0))
