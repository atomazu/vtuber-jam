class_name BuildingFactory

enum Type{
	ARROW_TOWER,
	SNIPER_TOWER
}

func create_bulding(type: Type) -> Building:
	match type:
		Type.ARROW_TOWER:
			return Building.new(
				BuildingData.new(
					"Arrow Tower",
					"res://assets/R.jpeg",
					"",
					"",
					0,
					0,
					0,
					0,
					0,
					3,
					BuildingData.ShotType.DEFAULT,
					Vector2.ONE

				)
			)
		Type.SNIPER_TOWER:
			return Building.new(
				BuildingData.new(
					"Arrow Tower",
					"res://assets/test_building.png",
					"",
					"",
					0,
					0,
					0,
					0,
					0,
					10,
					BuildingData.ShotType.DEFAULT,
					Vector2.ONE
				)
			)
	return
