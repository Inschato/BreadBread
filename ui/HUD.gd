extends CanvasLayer

signal retry_level
signal next_level

var game_score
	
func update_score(score):
	game_score = score
	$ScoreLabel.text = str(score)

# Called when the node enters the scene tree for the first time.
func _ready():
	$GridContainer.hide()
	$MessageLabel.hide()
	$ScoreLabel.show()

func show_game_over(enable_next_level, message="Game Over!"):
	show_message(message)
	yield(get_tree().create_timer(1.0, false), "timeout")
	$GridContainer/NextLevelButton.disabled = not enable_next_level
	if enable_next_level:
		$GridContainer/NextLevelButton.grab_focus()
	else:
		$GridContainer/RetryButton.grab_focus()
	$GridContainer.show()
	

func show_message(message, timeout=0):
	$MessageLabel.text = message
	$MessageLabel.show()
	if timeout > 0:
		yield(get_tree().create_timer(timeout, false), "timeout")
		$MessageLabel.hide()


func _on_NextLevelButton_pressed():
	$GridContainer.hide()
	$MessageLabel.hide()
	emit_signal("next_level")


func _on_RetryButton_pressed():
	$GridContainer.hide()
	$MessageLabel.hide()
	emit_signal("retry_level")
