extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const speed = 1000
var velocity = Vector2()
var playing = false

func _physics_process(delta):
	if not playing:
		return

	velocity.x = 0
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	
	var motion = velocity * delta
	var _collision = move_and_collide(motion)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
