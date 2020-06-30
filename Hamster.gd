extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 40
const SPEED = 40
const JUMP_SPEED = 60
const SPEED_CAP = 100
var motion = Vector2()
var hamSpeed = 0
var hamAcceleration = 0
var hamIndex = 0
var hamPos = Vector2(0,0)
var onWheel = false


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
	motion = Vector2(0,0)
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		($AnimatedSprite as AnimatedSprite).scale.x = -1	
		motion.x = SPEED
		
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		($AnimatedSprite as AnimatedSprite).scale.x = 1	
		motion.x = -SPEED
		
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		motion.y = -JUMP_SPEED
	
	
	motion = move_and_slide(motion, UP)
	pass


func _on_pressed_e():
	$AnimatedSprite.play("Jump")
	self.translate(Vector2(0,-64))
	onWheel = true
	pass

func _on_pressed_e_again():
	$AnimatedSprite.play("Jump")
	self.translate(Vector2(0,64))
	onWheel = false
	pass
	
func is_On_Wheel():
	return onWheel
	pass
