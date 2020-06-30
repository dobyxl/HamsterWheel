extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
var hamPos = Vector2()
var hamIndex = 0
var prevHam = 0

func _process(delta):
	if self.get_parent().get_node("Hamster").is_On_Wheel():
		hamIndex =  self.get_parent().get_node("Hamster").get_hamSpeed()/10
		self.get_node("Sprite2").rotate(-hamIndex)
	pass
