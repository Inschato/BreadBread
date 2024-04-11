extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal block_hit
signal ball_exited
const target_speed = 565

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _integrate_forces(state):
	state.linear_velocity=state.linear_velocity.normalized()*target_speed

func _on_Ball_body_entered(body):
	if body.is_in_group('blocks'):
		body.get_hit()
		emit_signal("block_hit")


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("ball_exited")
	queue_free()
