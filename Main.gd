extends Node

var dodge_bread = preload("res://levels/level1/DodgeBread.tscn").instance()
var settings_path = "user://settings.cfg"

var settings_data = {}
var settings = ConfigFile.new()

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

func _on_TestTimer_timeout():
	add_child(dodge_bread)

func _on_NewGameButton_pressed():
	$MainMenu.hide()
	add_child(dodge_bread)
	dodge_bread.new_game()

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
