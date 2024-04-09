extends Node

var levels = [
	preload("res://levels/level2/FlappyLoaf.tscn").instance(),
	preload("res://levels/level1/DodgeBread.tscn").instance()
]

var settings_path = "user://settings.cfg"

var settings_data = {}
var settings = ConfigFile.new()
var game_index = 0
var current_game

func load_settings():
	var err = settings.load(settings_path)
	settings_data["music_volume"] =  float(settings.get_value("preferences", "music", 0.5))
	settings_data["sound_volume"] =  float(settings.get_value("preferences", "sound", 0.5))
	
	var idx = AudioServer.get_bus_index("Music")
	var x = AudioServer.get_bus_volume_db(idx)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(settings_data["music_volume"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear2db(settings_data["sound_volume"]))
	
func save_settings():
	settings.set_value("preferences", "music", settings_data["music_volume"])
	settings.set_value("preferences", "sound", settings_data["sound_volume"])
	settings.save(settings_path)

# Called when the node enters the scene tree for the first time.
func _ready():	
	$OptionsMenu.hide()
	load_settings()
	open()

func open():
	$MainMenu.show()
	$MainMenu/MainMenuGrid/NewGameButton.grab_focus()

func _on_NewGameButton_pressed():
	$MainMenu.hide()
	current_game = levels[game_index]
	current_game.connect("game_over", self, "game_over")
	current_game.connect("show_message", self, "show_message")
	add_child(current_game)
	current_game.new_game()

func _on_OptionsButton_pressed():
	$MainMenu.hide()
	$OptionsMenu.open(settings_data["music_volume"], settings_data["sound_volume"])

func _on_OptionsMenu_options_back():
	open()
	save_settings()
	$MainMenu/MainMenuGrid/OptionsButton.grab_focus()


func _on_OptionsMenu_music_volume_changed(value):
	settings_data["music_volume"] = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(settings_data["music_volume"]))

func _on_OptionsMenu_sound_volume_changed(value):
	settings_data["sound_volume"] = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear2db(settings_data["sound_volume"]))

func game_over(enable_next_level):
	show_message("Game Over")
	yield(get_tree().create_timer(1.0), "timeout")
	show_retry_menu(enable_next_level)

func show_retry_menu(enable_next_level):
	$RetryMenu/GridContainer/NextLevelButton.disabled = !enable_next_level
	if (enable_next_level):
		$RetryMenu/GridContainer/NextLevelButton.grab_focus()
	else:
		$RetryMenu/GridContainer/RetryButton.grab_focus()
	$RetryMenu.show()
	
func show_message(message):
	$MessageCanvas/Message.text = message
	$MessageCanvas/Message.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$MessageCanvas/Message.hide()

func _on_RetryButton_pressed():
	$RetryMenu.hide()
	current_game.new_game()

func _on_NextLevelButton_pressed():
	$RetryMenu.hide()
	remove_child(current_game)
	game_index += 1
	current_game = levels[game_index]
	current_game.connect("game_over", self, "game_over")
	current_game.connect("show_message", self, "show_message")
	add_child(current_game)
	current_game.new_game()
