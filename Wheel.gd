extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
var hamPos = Vector2()
var hamIndex = 0
var prevHam = 0

func _process(delta):
	if self.get_parent().get_node("Hamster").is_On_Wheel():
		if self.get_parent().get_node("Hamster").is_on_floor():
			hamPos = get_parent().get_node("Hamster").get_position()
			hamIndex = (hamPos.x - 400)/1500
			self.get_node("Sprite2").rotate(hamIndex)
		else:
			self.get_node("Sprite2").rotate(prevHam)
	prevHam = hamIndex
	
	pass
