extends Label

signal pressed_e_again

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var shownOnce = false


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.is_visible() && Input.is_action_just_pressed("ui_left"):
		self.hide()
	pass


func _on_ExitBox_body_entered(body):
	if !shownOnce:
		self.show()
		shownOnce = true
	pass # Replace with function body.


func _on_ExitBox_body_exited(body):
	self.hide()
	pass # Replace with function body.
