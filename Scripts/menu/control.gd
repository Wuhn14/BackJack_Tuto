extends Control

@export var Ace_Value_Ask : AceValueDialog

var result

func _ready() -> void:
	Ace_Value_Ask.popup()
	
	result = await Ace_Value_Ask.AceValueGive()

func get_result() -> int:
	return result
