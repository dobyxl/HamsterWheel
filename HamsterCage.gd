extends Node2D

signal rival_stat_report(a)

export (PackedScene) var Rival

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
#func _process(delta):
#	pass

func _on_Hamster_in_wheel():
	$SpawnTimer.start()

func _on_SpawnTimer_timeout():
	$HandControl/AnimationPlayer.play("SpawnAnimation")
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	var rival = Rival.instance()
	add_child(rival)
	emit_signal("rival_stat_report", rival._get_apm())
	rival.position = Vector2(550, 500)
