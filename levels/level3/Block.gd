extends StaticBody2D

# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()
func _ready():
	rng.seed = randi()
	pass # Replace with function body.

func reset():
	show()
	$CollisionPolygon2D.set_deferred("disabled", false)
	
func get_hit():
	hide()
	$CollisionPolygon2D.set_deferred("disabled", true)
	$HitSound.pitch_scale = rng.randf_range(0.9, 1.1)
	$HitSound.play()
