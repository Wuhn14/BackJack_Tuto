extends Node3D

@onready var GameState_Label : Label = $Camera3D/Game_UI/GameStateLabel
@onready var YouHave_Label : Label = $Camera3D/Game_UI/Info/YouHaveLabel
@onready var YourBet_Label : Label = $Camera3D/Game_UI/Info/YourBetLabel
@onready var warningMess : Label = $Camera3D/Game_UI/WarningMess
@onready var NewGameButton : Button = $Camera3D/Game_UI/NewGame
@onready var Chips = $Chips
@onready var PlayerCards = $PlayerCards
@onready var DealerCards = $DealerCards

@onready var audio_source = $audio_source
@onready var  background_sound = $Background_sound
@onready var  change = $change

var all_bg = [
	preload("res://Assets/Audio/Background_sound-1.mp3"),
	preload("res://Assets/Audio/Background_sound-2.mp3"),
	preload("res://Assets/Audio/Background_sound-3.mp3"),
	preload("res://Assets/Audio/Background_sound-4.mp3"),
	preload("res://Assets/Audio/Background_sound-5.mp3"),
	preload("res://Assets/Audio/Background_sound-6.mp3"),
	preload("res://Assets/Audio/Background_sound-7.mp3"),
	preload("res://Assets/Audio/Background_sound-8.mp3"),
	preload("res://Assets/Audio/Background_sound-9.mp3"),
	preload("res://Assets/Audio/Background_sound-10.mp3"),
	preload("res://Assets/Audio/Background_sound-11.mp3"),
	preload("res://Assets/Audio/Background_sound-12.mp3"),
	preload("res://Assets/Audio/Background_sound-13.mp3"),
	preload("res://Assets/Audio/Background_sound-14.mp3"),
	preload("res://Assets/Audio/Background_sound-15.mp3"),
	preload("res://Assets/Audio/Background_sound-16.mp3"),
	preload("res://Assets/Audio/Background_sound-17.mp3"),
	preload("res://Assets/Audio/Background_sound-18.mp3"),
	preload("res://Assets/Audio/Background_sound-19.mp3"),
	preload("res://Assets/Audio/Background_sound-20.mp3"),
	preload("res://Assets/Audio/Background_sound-21.mp3"),
	preload("res://Assets/Audio/Background_sound-22.mp3"),
	preload("res://Assets/Audio/Background_sound-23.mp3"),
	preload("res://Assets/Audio/Background_sound-24.mp3"),
	preload("res://Assets/Audio/Background_sound-25.mp3"),
	preload("res://Assets/Audio/Background_sound-26.mp3"),
	preload("res://Assets/Audio/Background_sound-27.mp3"),
	preload("res://Assets/Audio/Background_sound-28.mp3"),
	preload("res://Assets/Audio/Background_sound-29.mp3"),
	preload("res://Assets/Audio/Background_sound-30.mp3"),
	preload("res://Assets/Audio/Background_sound-31.mp3"),
	preload("res://Assets/Audio/Background_sound-32.mp3"),
	preload("res://Assets/Audio/Background_sound-33.mp3"),
	preload("res://Assets/Audio/Background_sound-34.mp3"),
	preload("res://Assets/Audio/Background_sound-35.mp3"),
	preload("res://Assets/Audio/Background_sound-36.mp3"),
	preload("res://Assets/Audio/Background_sound-37.mp3"),
	preload("res://Assets/Audio/Background_sound-38.mp3"),
	preload("res://Assets/Audio/Background_sound-39.mp3"),
	preload("res://Assets/Audio/Background_sound-40.mp3"),
	preload("res://Assets/Audio/Background_sound-41.mp3"),
	preload("res://Assets/Audio/Background_sound-42.mp3"),
	preload("res://Assets/Audio/Background_sound-43.mp3"),
]

var change_sound = preload("res://Assets/Audio/Change_song.mp3")

func _on_background_sound_finished() -> void:
	play_background()

@onready var card_place = [
	preload("res://Assets/Audio/card-place-1.ogg"),
	preload("res://Assets/Audio/card-place-2.ogg"),
	preload("res://Assets/Audio/card-place-3.ogg"),
	preload("res://Assets/Audio/card-place-4.ogg")
]

