extends Node

@onready var exam_tree: Tree = $CanvasLayer/Interface/PanelContainer/MarginContainer/VBoxContainer/ExamTree
@onready var exam_list: Node = $ExamList
@onready var rerun_button: Button = $CanvasLayer/TestControls/RerunButton
@onready var exit_button: Button = $CanvasLayer/TestControls/ExitButton

func _ready() -> void:
	rerun_button.pressed.connect(run)
	exit_button.pressed.connect(get_tree().quit)
	run()

func run() -> void:
	exam_tree.clear()
	var exam_results: Dictionary = await run_exams()
	create_result_tree(exam_results)

func run_exams() -> Dictionary:
	var exam_results: Dictionary = {}
	for child in exam_list.get_children():
		if child is Test and child.enabled:
			var result: Dictionary = await child.test()
			result["id"] = child.name
			exam_results[child.name] = result
	return exam_results

func create_result_tree(exam_results: Dictionary) -> void:
	var root: TreeItem = exam_tree.create_item()
	exam_tree.hide_root = true
	
	for exam in exam_results.values():
		var exam_item: TreeItem = create_exam_item(root, exam)
		create_test_items(exam_item, exam.tests)

func create_exam_item(parent: TreeItem, exam: Dictionary) -> TreeItem:
	var exam_item: TreeItem = exam_tree.create_item(parent)
	exam_item.set_text(0, exam.id)
	exam_item.set_text(1, "Success: " + str(exam.result))
	exam_item.collapsed = true
	return exam_item

func create_test_items(parent: TreeItem, tests: Dictionary) -> void:
	for test in tests.values():
		var test_item: TreeItem = exam_tree.create_item(parent)
		test_item.set_text(0, test.id)
		test_item.set_text(1, "Success: " + str(test.success))
		test_item.collapsed = test.success

		exam_tree.create_item(test_item).set_text(0, "Expected: " + str(test.expected))
		exam_tree.create_item(test_item).set_text(0, "Returned: " + str(test.returned))
