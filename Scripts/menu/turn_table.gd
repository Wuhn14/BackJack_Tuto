extends Node3D

@export var turn_speed = 8;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation.y += deg_to_rad(turn_speed)*delta
