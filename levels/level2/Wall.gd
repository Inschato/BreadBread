extends RigidBody2D

signal hit

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Wall_body_entered(body):
	if body.name == "Player":
		emit_signal("hit")
