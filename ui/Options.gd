extends CanvasLayer

signal options_back
signal music_volume_changed
signal sound_volume_changed
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer.hide()
	pass # Replace with function body.

func open(music_volume, sound_volume):
	$CanvasLayer/VBoxContainer/MusicSlider.value = music_volume
	$CanvasLayer/VBoxContainer/SoundSlider.value = sound_volume
	$CanvasLayer.show()
	$CanvasLayer/VBoxContainer/MusicSlider.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	$CanvasLayer.hide()
	emit_signal("options_back")

func _on_MusicSlider_value_changed(value):
	emit_signal("music_volume_changed", value)

func _on_SoundSlider_value_changed(value):
	emit_signal("sound_volume_changed", value)
