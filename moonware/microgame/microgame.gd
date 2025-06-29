extends Node
class_name Microgame


# VARIABLES
@export_group("Microgame Info")

## The name of your game.
@export var game_name := 'game name'

## Give a short description of your game, how to win/lose, controls, etc.
@export_multiline var game_description := 'description'

@export_group("Microgame Settings")

## How long your game runs for in seconds.
@export var game_length := 4

## The short message that briefly shows when your game ends. Try to limit its length to under 30 characters.
@export var win_message := "Message!"
@export var lose_message := "Message!"

# creates a new timer for the minigame
@onready var countdown = Timer.new()

# SIGNALS
signal win_game
signal lose_game

# FUNCTIONS
# empty func that's called at the end of the timeout
func _on_countdown_timeout():
	pass

func _ready() -> void:
	# adds a timer to each minigame
	add_child(countdown)
	countdown.timeout.connect(_on_countdown_timeout)
	countdown.one_shot = true
	countdown.wait_time = game_length
	
