extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 10
const SPEED = 40
const JUMP_SPEED = 360
const SPEED_CAP = 100

var apm = []
var motion = Vector2()
var hamSpeed = 0
var wheelSpeed = 0
var hamIndex = 0
var hamPos = Vector2()
var onWheel = false
var leftKeyNext = true
var eject = false
var first = true

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(600):
		apm.append(0)
	pass


func _physics_process(_delta):
	if eject:
		_eject_physics_process()
	elif onWheel:
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
		
	if leftKeyNext:
		if Input.is_action_just_pressed("ui_left"):
			leftKeyNext = !leftKeyNext
			apm.push_front(1)
		else:
			apm.push_front(0)
	else: 
		if Input.is_action_just_pressed("ui_right"):
			leftKeyNext = !leftKeyNext
			apm.push_front(1)
		else:
			apm.push_front(0)
	
	
		
	
	if hamSpeed == 0:
		$AnimatedSprite.play("IdleInWheel")
	else:
		$AnimatedSprite.play("Run")
	
	hamSpeed = apm.slice(0, 29, 1).count(1)
	wheelSpeed = apm.count(1)/20
	
	if hamSpeed > wheelSpeed:
		motion.x = -SPEED/2
		wheelSpeed = (wheelSpeed+hamSpeed)/2
	elif hamSpeed < wheelSpeed:
		motion.x = SPEED
		
	motion = move_and_slide(motion, UP, true)
	
	self.set_global_rotation(-(self.get_position().x - 400)/69)

	pass
	
func _eject_physics_process():
	if first:
		motion.y -= 820
		first = false
	motion.x = 120
	$AnimatedSprite.play("Jump")
	motion.y += GRAVITY
	self.rotate(0.1)
	motion = move_and_slide(motion, UP)
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
	
func get_wheelSpeed():
	return wheelSpeed
	


func _on_Area2D_body_entered(_body):
	eject = true
	pass # Replace with function body.
