class_name BuildingManager
extends Node

var _buildings: Dictionary = {}
var _root: Node2D
var selected_building = ""
var _factory = BuildingFactory

var _instance_names = [
	"Alpha", "Beta", "Gamma", "Delta", "Epsilon",
	"Zeta", "Eta", "Theta", "Iota", "Kappa",
	"Lambda", "Mu", "Nu", "Xi", "Omicron",
	"Pi", "Rho", "Sigma", "Tau", "Upsilon",
	"Phi", "Chi", "Psi", "Omega"
]

func _init(root: Node2D = null):
	_root = root


func _ready() -> void:
	if _root == null:
		_root = get_tree().get_first_node_in_group("bm_root")


func building_intersects(building: Building, cell: Vector2) -> bool:
	var building_rect = Rect2(cell, building.size)
	
	if not Grid.rect_in_bounds(building_rect):
		return true
	
	for other in _buildings:
		if other != building:
			var other_rect = Rect2(Grid.world_to_grid(other.position), other.size)
			if building_rect.intersects(other_rect):
				return true
	return false



func add_building(building, cell: Vector2):
	var created_with_type = false
	if building is BuildingFactory.Type:
		building = _factory.create_building(building)
		created_with_type = true
	
	if not building_intersects(building, cell):
		_root.add_child(building)
		_buildings[building] = building
		building.has_died.connect(_on_building_has_died.bind(building))
		building.place(Grid.grid_to_world(cell))
		
		building.set_meta("name", _instance_names[building.get_instance_id() % _instance_names.size()])
		if created_with_type:
			return building
	else:
		if created_with_type:
			building.destroy()
		push_warning("Building intersects, can't place! (Cell: %s)" % str(cell))


func _on_building_has_died(building):
	if _buildings.has(building):
		_buildings.erase(building)


func remove_building(building: Building) -> void:
	if _buildings.has(building):
		_buildings.erase(building)
		building.remove()
	else:
		push_warning("Building isn't in building list!")


func has_building(building: Building) -> bool:
	return _buildings.has(building)


func get_building(cell: Vector2) -> Building:
	for building in _buildings:
		if building.position == Grid.grid_to_world(cell):
			return building
	return null
