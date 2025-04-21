extends Node
class_name Microgame


# VARIABLES
@export_group("Microgame Info")

## The name of your game.
@export var game_name : String

## Give a short description of your game, how to win/lose, controls, etc.
@export_multiline var game_description : String

@export_group("Microgame Settings")

## How long your game runs for in seconds.
@export var game_length : int = 4

## The short message that briefly shows when your game starts. Try to limit its length to under 30 characters.
@export var message : String = "Message!"

@onready var countdown = Timer.new()

# SIGNALS
signal win_game
signal lose_game

# FUNCTIONS
func _on_countdown_timeout():
	pass

func _ready() -> void:
	add_child(countdown)
	countdown.timeout.connect(_on_countdown_timeout)
	countdown.one_shot = true
