extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal next_level
var score
var bakery_count
# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func start_game(skip_splash = false):
	if not skip_splash:
		yield($SplashScreen.display_splash(), "done_splash")
	update_score(0)
	bakery_count = 0
	$HUD/GridContainer/NextLevelButton.disabled = true
	$HUD/GridContainer/ResetButton.disabled = true
	$MainTimer.start()
	$BreadButton.grab_focus()
	
func update_score(s):
	score = s
	$HUD.update_score(score)
	if score > 0:
		$HUD/GridContainer/ResetButton.disabled = false
	if score >= 100:
		$HUD/GridContainer/NextLevelButton.disabled = false
		

func _on_BreadButton_pressed():
	update_score(score + 1)

	
func _on_NextLevelButton_pressed():
	emit_signal("next_level")

func game_tick():
	var bakery_score = bakery_count * 1
	update_score(score + bakery_score)

func _on_ResetButton_pressed():
	start_game(true)
