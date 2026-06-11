class_name AceValueDialog
extends ConfirmationDialog

var finished = false

var result = null

var scene_root
var one_button : Button
var ten_button : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	one_button = get_ok_button()
	ten_button = get_cancel_button()
	one_button.pressed.connect(_on_one_pressed)
	ten_button.pressed.connect(_on_ten_pressed)
	


func AceValueGive() -> int:
	finished = false
	result = null
	scene_root = get_tree()
	
	
	
	"cancel_button_text"
	"ok_button_text"
	
	while (not finished):
		await scene_root.process_frame
	
	return result
	
	

func _on_one_pressed():
	result = 1
	finished = true
	
	

func _on_ten_pressed():
	result = 11
	finished = true
	
