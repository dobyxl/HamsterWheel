extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$"CenterContainer/PressE".hide()

func update_stack(stackSize):
	$StackLabel.text = str(stackSize)

func update_animal_total(animalTotal):
	$ScoreLabel.text = str(animalTotal)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pas

