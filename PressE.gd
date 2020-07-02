extends Label

signal pressed_e

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var shownOnce = false



# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.is_visible() && Input.is_action_just_pressed("ui_accept"):
		emit_signal("pressed_e")
	pass

func _on_EnterBox_body_entered(body):
	if !shownOnce:
		self.show()
	pass # Replace with function body.


func _on_EnterBox_body_exited(_body):
	self.hide()
	shownOnce = true
	pass # Replace with function body.
