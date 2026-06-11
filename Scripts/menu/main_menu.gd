extends Control

@onready var continue_button =  $Main_menu_button/CONTINUE


func setup_menu() -> void:
	continue_button.disabled = !DataManager.have_a_game
	
	var fullscreenMode = DisplayServer.window_get_mode()
	if fullscreenMode < 3 : 
		toggle($SettingsMenu/SettingsItems/Fullscreen/FullscreenSwitch, false)
	toggle($SettingsMenu/SettingsItems/Sound/SoundsSwitch, DataManager.sound_settings)

func toggle(item: Variant, value: bool) -> void : 
	match value:
		true:
			item.text = "ON"
			item.modulate = Color(0.0, 1.0, 0.0)
			item.button_pressed = true
		false:
			item.text = "OFF"
			item.modulate = Color(1.0, 0.0, 0.0)
			item.button_pressed = false
	


func showM(item: Variant) -> void : 
	item.show()

func hideM(item: Variant) -> void : 
	item.hide()

func _on_new_pressed() -> void:
	DataManager.new_game()
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")

func _on_settings_pressed() -> void:
	showM($SettingsMenu)

func _on_about_pressed() -> void:
	showM($AboutMenu)

func _on_quit_pressed() -> void:
	
	get_tree().quit()

func _on_about_back_pressed() -> void:
	hideM($AboutMenu)

func _on_settings_back_pressed() -> void:
	hideM($SettingsMenu)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		DataManager.set_fullscreen(!DataManager.fullscreen_mode)

func _on_sounds_switch_toggled(toggled_on: bool) -> void:
	toggle($SettingsMenu/SettingsItems/Sound/SoundsSwitch,toggled_on)
	DataManager.set_sound_setting(toggled_on)

func _on_fullscreen_switch_toggled(toggled_on: bool) -> void:
	toggle($SettingsMenu/SettingsItems/Fullscreen/FullscreenSwitch, toggled_on)
	DataManager.set_fullscreen(toggled_on)
