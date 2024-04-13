extends Node

var ball_scene = preload("res://levels/level3/Ball.tscn")
var score
var required_score

signal next_level

func new_game(skip_splash=false):
	$Paddle.playing = false
	$Paddle.position = $StartPosition.position
	if not skip_splash:
		yield($SplashScreen.display_splash(), "done_splash")
	$Paddle.playing = true
	score = 0
	required_score = get_tree().get_nodes_in_group("blocks").size()
	var ball = ball_scene.instance()
	ball.connect("ball_exited", self, "ball_exited")
	ball.connect("block_hit", self, "block_hit")
	ball.position = $BallStartPosition.position
	add_child(ball)
	$HUD.update_score(score)
	get_tree().call_group("blocks", "reset")
	$Music.play()
	yield(get_tree().create_timer(1.0), "timeout")
	ball.start()
	

func block_hit():
	score += 1
	$HUD.update_score(score)
	if (score >= required_score):
		$HUD.show_game_over(true, "You Win!")

func ball_exited():
	if (score < required_score):
		$HUD.show_game_over(false)
		$GameOverSound.play()
		$Music.stop()

func _on_HUD_retry_level():
	new_game(true)

func _on_HUD_next_level():
	emit_signal("next_level")
