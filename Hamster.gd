extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 10
const SPEED = 40
const JUMP_SPEED = 360
const SPEED_CAP = 100

var apm = []
var motion = Vector2()
var hamSpeed = 0
var hamIndex = 0
var hamPos = Vector2()
var onWheel = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(200):
		apm.append(0)
	pass


func _physics_process(delta):
	if onWheel:
		_wheel_physics_process()
	else:
		_default_physics_process()
	pass


func _default_physics_process():
	motion = Vector2(0,0)
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		($AnimatedSprite as AnimatedSprite).scale.x = -1
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		($AnimatedSprite as AnimatedSprite).scale.x = 1
		motion.x = -SPEED
		
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		motion.y = -SPEED/2
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		motion.y = SPEED/2

	if motion == Vector2(0,0):
		$AnimatedSprite.play("Idle")
	else:
		$AnimatedSprite.play("Walk")
			
	motion = move_and_slide(motion, UP)
	pass


func _wheel_physics_process():
	motion.y += GRAVITY
	apm.pop_back()
		
	if Input.is_action_just_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		($AnimatedSprite as AnimatedSprite).scale.x = 1
		motion.x = -SPEED
		apm.push_front(1)
	else:
		apm.push_front(0)
		
	
	if hamSpeed == 0:
		$AnimatedSprite.play("IdleInWheel")
	else:
		$AnimatedSprite.play("Run")
		
	motion = move_and_slide(motion, UP)
	
	hamSpeed = apm.count(1)
	
	self.set_global_rotation(-(self.get_position().x - 400)/69)

	pass


func _on_pressed_e():
	$AnimatedSprite.play("Jump")
	($AnimatedSprite as AnimatedSprite).scale.x = 1
	self.set_global_position(Vector2(399, 465))
	onWheel = true
	pass

func _on_pressed_e_again():
	self.set_global_rotation(0)
	$AnimatedSprite.play("Jump")
	self.set_global_position(Vector2(400, 500))
	onWheel = false
	pass
	
func is_On_Wheel():
	return onWheel
	
func get_hamSpeed():
	return hamSpeed
	
