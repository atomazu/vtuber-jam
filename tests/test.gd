class_name Test
extends Node

# Overwrite in sub classes
func test() -> Dictionary:
	# Your testing logic here
	return {
		"result": false,
		"tests": [
			{
				"name": "test1",
				"result": false,
				"error": "Expected x, but got y."
			}
		]
	}
