extends Node

var levels = [
	preload("res://levels/level1/DodgeBread.tscn"),
	preload("res://levels/level2/FlappyLoaf.tscn"),
	preload("res://levels/level3/BreakBread.tscn")
]

var settings_path = "user://settings.cfg"

var settings_data = {}
var settings = ConfigFile.new()
var current_level_index = 0
var current_level

func load_settings():
	settings.load(settings_path)
	settings_data["music_volume"] =  float(settings.get_value("preferences", "music", 0.5))
	settings_data["sound_volume"] =  float(settings.get_value("preferences", "sound", 0.5))

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(settings_data["music_volume"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear2db(settings_data["sound_volume"]))
	
func save_settings():
	settings.set_value("preferences", "music", settings_data["music_volume"])
	settings.set_value("preferences", "sound", settings_data["sound_volume"])
	settings.save(settings_path)
	
func get_new_level_instance(level_index):
	var level = levels[level_index].instance()
	level.connect("next_level", self, "next_level")
	return level

func _ready():
	$Music.play()
	load_settings()
	open()
	
func _process(_delta):
	# Hack: On the HTML version if you start playing using controller it might start playing both songs at the same time
	if current_level and $Music.playing:
		$Music.stop()

func open():
	$MenuHolder/MainMenu.show()
	$MenuHolder/MainMenu/MainMenuGrid/NewGameButton.grab_focus()

func _on_NewGameButton_pressed():
	var old_level = current_level
	current_level_index = 0
	get_tree().paused = false
	$MenuHolder/HiddenEscButton.disabled = false
	$Music.stop()
	$MenuHolder/MainMenu.hide()
	$MenuHolder/MainMenu/MainMenuGrid/ResumeGameButton.show()
	current_level = get_new_level_instance(current_level_index)
	$GameHolder.add_child(current_level)
	current_level.new_game()
	if old_level:
		$GameHolder.remove_child(old_level)
		old_level.queue_free()
	$MenuHolder/HiddenSkipButton.disabled = false
	
func show_message(message):
	$MenuHolder/MessageCanvas/Message.text = message
	$MenuHolder/MessageCanvas/Message.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$MenuHolder/MessageCanvas/Message.hide()
	
#### Options Menu ####

func _on_OptionsButton_pressed():
	$MenuHolder/MainMenu.hide()
	$MenuHolder/OptionsMenu.open(settings_data["music_volume"], settings_data["sound_volume"])

func _on_OptionsMenu_options_back():
	open()
	save_settings()
	$MenuHolder/MainMenu/MainMenuGrid/OptionsButton.grab_focus()

func _on_OptionsMenu_music_volume_changed(value):
	settings_data["music_volume"] = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(settings_data["music_volume"]))

func _on_OptionsMenu_sound_volume_changed(value):
	settings_data["sound_volume"] = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear2db(settings_data["sound_volume"]))

func next_level():
	var old_level = current_level
	current_level_index += 1
	if (current_level_index > levels.size() - 1):
		$GameHolder.remove_child(old_level)
		$MenuHolder/MainMenu/MainMenuGrid/ResumeGameButton.hide()
		show_message("Thanks for playing!")
		yield(get_tree().create_timer(1.0, false), "timeout")
		current_level = null
		$Music.play()
		open()
		return
	current_level = get_new_level_instance(current_level_index)
	
	$GameHolder.remove_child(old_level)
	$GameHolder.add_child(current_level)
	current_level.new_game()

func _on_CreditsButton_pressed():
	$MenuHolder/MainMenu.hide()
	$MenuHolder/Credits/BackButton.grab_focus()
	$MenuHolder/Credits.show()

func credits_back_button_pressed():
	$MenuHolder/Credits.hide()
	open()


func _on_CreditsLabel_meta_clicked(meta):
	var __ = OS.shell_open(str(meta))


func _on_HiddenSkipButton_pressed():
	if current_level and not get_tree().paused:
		next_level()
