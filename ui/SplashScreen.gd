extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (String) var game_name
export (int) var level_number

signal done_splash

# Called when the node enters the scene tree for the first time.
func _ready():
	$GridContainer/GameName.text = game_name
	$GridContainer/LevelLabel.text = "Level " + str(level_number)

func display_splash():
	show()
	$SplashLengthTimer.start()
	return self

func _on_SplashLengthTimer_timeout():
	emit_signal("done_splash")
	hide()
