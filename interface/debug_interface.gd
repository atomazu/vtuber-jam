extends PanelContainer

@onready var selected_building_label: Label = $MarginContainer/GridContainer/SelectedBuildingLabel
@onready var screen_position_label: Label = $MarginContainer/GridContainer/ScreenPositionLabel
@onready var grid_position_label: Label = $MarginContainer/GridContainer/GridPositionLabel
@export var enabled: bool = true

func _process(_delta: float) -> void:
	if not enabled:
		visible = false
		return
	if Input.is_action_just_pressed("toggle_debug"):
		visible = not visible
	var mouse_pos = str(Grid.get_mouse_global())
	screen_position_label.text = str(mouse_pos)
	grid_position_label.text = str(Grid.get_mouse_cell())
