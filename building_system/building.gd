class_name Building
extends Node2D


var sprite: Sprite2D
var size: Vector2
var shot_area: Area2D
var shot_speed: float
var collision_shape: CollisionShape2D
var circle_shape: CircleShape2D
var state: BuildingState
var enemys
enum BuildingState {IDLE, SHOOTING, DESTROYED}

func _init(building_data: BuildingData):
	sprite = Sprite2D.new()
	sprite.texture = load(building_data.sprite_path)
	collision_shape = CollisionShape2D.new()
	circle_shape = CircleShape2D.new()
	circle_shape.radius = building_data.shot_range
	collision_shape.shape = circle_shape
	shot_area = Area2D.new()
	size = building_data.size
	shot_speed = building_data.shot_speed


func _ready() -> void:
	shot_area.add_child(collision_shape)
	shot_area.body_entered.connect(_on_body_entered)
	add_child(sprite)


func place(location: Vector2) -> void:
	position = location


func remove() -> void:
	queue_free()



func _on_body_entered():
	state = BuildingState.SHOOTING
	if shot_area.has_overlapping_bodies() && state == BuildingState.SHOOTING:
		await get_tree().create_timer(shot_speed).timeout
		enemys = shot_area.get_overlapping_bodies()
		print(enemys[0])
		_on_body_entered()
	state = BuildingState.IDLE
