extends Node

var sound_settings: bool = true;
var fullscreen_mode: bool = false;

const start_money: int = 20
var money: int 
var bet: int
var have_a_game: bool = false


func reset_all_settings() -> void:
	save_manager.reset_save()
	
	

func get_dict() -> Dictionary:
	money += bet
	var dict: Dictionary = {
		"settings": {
			"sound_settings": sound_settings,
			"fullscreen_mode": fullscreen_mode
		},
		"gameData": {
			"money": money,
			"have_a_game": have_a_game
		}
	}
	return dict

func set_sound_setting(value):
	sound_settings = value

func set_fullscreen(value):
	fullscreen_mode = value
	set_fullscreen_mode()
	
func set_fullscreen_mode():
	if fullscreen_mode:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	else: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)


func new_game() -> void:
	money = start_money
	have_a_game = true
