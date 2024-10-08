extends Node

# Run every test and print the results
func _ready() -> void:
	var results = {}
	for child in get_children():
		if child is Test:
			var result = {}
			result = child.test()
			results[child] = result
	
	print(results)
