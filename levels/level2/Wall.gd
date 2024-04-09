extends RigidBody2D

func _on_VisibilityNotifier2D_screen_exited():
	print("FREEING")
	queue_free()

func _ready():
	print("spawned")

