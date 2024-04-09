extends Node

signal game_over
signal show_message

var score

func game_over():
	emit_signal("game_over", false)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func new_game():
	score = 0
	emit_signal("show_message", "Go!")
	$Player.start($PlayerSpawn.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

