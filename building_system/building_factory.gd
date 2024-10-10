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
					"res://assets/RDead.jpg",
					5,
					0,
					1,
					4,
					0,
					10,
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
					10,
					0,
					2,
					5,
					0,
					3,
					BuildingData.ShotType.DEFAULT,
					Vector2.ONE
				)
			)
	return
