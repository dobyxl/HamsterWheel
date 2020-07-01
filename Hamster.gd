extends KinematicBody2D

signal in_wheel
signal stat_report(a,b,c)

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
var songSpeed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(180):
		apm.append(0)
	pass


func _physics_process(_delta):
	songSpeed = $AudioStreamPlayer.get_pitch_scale()
	emit_signal("stat_report", hamSpeed, wheelSpeed, songSpeed)
	$AudioStreamPlayer.set_pitch_scale((float(wheelSpeed)/15) + 0.8)
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
	
	if hamSpeed == 0 and wheelSpeed == 0:
		$AnimatedSprite.play("IdleInWheel")
	else:
		$AnimatedSprite.play("Run")
		
	var aps = apm.slice(0, 29, 1)
	
	hamSpeed = aps.count(1)
	wheelSpeed = apm.count(1)/6
	var diff = hamSpeed-wheelSpeed
	
	if wheelSpeed == 0 and aps.count(1) > 0:
		wheelSpeed = 1 
	
	if diff > 0 and self.get_transform().get_rotation() < 0.75:
		self.rotate(0.002*diff)
	elif diff < 0 and self.get_transform().get_rotation() > -1.5:
		self.rotate(0.01*diff)
	

	pass
	
func _eject_physics_process():
	if first:
		motion.y -= 500
		first = false
	motion.x = 50
	$AnimatedSprite.play("Jump")
	motion.y += GRAVITY
	self.rotate(-0.05)
	motion = move_and_slide(motion, UP)
	pass


func _on_pressed_e():
	$AnimatedSprite.play("Jump")
	($AnimatedSprite as AnimatedSprite).scale.x = 1
	self.set_global_position(Vector2(400, 395))
	self.get_node("AnimatedSprite").translate(Vector2(0, 70))
	self.get_node("CollisionShape2D").translate(Vector2(0, 70))
	onWheel = true
	emit_signal("in_wheel")
	$AudioStreamPlayer.play()
	pass
	
func is_On_Wheel():
	return onWheel
	
func get_wheelSpeed():
	return wheelSpeed
	


func _on_Area2D_body_entered(_body):
	eject = true
	pass # Replace with function body.


func _on_TextureButton_pressed():
	if $AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stop()
	else:
		$AudioStreamPlayer.play()
