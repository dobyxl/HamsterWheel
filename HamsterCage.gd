extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var hamster_node = get_node('Hamster')
	var pressE_node = get_node('HUD/CenterContainer/PressE')
	
	pressE_node.connect("pressed_e", hamster_node, "_on_pressed_e")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
