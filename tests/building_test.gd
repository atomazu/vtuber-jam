class_name BuildingTest
extends Test

var buildingfactory = BuildingFactory.new()
var building = buildingfactory.create_bulding(BuildingFactory.Type.ARROW_TOWER)
var building2 = buildingfactory.create_bulding(buildingfactory.Type.SNIPER_TOWER)


func _init() -> void:
	add_test("Test Place Building", "test_place_building", true)
	#add_test("Test Remove Building", "test_remove_building", true)


func test_place_building() -> bool:
	add_child(building)
	building.place(Vector2.ONE * 4)
	if building.position == Vector2.ONE * 4:
		return true
	return false


func test_remove_building() -> bool:
	building.remove()
	await get_tree().process_frame
	if is_instance_valid(building):
		return false
	return true
