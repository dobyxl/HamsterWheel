extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 10
var SPEED = 40
var JUMP_SPEED = 20
var motion = Vector2()
var hamPos = Vector2()
var hamIndex = 0
var onWheel = false

func _physics_process(delta):
	motion = Vector2(0,0)
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		($AnimatedSprite as AnimatedSprite).scale.x = -1	
		if !onWheel:
			motion.x = SPEED
		
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		($AnimatedSprite as AnimatedSprite).scale.x = 1	
		if !onWheel:
			motion.x = -SPEED
			
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		if !onWheel:
			motion.y = -SPEED/2
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		if !onWheel:
			motion.y = SPEED/2
			
	if motion == Vector2(0,0):
		if onWheel:
			$AnimatedSprite.play("IdleOnWheel")
		else:
			$AnimatedSprite.play("Idle")	
	else:
		if onWheel:
			$AnimatedSprite.play("Run")
		else:
			$AnimatedSprite.play("Walk")
			
	motion = move_and_slide(motion, UP)
	pass
	
func _on_pressed_e():
	$AnimatedSprite.play("Jump")
	pass
