extends Node

# Onready variables
@onready var exam_tree: Tree = $CanvasLayer/Interface/PanelContainer/MarginContainer/VBoxContainer/ExamTree
@onready var exam_list: Node = $ExamList
@onready var exit_button: Button = $CanvasLayer/TestControls/ExitButton
@onready var next_step_button: Button = $CanvasLayer/TestControls/NextButton
@export var wait_for_user_input: bool = false
@onready var status_label: Label = $CanvasLayer/Interface/PanelContainer/MarginContainer/VBoxContainer/StatusLabel

# Member variables
var root: TreeItem
var current_exam_item: TreeItem

# Lifecycle methods
func _ready() -> void:
	_connect_signals()
	if wait_for_user_input:
		next_step_button.text = "Run"
		next_step_button.disabled = false
	else:
		status_label.text = "Auto-starting tests..."
	await wait_for_next_button(wait_for_user_input, "Ready to start tests") 
	run()

# Main functionality
func run() -> void:
	_initialize_tree()
	status_label.text = "Running tests..."
	await run_exams()
	next_step_button.text = "DONE"
	next_step_button.disabled = true
	status_label.text = "All tests completed"

func run_exams() -> void:
	for child in exam_list.get_children():
		if child is Test and child.enabled:
			await _process_exam(child)
		child.cleanup()

# Exam processing
func _process_exam(child: Test) -> void:
	_setup_step_button(child)
	status_label.text = "Preparing test: " + child.name
	#await wait_for_next_button(child.in_steps)
	_update_step_button_for_test_start(child)
	
	child.connect("test_completed", _on_test_completed)
	current_exam_item = create_exam_item(root, child.name, true)
	status_label.text = "Running test: " + child.name
	await wait_for_next_button(child.in_steps)
	
	var result: Dictionary = await child.test()
	update_exam_item(current_exam_item, result)
	
	_prepare_for_next_test()

# Signal handlers
func _on_test_completed(test_data: Dictionary) -> void:
	add_test_to_tree(current_exam_item, test_data)
	status_label.text = "Test completed: " + test_data.id

func wait_for_next_button(wait, string = "Waiting for user input..."):
	if wait:
		status_label.text = string
		await next_step_button.pressed
	return OK

# Tree manipulation
func create_exam_item(parent: TreeItem, exam_name: String, manual: bool = false) -> TreeItem:
	var exam_item: TreeItem = exam_tree.create_item(parent)
	exam_item.set_text(0, exam_name)
	exam_item.set_text(1, "Click To Proceed..." if manual else "Running...")
	exam_item.collapsed = false
	return exam_item

func update_exam_item(exam_item: TreeItem, exam_result: Dictionary) -> void:
	exam_item.set_text(1, "Success: " + str(exam_result.result))
	exam_item.collapsed = true
	status_label.text = "Test result: " + ("Success" if exam_result.result else "Failure")

func add_test_to_tree(parent: TreeItem, test: Dictionary) -> void:
	var test_item: TreeItem = exam_tree.create_item(parent)
	test_item.set_text(0, test.id)
	test_item.set_text(1, "Success: " + str(test.success))
	test_item.collapsed = test.success

	exam_tree.create_item(test_item).set_text(0, "Expected: " + str(test.expected))
	exam_tree.create_item(test_item).set_text(0, "Returned: " + str(test.returned))

# Helper methods
func _connect_signals() -> void:
	exit_button.pressed.connect((
		func _on_exit_button_pressed(): 
			status_label.text = "Quitting..."
			get_tree().quit()
	))

func _initialize_tree() -> void:
	exam_tree.clear()
	root = exam_tree.create_item()
	exam_tree.hide_root = true
	status_label.text = "Test tree initialized"

func _setup_step_button(child: Test) -> void:
	next_step_button.disabled = not child.in_steps
	next_step_button.text = "Auto" if not child.in_steps else "Start"
	child.step_button = next_step_button
	status_label.text = "Test setup: " + child.name

func _update_step_button_for_test_start(child: Test) -> void:
	if child.in_steps:
		next_step_button.text = "Next"
		status_label.text = "Test started: " + child.name

func _prepare_for_next_test() -> void:
	next_step_button.text = "Loading.."
	next_step_button.disabled = true
	status_label.text = "Preparing for next test..."
