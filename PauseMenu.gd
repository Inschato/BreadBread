extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HiddenEscButton_pressed():
	if (not get_tree().paused):
		get_tree().paused = true
		$MainMenu.show()
		$MainMenu/MainMenuGrid/ResumeGameButton.grab_focus()
		$HiddenEscButton.disabled = true

func _on_ResumeGameButton_pressed():
	$MainMenu.hide()
	get_tree().paused = false
	$HiddenEscButton.disabled = false
