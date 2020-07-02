extends KinematicBody2D

var min_apm = 0
var max_apm = 0
var rng = RandomNumberGenerator.new()
var apm
export var walking_speed = 45
export var onWheel = false 
export var velocity = Vector2.ZERO
var enterBoxLocation = Vector2(400, 500)
var rivalNum = 0
var eject = false
var first = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	min_apm = self.get_parent()._get_minAPM()
	max_apm = self.get_parent()._get_maxAPM()
	apm = rng.randf_range(min_apm, max_apm)
	$AnimatedSprite.play("walk")
	$AnimatedSprite.self_modulate = Color(randf()*1, randf()*1, randf()*1)


func _on_VisibilityNotifier2D_screen_exited():
	self.get_parent()._on_SpawnTimer_timeout()
	pass
	
	
func _physics_process(_delta):
	if (position == enterBoxLocation):
		$AnimatedSprite.play("Jump")
		($AnimatedSprite as AnimatedSprite).scale.x = 1
		self.set_global_position(Vector2(400, 395))
		self.get_node("AnimatedSprite").translate(Vector2(0, 70))
		self.get_node("CollisionShape2D").translate(Vector2(0, 70))
		onWheel = true
		first = true
		pass
	
	if eject:
		_eject_physics_process()
	elif onWheel:
		_wheel_physics_process()
	else:
		_default_physics_process()
	pass
	
func _get_apm():
	return apm
	
func _get_onWheel():
	return onWheel


func _default_physics_process():
	velocity = position.direction_to(enterBoxLocation) * walking_speed
	velocity = move_and_slide(velocity)
	
func _wheel_physics_process():
	$AnimatedSprite.play("Run")
	var diff = apm-self.get_parent()._get_wheelIndex()
	if diff > 0 and self.get_transform().get_rotation() < 0.75:
		self.rotate(0.005*diff)
	elif diff < 0 and self.get_transform().get_rotation() > -1.5:
		self.rotate(0.01*diff)
		
	if self.get_transform().get_rotation() < -1.2:
		eject = true
		onWheel = false

func _eject_physics_process():
	if first:
		velocity.y -= 500
		first = false
	$AnimatedSprite.play("Jump")
	self.rotate(-0.05)
	velocity += Vector2(16, 16)
	velocity = move_and_slide(velocity)
