extends KinematicBody2D

signal in_wheel

export var min_apm = 1
export var max_apm = 8
export var walking_speed = 45
export var onWheel = false 
export var velocity = Vector2.ZERO
var enterBoxLocation = Vector2(400, 500)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("walk")
	$AnimatedSprite.self_modulate = Color(randf()*1, randf()*1, randf()*1)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _physics_process(delta):
	if (position == enterBoxLocation):
		$AnimatedSprite.play("Jump")
		($AnimatedSprite as AnimatedSprite).scale.x = 1
		self.set_global_position(Vector2(399, 465))
		onWheel = true
		emit_signal("in_wheel")
		pass
	
	if onWheel:
		_wheel_physics_process()
	else:
		_default_physics_process()
	pass
	
func _default_physics_process():
	velocity = position.direction_to(enterBoxLocation) * walking_speed
	velocity = move_and_slide(velocity)
	
func _wheel_physics_process():
	$AnimatedSprite.play("Run")
