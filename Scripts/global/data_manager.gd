extends Node

var sound_settings = true;
var fullscreen_mode = true;

var start_money = 20
var money = 20



func reset_all_settings() -> void:
	pass

func set_sound_setting(value):
	sound_settings = value

func set_fullscreen_mode(value):
	fullscreen_mode = value
	if value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	else: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)


func reset_the_game() -> void:
	money = start_money
