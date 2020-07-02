extends Node2D

signal rival_stat_report(a)
signal rival_onWheel(w)
signal scoreChange(d)

export (PackedScene) var Rival
var rival
var hasRival = false
var rivalOnWheel = false
var wheelIndex = 0
var minAPM = 1
var maxAPM = 3
var playerScore = -1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var hamster_node = get_node('Hamster')
	var pressE_node = get_node('HUD/CenterContainer/PressE')
	
	pressE_node.connect("pressed_e", hamster_node, "_on_pressed_e")
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hasRival:
		emit_signal("rival_onWheel", rival._get_onWheel())
	pass

func _get_rivalOnWheel():
	return rivalOnWheel
	
func _get_wheelIndex():
	return wheelIndex
	
func _get_minAPM():
	return minAPM
	
func _get_maxAPM():
	return maxAPM

func _on_Hamster_in_wheel():
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	playerScore += 1
	emit_signal("scoreChange", playerScore)
	$HandControl/AnimationPlayer.play("SpawnAnimation")
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	rival = Rival.instance()
	add_child(rival)
	hasRival = true
	emit_signal("rival_stat_report", rival._get_apm())
	rival.position = Vector2(550, 500)
	minAPM += 1
	maxAPM += 1

func _on_Wheel_wheelIndex(i):
	wheelIndex = i
	pass # Replace with function body.


func _on_Hamster_game_over():
	get_tree().change_scene("res://EndScreen.tscn")
