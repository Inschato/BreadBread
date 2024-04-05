extends CanvasLayer

signal start_game

var game_score

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")	
	yield($MessageTimer, "timeout")
	
	$Retry.show()
	if (game_score >= 10):
		$NextLevel.show()
	
	yield(get_tree().create_timer(1), "timeout")
	
func update_score(score):
	game_score = score
	$ScoreLabel.text = str(score)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Retry.hide()
	$NextLevel.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_Retry_pressed():
	emit_signal("start_game")
	$Retry.hide()
	$NextLevel.hide()
