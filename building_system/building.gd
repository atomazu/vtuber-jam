class_name Building
extends Node2D


var sprite: Sprite2D
var size: Vector2


func _init(sprite_path: String, new_size: Vector2):
	sprite = Sprite2D.new()
	sprite.texture = load(sprite_path)
	size = new_size


func _ready() -> void:
	add_child(sprite)


func place(location: Vector2) -> void:
	position = location


func can_remove() -> bool:
	return false


func remove() -> void:
	pass
