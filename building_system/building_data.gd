class_name BuildingData
extends Resource

var title: String 
var sprite_path: String
var shot_sprite_path: String = ""
var death_sprite_path: String = ""
var health: int = 10
var max_health: int = 10
var damage: int = 1
var shot_range: float = 5.0
var firerate: float = 1.0
var shot_speed: float = 10.0
var shot_type: ProjectileFactory.Type = ProjectileFactory.Type.DEFAULT
var size: Vector2 = Vector2.ONE


func _init(
	new_title: String, 
	new_size: Vector2 = Vector2.ONE,
	new_sprite_path: String = "res://assets/404.png", 
	new_shot_sprite_path: String = "res://assets/404.png", 
	new_death_sprite_path: String = "res://assets/404.png", 
	new_health: int = 10, 
	new_max_health: int = 10,
	new_damage: int = 1, 
	new_shot_range: float = 5.0, 
	new_firerate: float = 1.0, 
	new_shot_speed: float = 10.0,
	new_shot_type: ProjectileFactory.Type = ProjectileFactory.Type.DEFAULT
	):
		title = new_title
		size = new_size
		sprite_path = new_sprite_path
		shot_sprite_path = new_shot_sprite_path
		death_sprite_path = new_death_sprite_path
		health = new_health
		max_health = new_max_health
		damage = new_damage
		shot_range = new_shot_range
		firerate = new_firerate
		shot_speed = new_shot_speed
		shot_type = new_shot_type
