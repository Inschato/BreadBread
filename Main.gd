extends Node

var dodge_bread = preload("res://levels/level1/DodgeBread.tscn").instance()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TestTimer_timeout():
	add_child(dodge_bread)


func _on_NewGameButton_pressed():
	$MainMenu.hide()
	add_child(dodge_bread)
	dodge_bread.new_game()
	
