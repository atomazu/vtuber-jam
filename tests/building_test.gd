class_name BuildingTest
extends Test

var factory = BuildingFactory
var arrow_tower = factory.create_building(factory.Type.ARROW_TOWER)
var sniper_tower = factory.create_building(factory.Type.SNIPER_TOWER)
var sniper_tower2 = factory.create_building(factory.Type.SNIPER_TOWER)


func _init() -> void:
	add_test("Test Place Building", "test_place_building", true)
	#add_test("Test Remove Building", "test_remove_building", true)


func test_place_building() -> bool:
	add_child(arrow_tower)
	add_child(sniper_tower)
	add_child(sniper_tower2)
	arrow_tower.place(Grid.grid_to_world(Vector2.ONE * 2))
	sniper_tower.place(Grid.grid_to_world(Vector2.ONE * 4))
	sniper_tower2.place(Grid.grid_to_world(Vector2.ONE * 3))
	if arrow_tower.position == Grid.grid_to_world(Vector2(2, 2)):
		return true
	return false


func test_remove_building() -> bool:
	arrow_tower.remove()
	await get_tree().process_frame
	if is_instance_valid(arrow_tower):
		return false
	return true
