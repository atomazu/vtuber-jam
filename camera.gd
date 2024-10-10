extends Camera2D

@export var cam_speed: float = 750.0
@export var zoom_speed: float = 70.0
@export var min_zoom: float = 1.0
@export var max_zoom: float = 6.0
@export var camera_bounds: Vector2 = Vector2(250, 250)

var target_zoom: Vector2 = zoom
var velocity: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	update_movement(delta)
	update_zoom(delta)
	apply_bounds()


func update_movement(delta: float) -> void:
	velocity = get_input_velocity() * delta / zoom
	position += velocity
	velocity = Vector2.ZERO


func update_zoom(delta: float) -> void:
	zoom = zoom.lerp(target_zoom, delta * zoom_speed)
	zoom = zoom.clamp(Vector2.ONE * min_zoom, Vector2.ONE * max_zoom)


func apply_bounds() -> void:
	position = position.clamp(-camera_bounds, camera_bounds)


func get_input_velocity() -> Vector2:
	var input_velocity = Vector2.ZERO
	input_velocity.x = Input.get_axis("cam_left", "cam_right")
	input_velocity.y = Input.get_axis("cam_up", "cam_down")
	return input_velocity * cam_speed


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				target_zoom *= 1.1
			MOUSE_BUTTON_WHEEL_DOWN:
				target_zoom *= 0.9
