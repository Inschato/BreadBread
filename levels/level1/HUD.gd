extends CanvasLayer

var game_score
	
func update_score(score):
	game_score = score
	$ScoreLabel.text = str(score)
