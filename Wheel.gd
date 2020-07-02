extends KinematicBody2D

signal wheelIndex(i)

# Declare member variables here. Examples:
# var a = 2
var hamPos = Vector2()
var hamIndex = 0
var rivIndex = 0
var wheelIndex = float(0)
var aveIndex= 0
var rivOnWheel = false

func _process(_delta):
	if self.get_parent().get_node("Hamster").is_On_Wheel():
		if !rivOnWheel:
			aveIndex = self.get_parent().get_node("Hamster").get_wheelSpeed()
			wheelIndex =  2*log(self.get_parent().get_node("Hamster").get_wheelSpeed()+1)
			self.get_node("Sprite2").rotate(-wheelIndex/50)
		else:
			aveIndex = (self.get_parent().get_node("Hamster").get_wheelSpeed() + rivIndex)/2
			wheelIndex =  2*log(aveIndex+1)
			self.get_node("Sprite2").rotate(-wheelIndex/50)
		emit_signal("wheelIndex", aveIndex)
	elif rivOnWheel:
		aveIndex = self.get_parent().get_node("Hamster").get_wheelSpeed()
		emit_signal("wheelIndex", aveIndex)
	pass
	
func _on_HamsterCage_rival_stat_report(a):
	rivIndex = a
	pass # Replace with function body.


func _on_HamsterCage_rival_onWheel(w):
	rivOnWheel = w
	pass # Replace with function body.
