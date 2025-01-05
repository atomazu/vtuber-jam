class_name ProjectileTest
extends Test

var factory = ProjectileFactory.new()
#var ball = factory.create_projectile(BuildingData.ShotType.ARROW, 2, 0, 0)


func _init(): 
	add_test("Projectile", "can_place", true)
	

func can_place():
	#get_tree().get_root().add_child.call_deferred(ball)
	pass
