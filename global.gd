extends Node
var score = 0
var player_name


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SilentWolf.configure({
	"api_key": "b5mz4QCMEE4HWCDMrvheo7aaTmzuTXrn1RwsnIjN",
	"game_id": "Ham-HamWorldHampionship",
	"game_version": "0.0.0",
	"log_level": 1
	})
	
	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/EndScreen.tscn"
	})

func set_player_name(name):
	player_name = name

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
