class_name Test
extends Node

## The tests added through add_test are stored here
var tests: Array = []

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
			"method": t.method,
			"expected": t.expected,
			"returned": call(t.method),
		}
		var success = results.tests[t.id].returned == results.tests[t.id].expected
		results.tests[t.id]["success"] = success
		if not success:
			results.result = false
	
	return results

## Call to add a test
func add_test(id, method, expected) -> void:
	tests.append({
		"id": id,
		"method": method,
		"expected": expected
		})
