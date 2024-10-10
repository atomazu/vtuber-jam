extends Node


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("place"):
		# Place currently selected building
		pass
	elif Input.is_action_just_pressed("remove"):
		# Remove building at current position
		pass
