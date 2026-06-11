extends Node3D

var card_scene = preload("res://Scenes/Game/Object/card.tscn")

var current_x_offset = 0
var x_step = 4.35
var card_number = 0

var total_card = 52

var amount_of_card = 0

var is_dealer = null

var card_value = [
	1,2,3,4,5,6,7,8,9,10,10,10,10,
	1,2,3,4,5,6,7,8,9,10,10,10,10,
	1,2,3,4,5,6,7,8,9,10,10,10,10,
	1,2,3,4,5,6,7,8,9,10,10,10,10,
]

func reset_all():
	current_x_offset = 0
	card_number = 0
	amount_of_card = 0
	for card in $card_stack.get_children():
		card.queue_free()

func dealer_card_reveal():
	$card_stack.get_child(0).rotation.z = 0

func is_player():
	is_dealer = false

func isnt_player():
	is_dealer = true


func first_dealer_card(new_card):
	new_card.rotation.z = deg_to_rad(180)
	amount_of_card += 1

func take_one_card(score, card_in_deck, used_card) -> int:
	if card_in_deck > 0:
		var id = randi_range(0, total_card-1)
		while id in used_card and card_in_deck != 0:
			id = randi_range(0, total_card-1)
		card_in_deck -= 1
		used_card.append(id)
		score = await add_card(id, score)
	else:
		print("No more card in deck")
	await get_tree().create_timer(0.5).timeout
	return score

func add_card(id, score) -> int:
	card_number += 1
	var new_card = card_scene.instantiate()
	new_card.transform.origin.x = current_x_offset
	if amount_of_card == 0 and is_dealer:
		first_dealer_card(new_card)
	current_x_offset += x_step
	$card_stack.add_child(new_card)
	new_card.set_card(id)
	$card_stack.transform.origin.x = (-(current_x_offset-x_step)/2)
	
	score = await calculate_value(id, score)
	return score


func calculate_value(id, score) -> int:
	var tempScore = 0
	if card_value[id] == 1 :
		if !is_dealer:
			tempScore = await $"../Camera3D/Game_UI/Ask".get_result()
			if tempScore == 11 :
				score += 11
			else: 
				score += 1
		else:
			score += 11
	else:
		score += card_value[id]
		
	print(score)
	if !is_dealer:
		print("PLayer END")
	else:
		print("Dealer END")
	return score
