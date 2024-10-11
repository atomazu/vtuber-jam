extends Node

@onready var building_manager: BuildingManager = BuildingManager.new()


func _ready() -> void:
	add_child(building_manager)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		building_manager.add_building(BuildingFactory.Type.ARROW_TOWER, Grid.get_mouse_cell())
	elif Input.is_action_just_pressed("remove"):
		# Remove building at current position
		pass
