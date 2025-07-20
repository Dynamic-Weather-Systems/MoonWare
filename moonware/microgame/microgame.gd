# Microgame Class
# Sanjit Patil and Sujit Patil
# Created 2025
#
# Holds the behaviour and functionality of microgames.
# 
# Microgames should have 3 states: [PAUSED] -> IDLE -> PLAYING -> (emit signals to end)
# 		[PAUSED]: (Loaded but not shown) When a microgame is loaded into the main scene, it will be
#			loaded in this state. The microgame should be hidden and generally not be running any
#			functionality. Sets process and input handling to false. ("_process", 
#			"_physics_process", "_input", "_uhandled_input" will not run).
# 		IDLE: (Loaded and showing but not playable). When the minigame is being displayed on screen,
# 			along with the instructions on how to play the microgame. This state should generally
#			be processing "idle" animations and other such behaviours. Sets process to false, and 
#			input to true. ("_process", "_physics_process" will run but "_input", "_uhandled_input" 
#			will not run).
# 		PLAYING: (Fully playable and interactable). Sets process and input to true. ("_process",
#			"_physics_process" will run but "_input", "_uhandled_input" will run).

extends Node2D
class_name Microgame


# VARIABLES
var state: int

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

# creates a new timer for the minigame
@onready var countdown = Timer.new()

# state enum
enum {PAUSED, IDLE, PLAYING}

# SIGNALS
signal win_game
signal lose_game


func _ready() -> void:
	assert(game_name)
	
	# Adds all the nodes in the current microgame to the same group
	add_to_group(game_name)
	for child in get_children():
		child.add_to_group(game_name)
		
	set_minigame_state(PAUSED)


func _process(delta: float) -> void:
	match state:
		IDLE:
			process_idle()
		PLAYING:
			process_playing()



# FUNCTIONS
# empty func that's called at the end of the timeout
func _on_countdown_timeout() -> void:
	pass


# switch state of minigame
func set_minigame_state(new_state: int) -> void:
	state = new_state
	match state:
		PAUSED:
			set_state_paused()
		IDLE:
			set_state_idle()
		PLAYING:
			set_state_playing()


# Behaviour for the state to be idle
func set_state_paused() -> void:
	assert(game_name)
	hide()
	get_tree().call_group(game_name, "set_process", false)
	get_tree().call_group(game_name, "set_physics_process", false)
	get_tree().call_group(game_name, "set_process_input", false)
	get_tree().call_group(game_name, "set_process_unhandled_input", false)



# Behaviour for the state to be idle
func set_state_idle() -> void:
	assert(game_name)
	show()
	get_tree().call_group(game_name, "set_process", true)
	get_tree().call_group(game_name, "set_physics_process", true)
	get_tree().call_group(game_name, "set_process_input", false)
	get_tree().call_group(game_name, "set_process_unhandled_input", false)


# Behaviour for the state to be idle
func set_state_playing() -> void:
	assert(game_name)
	show()
	get_tree().call_group(game_name, "set_process", true)
	get_tree().call_group(game_name, "set_physics_process", true)
	get_tree().call_group(game_name, "set_process_input", false)
	get_tree().call_group(game_name, "set_process_unhandled_input", false)
	
	# adds a timer to each minigame
	add_child(countdown)
	countdown.timeout.connect(_on_countdown_timeout)
	countdown.one_shot = true
	countdown.wait_time = game_length


# empty function to hold process functionality when the game is in the "IDLE" State
func process_idle() -> void:
	pass


# empty function to hold process functionality when the game is in the "PLAYING" State
func process_playing() -> void:
	pass
