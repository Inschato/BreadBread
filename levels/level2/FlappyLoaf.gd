extends Node

export (PackedScene) var wall_scene
signal game_over
signal show_message

var score

func game_over():
	emit_signal("game_over", false)

func _ready():
	randomize()

func new_game():
	score = 0
	emit_signal("show_message", "Go!")
	$Player.start($PlayerSpawn.position)
	$WallTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_walls():
	var wall1 = wall_scene.instance()
	var wall2 = wall_scene.instance()
	wall2.get_node("Sprite").scale.y = -2
	wall2.get_node("CollisionPolygon2D").scale.y = -2
	
	var wall_spawn_location = $WallSpawnLine.points[randi() % $WallSpawnLine.points.size()]
	
	wall1.position = wall_spawn_location + Vector2(0, 100)
	wall2.position = wall_spawn_location + Vector2(0, -100)
		
	var velocity = Vector2(-100, 0.0)
	wall1.linear_velocity = velocity
	wall2.linear_velocity = velocity
	
	add_child(wall1)
	add_child(wall2)
	
