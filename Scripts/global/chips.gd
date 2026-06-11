extends Node3D


@onready var white_chips = preload("res://Assets/3D/Chips_fix/white_chips.tscn")#1
@onready var red_chips = preload("res://Assets/3D/Chips_fix/red_chips.tscn")#5
@onready var green_chips = preload("res://Assets/3D/Chips_fix/green_chips.tscn")#25
@onready var black_chips = preload("res://Assets/3D/Chips_fix/black_chips.tscn")#100
@onready var blue_chips = preload("res://Assets/3D/Chips_fix/blue_chips.tscn")#500

@onready var chips_models = [white_chips, red_chips, green_chips, black_chips, blue_chips]


var current_y_offset = 0.0;
var offset_set = 0.18;


func add_chips(id):
	var chip = chips_models[id].instantiate();
	chip.position.y = current_y_offset
	current_y_offset += offset_set
	add_child(chip)
	


func reset_all():
	current_y_offset = 0.0
	for chips in get_children():
		chips.queue_free()
