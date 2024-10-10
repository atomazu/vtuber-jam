class_name BuildingFactory

enum Type{
	ARROW_TOWER
}

func create_bulding(type: Type) -> Building:
	match type:
		Type.ARROW_TOWER:
			pass # create and return building here
	
	return Building.new("", Vector2.ONE)
