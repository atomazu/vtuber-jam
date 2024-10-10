extends Node

@onready var building_manager: BuildingManager = $BuildingManager


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		
		pass
	elif Input.is_action_just_pressed("remove"):
		# Remove building at current position
		pass
