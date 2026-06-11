extends Node3D

@onready var card_texture = [
	"res://Assets/Texture/Card/card_clubs_A.png", "res://Assets/Texture/Card/card_clubs_02.png", "res://Assets/Texture/Card/card_clubs_03.png", "res://Assets/Texture/Card/card_clubs_04.png", "res://Assets/Texture/Card/card_clubs_05.png", "res://Assets/Texture/Card/card_clubs_06.png", "res://Assets/Texture/Card/card_clubs_07.png", "res://Assets/Texture/Card/card_clubs_08.png", "res://Assets/Texture/Card/card_clubs_09.png", "res://Assets/Texture/Card/card_clubs_10.png", "res://Assets/Texture/Card/card_clubs_J.png", "res://Assets/Texture/Card/card_clubs_K.png", "res://Assets/Texture/Card/card_clubs_Q.png", 
	"res://Assets/Texture/Card/card_diamonds_A.png", "res://Assets/Texture/Card/card_diamonds_02.png", "res://Assets/Texture/Card/card_diamonds_03.png", "res://Assets/Texture/Card/card_diamonds_04.png", "res://Assets/Texture/Card/card_diamonds_05.png", "res://Assets/Texture/Card/card_diamonds_06.png", "res://Assets/Texture/Card/card_diamonds_07.png", "res://Assets/Texture/Card/card_diamonds_08.png", "res://Assets/Texture/Card/card_diamonds_09.png", "res://Assets/Texture/Card/card_diamonds_10.png", "res://Assets/Texture/Card/card_diamonds_J.png", "res://Assets/Texture/Card/card_diamonds_K.png", "res://Assets/Texture/Card/card_diamonds_Q.png", 
	"res://Assets/Texture/Card/card_hearts_A.png", "res://Assets/Texture/Card/card_hearts_02.png", "res://Assets/Texture/Card/card_hearts_03.png", "res://Assets/Texture/Card/card_hearts_04.png", "res://Assets/Texture/Card/card_hearts_05.png", "res://Assets/Texture/Card/card_hearts_06.png", "res://Assets/Texture/Card/card_hearts_07.png", "res://Assets/Texture/Card/card_hearts_08.png", "res://Assets/Texture/Card/card_hearts_09.png", "res://Assets/Texture/Card/card_hearts_10.png", "res://Assets/Texture/Card/card_hearts_J.png", "res://Assets/Texture/Card/card_hearts_K.png", "res://Assets/Texture/Card/card_hearts_Q.png", 
	"res://Assets/Texture/Card/card_spades_A.png", "res://Assets/Texture/Card/card_spades_02.png", "res://Assets/Texture/Card/card_spades_03.png", "res://Assets/Texture/Card/card_spades_04.png", "res://Assets/Texture/Card/card_spades_05.png", "res://Assets/Texture/Card/card_spades_06.png", "res://Assets/Texture/Card/card_spades_07.png", "res://Assets/Texture/Card/card_spades_08.png", "res://Assets/Texture/Card/card_spades_09.png", "res://Assets/Texture/Card/card_spades_10.png", "res://Assets/Texture/Card/card_spades_J.png", "res://Assets/Texture/Card/card_spades_K.png", "res://Assets/Texture/Card/card_spades_Q.png", 
]

@onready var front: MeshInstance3D = $Front

var id

func set_card(new_id):
	id = new_id
	var image = load(card_texture[new_id])
	var material = front.get_surface_override_material(0)
	
	if material == null:
		material = front.mesh.surface_get_material(0)
	
	material = material.duplicate()
	material.albedo_texture = image
	
	front.set_surface_override_material(0, material)
