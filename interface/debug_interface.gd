extends PanelContainer

@onready var selected_building_label: Label = $MarginContainer/GridContainer/SelectedBuildingLabel
@onready var screen_position_label: Label = $MarginContainer/GridContainer/ScreenPositionLabel
@onready var grid_position_label: Label = $MarginContainer/GridContainer/GridPositionLabel

func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	screen_position_label.text = str(mouse_pos)
	grid_position_label.text = str(Grid.get_mouse_cell())
