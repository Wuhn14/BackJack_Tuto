extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fullscreenMode = DisplayServer.window_get_mode()
	if fullscreenMode < 3 : 
		toggleOFF($SettingsMenu/SettingsItems/Fullscreen/FullscreenSwitch)

func toggleON(item: Variant) -> void : 
	item.text = "ON"
	item.modulate = Color(0.0, 1.0, 0.0)
	item.button_pressed = true

func toggleOFF(item: Variant) -> void : 
	item.text = "OFF"
	item.modulate = Color(1.0, 0.0, 0.0)
	item.button_pressed = false

func showM(item: Variant) -> void : 
	item.show()

func hideM(item: Variant) -> void : 
	item.hide()

func _on_new_pressed() -> void:
	DataManager.reset_the_game()
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

func _on_sounds_switch_toggled(toggled_on: bool) -> void:
	if toggled_on :
		toggleON($SettingsMenu/SettingsItems/Sound/SoundsSwitch)
		DataManager.set_sound_setting(true)
	else : 
		toggleOFF($SettingsMenu/SettingsItems/Sound/SoundsSwitch)
		DataManager.set_sound_setting(false)

func _on_fullscreen_switch_toggled(toggled_on: bool) -> void:
	if toggled_on :
		toggleON($SettingsMenu/SettingsItems/Fullscreen/FullscreenSwitch)
		DataManager.set_fullscreen_mode(true)
	else : 
		toggleOFF($SettingsMenu/SettingsItems/Fullscreen/FullscreenSwitch)
		DataManager.set_fullscreen_mode(false)
