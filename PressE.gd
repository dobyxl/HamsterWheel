extends Label

signal pressed_e

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.is_visible() && Input.is_action_pressed("ui_accept"):
		emit_signal("pressed_e")
	pass

func _on_EnterBox_body_entered(body):
	self.show()
	pass # Replace with function body.


func _on_EnterBox_body_exited(body):
	self.hide()
	pass # Replace with function body.
