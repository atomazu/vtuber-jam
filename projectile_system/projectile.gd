class_name Projectile
extends Node2D

var speed: float
var damage: int
var sprite: Sprite2D
var sprite_path: String
var target
var location


func _init(projectile_data: ProjectileData):
    speed = projectile_data.speed * projectile_data.speed_modifier
    sprite_path = projectile_data.sprite_path
    damage = projectile_data.damage
    target = projectile_data.target
    sprite = Sprite2D.new()
    location = projectile_data.location
    sprite.texture = load(sprite_path)

func _ready():
    add_child(sprite)
    spawn()
    flying()


func spawn():
    position = location

func flying():
    pass
    