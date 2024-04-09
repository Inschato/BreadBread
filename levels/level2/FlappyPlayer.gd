extends KinematicBody2D

signal hit

const GRAVITY = 500.0
const FLY_STRENGTH = -100.0
var velocity = Vector2()

var starting_position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	handle_hit()

func handle_hit():
	hide()
	emit_signal("hit")
	$CollisionPolygon2D.set_deferred("disabled", true)
	
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 15
		velocity.y = min(velocity.y, FLY_STRENGTH)		
		move_and_collide(velocity * delta)
		rotation_degrees = -35
	else:
		rotation_degrees = 0
	
	var motion = velocity * delta
	
	move_and_collide(motion)
	
func start(pos):
	position = pos
	show()
	$CollisionPolygon2D.disabled = false
	
