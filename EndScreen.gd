extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		global.score = 0
		get_tree().change_scene("res://HamsterCage.tscn")


func _on_SubmitScoreButton_pressed():
	var name = $"NameDialog/NameInput".text
	global.set_player_name(name)
	SilentWolf.Scores.persist_score(global.player_name, global.score)
	SilentWolf.Scores.get_high_scores()
	$"NameDialog".hide()
	
func load_leaderboard_scene():
	get_tree().change_scene("res://addons/silent_wolf/silent_wolf/Scores/Leaderboard.tscn")


func _on_ShowLB_pressed():
	load_leaderboard_scene()
