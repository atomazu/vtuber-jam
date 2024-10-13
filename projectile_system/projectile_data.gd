class_name ProjectileData
extends Resource

var damage: int
var speed_modifier: float
var sprite_path
var speed
var target
var location


func _init(new_sprite_path, new_damage: int, new_speed_modifier: float, new_speed: float, new_target, spawn):
	sprite_path = new_sprite_path
	damage = new_damage
	speed_modifier = new_speed_modifier
	speed = new_speed
	target = new_target
	location = spawn
	
