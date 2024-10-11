class_name Building
extends Node2D

var sprite: Sprite2D
var sprite_path: String
var sprite_death_path: String
var size: Vector2
var shot_area: Area2D
var shot_speed: float
var	firerate: float
var collision_shape: CollisionShape2D
var circle_shape: CircleShape2D
var state: BuildingState
var enemys
var target
var health: int
var damage: int
var projectile
var projectile_type
var projectile_factory = ProjectileFactory.new()
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
	firerate = 60 / building_data.firerate / 60
	shot_speed = building_data.shot_speed
	projectile_type = building_data.shot_type
	health = building_data.health
	damage = building_data.damage


func _process(delta):
	if shot_area.has_overlapping_areas() && state != BuildingState.SHOOTING: shooting()


func _ready() -> void:
	add_child(shot_area)
	shot_area.add_child(collision_shape)
	add_child(sprite)


func place(location: Vector2) -> void:
	position = location


func remove() -> void:
	state = BuildingState.DESTROYED
	remove_child(shot_area)
	sprite.texture = load(sprite_death_path)
	await get_tree().create_timer(2).timeout
	queue_free()



func shooting():
	print(damage)
	state = BuildingState.SHOOTING
	enemys = shot_area.get_overlapping_areas()
	print(enemys[0])
	target = enemys[0].get_parent()
	if is_instance_valid(target): 
		projectile = projectile_factory.create_projectile(projectile_type, damage, shot_speed, target, position)
		get_tree().get_root().add_child.call_deferred(projectile)
		enemys[0].get_parent().get_damaged(damage)
		await get_tree().create_timer(firerate).timeout
	state = BuildingState.IDLE
	print(health)


func get_damaged(got_damage: int):
	health -= got_damage
	if health <= 0:
		remove()
	pass
