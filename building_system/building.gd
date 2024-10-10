class_name Building
extends Node2D

var parent = get_parent()
var sprite: Sprite2D
var sprite_path: String
var sprite_death_path: String
var size: Vector2
var shot_area: Area2D
var shot_speed: float
var collision_shape: CollisionShape2D
var circle_shape: CircleShape2D
var state: BuildingState
var enemys
var health
var damage
enum BuildingState {IDLE, SHOOTING, DESTROYED}

func _init(building_data: BuildingData):
	sprite = Sprite2D.new()
	sprite_path = building_data.sprite_path
	sprite_death_path = building_data.death_sprite_path
	sprite.texture = load(sprite_path)

	
	circle_shape = CircleShape2D.new()
	circle_shape.radius = building_data.shot_range * Grid.cell_size
	
	collision_shape = CollisionShape2D.new()
	collision_shape.shape = circle_shape
	
	shot_area = Area2D.new()
	
	
	size = building_data.size
	shot_speed = building_data.shot_speed
	health = building_data.health
	damage = building_data.damage


func _ready() -> void:
	add_child(shot_area)
	shot_area.add_child(collision_shape)
	shot_area.area_entered.connect(_on_body_entered)
	add_child(sprite)


func place(location: Vector2) -> void:
	position = location


func remove() -> void:
	state = BuildingState.DESTROYED
	remove_child(shot_area)
	sprite.texture = load(sprite_death_path)
	await get_tree().create_timer(2).timeout
	queue_free()



func _on_body_entered(body):
	print("hi")
	state = BuildingState.SHOOTING
	if shot_area.has_overlapping_areas() && state == BuildingState.SHOOTING:
		await get_tree().create_timer(shot_speed).timeout
		if not shot_area.has_overlapping_areas(): return
		enemys = shot_area.get_overlapping_areas()
		print(enemys[0])
		enemys[0].get_parent().get_damaged(damage)
		_on_body_entered(body)
	state = BuildingState.IDLE


func get_damaged(got_damage: int):
	health -= got_damage
	if health <= 0:
		remove()
	pass
