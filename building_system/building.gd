class_name Building
extends Node2D


var sprite: Sprite2D
var size: Vector2


func _init(sprite_path, size):
	sprite = Sprite2D.new()
	sprite.texture = load(sprite_path)
	self.size = size
	pass

func place(location) -> void:
	position = location


func can_remove() -> bool:
	return false


func remove() -> void:
	pass
