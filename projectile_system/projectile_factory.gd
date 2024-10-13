class_name ProjectileFactory

enum Type { DEFAULT, ARROW }


static func create_projectile(type: Type, damage: int, speed_modifier: float, target, spawn) -> Projectile:
	match type:
		Type.ARROW:
			return Projectile.new(
				ProjectileData.new(
					"res://assets/Arrow.jpeg",
					damage,
					speed_modifier,
					0.5,
					target,
					spawn
				)
			)
	return
