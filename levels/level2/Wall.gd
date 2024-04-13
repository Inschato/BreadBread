extends RigidBody2D

signal hit

var enforced_speed
var current_speed

func _integrate_forces(state):
	if enforced_speed != current_speed:
		state.apply_central_impulse(Vector2(-(enforced_speed - current_speed), 0))
		current_speed = enforced_speed

func initialize_speed(speed):
	linear_velocity = Vector2(-speed, 0)
	enforced_speed = speed
	current_speed = speed

func set_speed(speed):
	enforced_speed = speed

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Wall_body_entered(body):
	if body.name == "Player":
		emit_signal("hit")
