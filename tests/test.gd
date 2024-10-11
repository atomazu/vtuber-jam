class_name Test
extends Node

## The tests added through add_test are stored here
var tests: Array = []
@export var enabled: bool = false
@export var in_steps: bool = false
var step_button: Button
signal test_completed(data)

## Implement this in your tests
func _init() -> void:
	#add_test("Test Example", "test_example_method", 42)
	pass

## This function tests every test in the tests dictionary
func test() -> Dictionary:
	var results = {
		"result": true,
		"tests": {}
		}
	
	for t in tests:
		results.tests[t.id] = {
			"id": t.id,
			"method": t.method,
			"expected": t.expected,
			"returned": await call_test(t.method),
		}
		var success = results.tests[t.id].returned == results.tests[t.id].expected
		results.tests[t.id]["success"] = success
		if not success:
			results.result = false
		
		test_completed.emit(results.tests[t.id])
		if in_steps:
			await step_button.pressed
	
	return results

## Call to add a test
func add_test(id, method, expected) -> void:
	tests.append({
		"id": id,
		"method": method,
		"expected": expected,
		})

## Call method if it exist, else return null
func call_test(method):
	if has_method(method):
		return await call(method)
	return null


func cleanup():
	queue_free()
