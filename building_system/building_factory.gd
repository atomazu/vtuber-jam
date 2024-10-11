class_name BuildingFactory

enum Type {
	ARROW_TOWER,
	SNIPER_TOWER
}


static func create_building(type: Type) -> Building:
	var building_data: BuildingData

	match type:
		Type.ARROW_TOWER:
			building_data = BuildingData.new(
				"Arrow Tower",
				Vector2.ONE * 4,
				"res://assets/R.jpeg",
				"",
				"res://assets/RDead.jpg",
				5,
				5,
				1,
				4.0,
				1.0,
				10.0,
				BuildingData.ShotType.ARROW
			)
		Type.SNIPER_TOWER:
			building_data = BuildingData.new(
				"Sniper Tower",
				Vector2.ONE * 4,
				"res://assets/test_building.png",
				"",
				"",
				10,
				10,
				2,
				5.0,
				2.0,
				3.0,
				BuildingData.ShotType.ARROW
			)
		_:
			push_error("Unknown building type: " + str(type))
			return null
	
	var b = Building.new(building_data)
	b.position = Vector2.ZERO
	return b
