extends Control

@onready var debug_interface: PanelContainer = $DebugInterface


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_debug"):
		debug_interface.visible = not debug_interface.visible
