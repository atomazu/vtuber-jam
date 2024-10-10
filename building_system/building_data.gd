class_name BuildingData
extends Resource

func _init(
	new_title: String, 
	new_sprite_path: String, 
	new_shot_sprite_path: String, 
	new_death_sprite_path: String, 
	new_health: int, 
	new_max_health: int,
	new_damage: int, 
	new_shot_range: float, 
	new_firerate: float, 
	new_shot_speed: float,
	new_shot_type: ShotType, 
	new_size: Vector2
	):
		title = new_title
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
		size = new_size

enum ShotType {
	DEFAULT
}

var title: String 
var sprite_path: String
var shot_sprite_path: String
var death_sprite_path: String
var health: int
var max_health: int
var damage: int
var shot_range: float
var firerate: float
var shot_speed: float
var shot_type: ShotType
var size: Vector2
