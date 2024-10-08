extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var results = {}
	for child in get_children():
		var result = {}
		if child is Test:
			result = child.test()
		results[child] = result
	
	print(results)
