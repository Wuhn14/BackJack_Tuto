extends Node3D

@onready var menu = $Camera3D/Main_menu_UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dict: Dictionary = save_manager.load_game()
	var settings = dict["settings"]
	var gameData = dict["gameData"]
	DataManager.fullscreen_mode = settings["fullscreen_mode"]
	DataManager.sound_settings = settings["sound_settings"]
	DataManager.money = gameData["money"]
	DataManager.have_a_game = gameData["have_a_game"]
	DataManager.set_fullscreen_mode()
	menu.setup_menu()

func _exit_tree() -> void:
	save_manager.save_game(DataManager.get_dict())
	
