class_name BuildingData
extends Resource

func _init(
	new_title: String, 
	new_sprite_path: String, 
	new_shot_sprite_path: String, 
	death_sprite_path: String, 
	new_health: int, 
	new_max_health: int,
	new_damage: int, 
	new_range: float, 
	new_firerate: float, 
	new_shot_speed: float,
	new_shot_type: ShotType, 
	new_size: Vector2
	):
		pass

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
var range: float
var firerate: float
var shot_speed: float
var shot_type: ShotType
var size: Vector2
