class_name BuildingTest
extends Test

var building = Building.new("res://assets/test_building.png", Vector2.ONE)


func _init() -> void:
	add_test("Test Place Building", "test_place_building", true)
	add_test("Test Remove Building", "test_remove_building", true)


func test_place_building() -> bool:
	building.place(Vector2.ONE)
	if building.position == Vector2.ONE:
		return true
	return false


func test_remove_building() -> bool:
	building.remove()
	await get_tree().process_frame
	if is_instance_valid(building):
		return false
	return true
