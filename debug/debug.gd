extends CanvasLayer

var debug_label: Label
var debug_interface: PanelContainer
var debug_info: Dictionary = {}

var enabled: bool = OS.is_debug_build()
const DEBUG = preload("res://debug/debug.tscn")

func _ready() -> void:
	add_child(DEBUG.instantiate())
	
	debug_interface = $DebugInterface
	debug_label = $DebugInterface/MarginContainer/DebugLabel

func _process(delta: float) -> void:
	if not enabled:
		debug_interface.visible = false
		return
	if Input.is_action_just_pressed("toggle_debug"):
		debug_interface.visible = not debug_interface.visible
	
	update_debug_info(delta)
	update_debug_label()

func update_debug_info(delta: float) -> void:
	# Basic info
	debug_info["FPS"] = Engine.get_frames_per_second()
	debug_info["Frame Time"] = "%.2f ms" % (delta * 1000)
	
	# Mouse and grid info
	debug_info["Screen Position"] = str(Grid.get_mouse_global())
	debug_info["Grid Position"] = str(Grid.get_mouse_cell())
	
	# Scene info
	debug_info["Node Count"] = get_tree().get_node_count()
	debug_info["Orphan Node Count"] = Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT)

	Grid.highlight_cell(Grid.get_mouse_cell())

func update_debug_label() -> void:
	var debug_text = ""
	for key in debug_info.keys():
		debug_text += key + ": " + str(debug_info[key]) + "\n"
	debug_label.text = debug_text

func add_debug_info(key: String, value) -> void:
	debug_info[key] = value

func remove_debug_info(key: String) -> void:
	debug_info.erase(key)
