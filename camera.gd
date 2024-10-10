extends Camera2D

var cam_speed = 750
var velocity = Vector2.ZERO

var min_x = -250
var max_x = 250
var min_y = -250
var max_y = 250
var new_zoom = zoom
var zoom_speed = 70


func _process(delta: float) -> void:
	move_cam(delta)
	
	position += velocity
	velocity = Vector2.ZERO
	zoom = lerp(zoom, new_zoom, delta * zoom_speed)
	zoom = clamp(zoom, Vector2.ONE, Vector2.ONE * 6)
	
	# Apply camera bounds
	position.x = clamp(position.x, min_x, max_x)
	position.y = clamp(position.y, min_y, max_y)


func move_cam(delta: float) -> void:
	if Input.is_action_pressed("cam_right"):
		velocity.x = cam_speed * delta
	elif Input.is_action_pressed("cam_left"):
		velocity.x = -cam_speed * delta
	if Input.is_action_pressed("cam_up"):
		velocity.y = -cam_speed * delta
	elif Input.is_action_pressed("cam_down"):
		velocity.y = cam_speed * delta
	
	velocity /= zoom


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			new_zoom = zoom * 1.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			new_zoom = zoom * 0.9
