extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal block_hit
signal ball_exited
const target_speed = 565
var started
var initialized

# Called when the node enters the scene tree for the first time.
func _ready():
	started = false
	initialized = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _integrate_forces(state):
	if started:
		if not initialized:
			state.apply_central_impulse(Vector2(1, -1))
			initialized = true
		state.linear_velocity=state.linear_velocity.normalized()*target_speed
		
func start():
	started = true

func _on_Ball_body_entered(body):
	if body.is_in_group('blocks'):
		body.get_hit()
		emit_signal("block_hit")


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("ball_exited")
	queue_free()
