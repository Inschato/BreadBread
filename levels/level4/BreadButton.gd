extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var button_down = false
var mouse_over = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var scale = 1.0
	if button_down:
		scale += 0.1
	if mouse_over:
		scale += 0.1
		set_rotation(get_rotation() + 0.3 * delta)
	else:
		set_rotation(max(0, get_rotation() - 1.0 * delta))
	
	rect_scale.x = scale
	rect_scale.y = scale
	
	


func _on_BreadButton_button_down():
	button_down = true

func _on_BreadButton_button_up():
	button_down = false

func _on_BreadButton_mouse_entered():
	mouse_over = true

func _on_BreadButton_mouse_exited():
	mouse_over = false
