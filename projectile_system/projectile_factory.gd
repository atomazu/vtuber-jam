class_name ProjectileFactory


func create_projectile(type: BuildingData.ShotType, damage: int, speed_modifier: float, target, spawn) -> Projectile:
    match type:
        BuildingData.ShotType.ARROW:
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