@onready var chips_sound = [
	preload("res://Assets/Audio/chip-lay-1.ogg"),
	preload("res://Assets/Audio/chip-lay-2.ogg"),
	preload("res://Assets/Audio/chips-collide-1.ogg"),
	preload("res://Assets/Audio/chips-collide-2.ogg"),
	preload("res://Assets/Audio/chips-collide-3.ogg"),
	preload("res://Assets/Audio/chips-collide-4.ogg"),
	preload("res://Assets/Audio/chips-stack-1.ogg"),
	preload("res://Assets/Audio/chips-stack-2.ogg"),
	preload("res://Assets/Audio/chips-stack-4.ogg"),
	preload("res://Assets/Audio/chips-stack-5.ogg"),
	preload("res://Assets/Audio/chips-stack-6.ogg")
]



var bet = 0
var state = 0
var multiply_Win = [2,0,1,3]
var type_win = 0

var used_card = []
var card_in_deck = 52
var playerScore = 0
var dealerScore = 0

var values = [
	1,5,25,100,500
]

var sound = []

#@onready var state_text = [
#	"Place your beat", #0
#	"Dealers giving card...",#1
#	"your turn",#2
#	"dealer turn",#3
#	
#	"You WIN ! \n" + str(bet*multiply_Win[type_win]) + " for you !",#4
#	"You Lose ! \n" + str(bet) + " for the dealers",#5
#	"DRAW ! " + str(bet) + " return",#6
#	"BLACKJACK !\n" + str(bet*multiply_Win[type_win]) + " for you !",#7
#	"New Game ?", #8
#	"No mor money ? \n Good Bye, see you next time !", #9
#]



func play_sound(id):
	if audio_source.playing:
		audio_source.stop()
	var list_of_sound = sound[id]
	audio_source.stream = list_of_sound.pick_random()
	audio_source.play();


func play_background():
	change.play()
	await change.finished;
	background_sound.stream = all_bg.pick_random()
	background_sound.play()

func Skip_song() -> void :
	$Camera3D/Game_UI/Skip_Song.disabled = true
	background_sound.stop()
	await play_background()
	$Camera3D/Game_UI/Skip_Song.disabled = false

func _ready() -> void:
	sound = [card_place, chips_sound]
	Skip_song()
	PlayerCards.is_player()
	DealerCards.isnt_player()
	actu_info()
	await actu_GMState(0)

func set_game_ui(mise_visible: bool, info_visible: bool, hitstand_visible: bool, newgame_visible: bool) -> void:
	if mise_visible:
		$Camera3D/Game_UI/MisePanel.show()
	else:
		$Camera3D/Game_UI/MisePanel.hide()

	if info_visible:
		$Camera3D/Game_UI/Info.show()
	else:
		$Camera3D/Game_UI/Info.hide()

	if hitstand_visible:
		$Camera3D/Game_UI/HitStandPanel.show()
	else:
		$Camera3D/Game_UI/HitStandPanel.hide()

	if newgame_visible:
		NewGameButton.show()
	else:
		NewGameButton.hide()


func actu_GMState(id: int) -> void:
	state = id

	match state:
		0:
			GameState_Label.text = "Place your bet"
			set_game_ui(true, true, false, false)

		1:
			GameState_Label.text = "Dealer is giving cards..."
			set_game_ui(false, false, false, false)
			distrib_card()

		2:
			GameState_Label.text = "Your turn"
			set_game_ui(false, false, true, false)

		3:
			GameState_Label.text = "Dealer turn"
			set_game_ui(false, false, false, false)
			dealerPlay()

		4:
			GameState_Label.text = "You WIN !\n" + str(bet * multiply_Win[type_win]) + " for you !"
			set_game_ui(false, false, false, false)
			await get_tree().create_timer(2.0).timeout
			end_game(state)

		5:
			GameState_Label.text = "You Lose !\n" + str(bet) + " for the dealer"
			set_game_ui(false, false, false, false)
			await get_tree().create_timer(2.0).timeout
			end_game(state)

		6:
			GameState_Label.text = "DRAW ! " + str(bet) + " returned"
			set_game_ui(false, false, false, false)
			await get_tree().create_timer(2.0).timeout
			end_game(state)

		7:
			GameState_Label.text = "BLACKJACK !\n" + str(bet * 3) + " for you !"
			set_game_ui(false, false, false, false)
			await get_tree().create_timer(2.0).timeout
			end_game(state)

		8:
			GameState_Label.text = "New Game ?"
			set_game_ui(false, false, false, true)

		9:
			GameState_Label.text = "No more money ?\nGood Bye, see you next time !"
			set_game_ui(false, false, false, true)

		_:
			await actu_GMState(0)


