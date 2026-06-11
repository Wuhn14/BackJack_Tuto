extends Node3D

@export var turn_speed = 8;

func _process(delta):
	rotation.y += deg_to_rad(turn_speed)*delta

@onready var card1 = $Card
@onready var card2 = $Card2

func _ready() -> void:
	card1.set_card(randi_range(0, 51))
	card2.set_card(randi_range(0, 51))
