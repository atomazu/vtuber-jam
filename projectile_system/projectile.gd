class_name Projectile
extends CharacterBody2D

var speed: float
var damage: int
var sprite: Sprite2D
var sprite_path: String
var target
var location
var target_position


func _init(projectile_data: ProjectileData):
	speed = projectile_data.speed * projectile_data.speed_modifier
	sprite_path = projectile_data.sprite_path
	damage = projectile_data.damage
	target = projectile_data.target
	sprite = Sprite2D.new()
	location = projectile_data.location
	sprite.texture = load(sprite_path)
	target_position = target.position


func _process(delta):
	position = position.move_toward(target_position, delta * speed)
	if position == target_position:
		deal_damage()

func _ready():
	add_child(sprite)
	spawn()
	look_at(target_position)


func spawn():
	position = location


func remove():
	queue_free()


func deal_damage():
	if is_instance_valid(target):
		target.get_damaged(damage)
	remove()