func reset_all():
	Chips.reset_all()
	PlayerCards.reset_all()
	DealerCards.reset_all()
	bet = 0
	type_win = 0
	card_in_deck = 52
	used_card = []
	dealerScore = 0
	playerScore = 0
	actu_info()
	print("NEWGAME NEWGAME NEWGAME NEWGAME NEWGAME")

func actu_info():
	YouHave_Label.text = "You have : " + str(DataManager.money)
	YourBet_Label.text = "You bet : " + str(bet)

func Player_take_card():
	play_sound(0)
	playerScore = await PlayerCards.take_one_card(playerScore, card_in_deck, used_card)

func Dealer_take_card():
	play_sound(0)
	dealerScore = await DealerCards.take_one_card(dealerScore, card_in_deck, used_card)

func distrib_card():
	await Dealer_take_card()
	await Dealer_take_card()
	await Player_take_card()
	await Player_take_card()
	if playerScore == 21:
		await actu_GMState(7)
	elif playerScore >= 22:
		await actu_GMState(5)
	else:
		await actu_GMState(2)


func _on_hit_button_pressed() -> void:
	await Player_take_card()
	if playerScore > 21:
		await actu_GMState(5)


func _on_stand_button_pressed() -> void:
	await actu_GMState(3)


func dealerPlay():
	DealerCards.dealer_card_reveal()
	while dealerScore <= 16:
		await Dealer_take_card()
	if dealerScore > 21:
		await actu_GMState(4)
	else:
		who_win()

func who_win():
	if playerScore == dealerScore:
		await actu_GMState(6)
	elif playerScore > dealerScore:
		await actu_GMState(4)
	else:
		await actu_GMState(5)
	

func end_game(id):
	type_win = id-4
	DataManager.money += bet*multiply_Win[type_win] 
	if DataManager.money <= 0:
		finish_game()
	else:
		await actu_GMState(8)

func finish_game():
	DataManager.money = 15
	await actu_GMState(9)

func warningMessDialog(text, fontSize = 0) -> void:
	warningMess.text = text
	if fontSize > 15:
		warningMess.add_theme_font_size_override("font_size", fontSize)
	else:
		warningMess.add_theme_font_size_override("font_size", 50)
	warningMess.show()
	await get_tree().create_timer(2).timeout
	warningMess.hide()

func i_have_bet_something() -> void:
	if bet > 0 and state == 0:
		await actu_GMState(1)
	else:
		warningMessDialog("Bet minimum 1€ for DONE !", 80)


func i_have_money(id) -> void:
	if DataManager.money >= values[id]:
		DataManager.money -= values[id]
		bet += values[id]
		Chips.add_chips(id)
		play_sound(1)
	else:
		warningMessDialog("You have only " + str(DataManager.money) + ", you can't bet " + str(values[id]) + " !")
	actu_info()


func _on_bet_done_pressed() -> void:
	i_have_bet_something()


func _on_bet_white_pressed() -> void:
	i_have_money(0)


func _on_bet_red_pressed() -> void:
	i_have_money(1)


func _on_bet_green_pressed() -> void:
	i_have_money(2)


func _on_bet_black_pressed() -> void:
	i_have_money(3)


func _on_bet_blue_pressed() -> void:
	i_have_money(4)


func _on_new_game_pressed() -> void:
	reset_all()
	await actu_GMState(0)


func _on_skip_song_pressed() -> void:
	Skip_song()
