extends Node

export (PackedScene) var wall_scene
signal next_level
signal show_message

var score
var playing

func game_over():
	if (playing):
		playing = false
		$Player.hide()
		$Player/CollisionPolygon2D.set_deferred("disabled", true)
		$Music.stop()
		$DeathSound.play()
		$HUD.show_game_over(score >= 5)

func _ready():
	playing = false
	randomize()

func new_game(skip_splash=false):
	if not skip_splash:
		yield($SplashScreen.display_splash(), "done_splash")
	score = 0
	$HUD.update_score(score)
	playing = true
	$HUD.show_message("Go!", 1)
	$Player.start($PlayerSpawn.position)
	get_tree().call_group("walls", "queue_free")
	$WallTimer.start()
	spawn_walls(-300)
	spawn_walls(0)
	$DeathSound.stop()
	$Music.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_walls(x_offset = 0):
	var wall1 = wall_scene.instance()
	var wall2 = wall_scene.instance()
	wall2.get_node("Sprite").scale.x = -2	
	wall2.get_node("CollisionPolygon2D").scale.y = -2
	wall2.set_collision_layer_bit(1, true) # Detect score when passing
	
	var wall_spawn_location = $WallSpawnLine.points[randi() % $WallSpawnLine.points.size()]
	
	wall1.position = wall_spawn_location + Vector2(x_offset, -300)
	wall2.position = wall_spawn_location + Vector2(x_offset, 300)
		
	var velocity = Vector2(-100, 0.0)
	wall1.linear_velocity = velocity
	wall2.linear_velocity = velocity
	
	wall1.connect("hit", self, "game_over")
	wall2.connect("hit", self, "game_over")
	
	add_child(wall1)
	add_child(wall2)
	

func _on_ScoreCounter_body_entered(_body):
	if (playing):
		score += 1
		$HUD.update_score(score)


func _on_HUD_next_level():
	emit_signal("next_level")


func _on_HUD_retry_level():
	new_game(true)
