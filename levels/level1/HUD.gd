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
	
	$Menu.show()
	$Menu/Retry.grab_focus()
	if (game_score >= 10):
		$Menu/NextLevel.disabled = false
		$Menu/NextLevel.grab_focus()
	else:
		$Menu/NextLevel.disabled = true
	
	yield(get_tree().create_timer(1), "timeout")
	
func update_score(score):
	game_score = score
	$ScoreLabel.text = str(score)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_Retry_pressed():
	$Menu.hide()
	emit_signal("start_game")
