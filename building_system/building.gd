class_name Building
extends Node2D

signal has_died

@onready var projectile_parent = get_tree().get_first_node_in_group("projectiles")

var sprite: Sprite2D
var sprite_path: String
var sprite_death_path: String
var size: Vector2
var shot_area: Area2D
var shot_speed: float
var	firerate: float
var collision_shape: CollisionShape2D
var collision_shape_buidling: CollisionShape2D
var circle_shape: CircleShape2D
var square_shape: RectangleShape2D
var state: BuildingState
var enemys
var target
var health: int
var damage: int
var projectile
var projectile_type
var projectile_factory = ProjectileFactory

enum BuildingState { IDLE, SHOOTING, DESTROYED }


func _init(building_data: BuildingData):
	size = building_data.size
	sprite = Sprite2D.new()
	sprite_path = building_data.sprite_path
	sprite_death_path = building_data.death_sprite_path
	sprite.texture = load(sprite_path)
	circle_shape = CircleShape2D.new()
	circle_shape.radius = building_data.shot_range * Grid.cell_size
	square_shape = RectangleShape2D.new()
	square_shape.size = size * Grid.cell_size

	
	collision_shape = CollisionShape2D.new()
	collision_shape.shape = circle_shape
	collision_shape_buidling = CollisionShape2D.new()
	collision_shape_buidling.shape = square_shape
	
	shot_area = Area2D.new()
	
	firerate = 60 / building_data.firerate / 60
	shot_speed = building_data.shot_speed
	projectile_type = building_data.shot_type
	health = building_data.health
	damage = building_data.damage
	print(square_shape.size)
	print(Grid.cell_size)
	print(size)


func _process(_delta):
	if shot_area.has_overlapping_areas() && state != BuildingState.SHOOTING: shooting()


func _ready() -> void:
	add_child(shot_area)
	add_child(sprite)
	add_child(collision_shape_buidling)
	shot_area.add_child(collision_shape)


func place(location: Vector2) -> void:
	position = location


func remove() -> void:
	state = BuildingState.DESTROYED
	sprite.texture = load(sprite_death_path)
	collision_shape.disabled = true
	
	await get_tree().create_timer(2).timeout
	has_died.emit()
	
	destroy()


func destroy():
	sprite.queue_free()
	collision_shape.queue_free()
	shot_area.queue_free()
	collision_shape_buidling.queue_free()
	queue_free()


func shooting():
	state = BuildingState.SHOOTING
	enemys = shot_area.get_overlapping_areas()
	target = enemys[0].get_parent()
	if is_instance_valid(target): 
		projectile = projectile_factory.create_projectile(projectile_type, damage, shot_speed, target, position)
		projectile_parent.add_child.call_deferred(projectile)
		await get_tree().create_timer(firerate).timeout
	state = BuildingState.IDLE
	print("Damage: ", damage,  " | Target: ", target.get_meta("name"), " | Health: ", health)


func get_damaged(got_damage: int):
	health -= got_damage
	if health <= 0:
		remove()
	pass
