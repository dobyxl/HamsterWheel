extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
var hamPos = Vector2()
var hamIndex = 0

func _process(delta):
	#if self.get_parent().get_node("Hamster").isOnWheel():
		hamPos = get_parent().get_node("Hamster").get_position()
		hamIndex = (hamPos.x - 512)/2500
		#self.get_node("Sprite").rotate(hamIndex)
		#self.get_node("Sprite2").rotate(hamIndex)
	
pass
