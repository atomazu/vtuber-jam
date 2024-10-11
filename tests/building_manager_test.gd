class_name BuildingManagerTest
extends Test

var root = Node2D.new()
var manager = BuildingManager.new(root)
var factory = BuildingFactory
var arrow_tower = factory.create_building(factory.Type.ARROW_TOWER)
var sniper_tower = factory.create_building(factory.Type.SNIPER_TOWER)


func _init() -> void:
	add_test("Empty field, should be able to place.", "test_empty_field_no_intersection", false)
	add_test("Building already there, shouldn't be able to place.", "test_existing_building_intersects", true)
	add_test("Building removed, should not intersect.", "test_removed_building_no_intersection", false)
	add_test("Building added, should be in manager.", "test_added_building_exists_in_manager", true)
	add_test("Building at Vector.ZERO should be returned.", "test_get_building_at_position", true)


func _ready() -> void:
	add_child(root)


func test_empty_field_no_intersection() -> bool:
	# Empty field, should be able to place.
	return manager.building_intersects(arrow_tower, Vector2.ZERO)


func test_existing_building_intersects() -> bool:
	manager.add_building(arrow_tower, Vector2.ZERO)
	
	# Building already there, shouldn't be able to place.
	return manager.building_intersects(arrow_tower, Vector2.ZERO)


func test_removed_building_no_intersection() -> bool:
	manager.remove_building(arrow_tower)

	# Building removed, should not intersect.
	return manager.building_intersects(arrow_tower, Vector2.ZERO)


func test_added_building_exists_in_manager() -> bool:
	manager.add_building(sniper_tower, Vector2.ZERO)
	
	# Building added, should be in manager.
	return manager.has_building(sniper_tower)


func test_get_building_at_position() -> bool:
	# Building at Vector.ZERO should be returned.
	return manager.get_building(Vector2.ZERO) == sniper_tower
