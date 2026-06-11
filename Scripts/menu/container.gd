extends Container

@export var Ace_Value_Ask : AceValueDialog

var result

func get_result() -> int:
	Ace_Value_Ask.popup()
	
	result = await Ace_Value_Ask.AceValueGive()
	return result
