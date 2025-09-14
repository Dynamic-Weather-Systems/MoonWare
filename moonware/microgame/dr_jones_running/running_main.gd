# Running game where you click to outrun a boulder
# Sanjit Patil and Sujit Patil
# Created 2025

extends Microgame

@export var boulder_scene: PackedScene
var has_won = false # checks if the signals have been emited
var has_lost = false # checks if the signals have been emited

func _ready() -> void:
	super()


func set_state_paused():
	super()
	%boulder.state = PAUSED


func set_state_idle():
	super()
	%boulder.state = IDLE



# Called once when the state is set to PLAYING
func set_state_playing() -> void:
	super() # calls the _ready function of microgame main
	#assert(boulder_scene != null)
	#var boulder_instance = boulder_scene.instantiate()
	#boulder_instance.position = Vector2(-184,234)
	#add_child(boulder_instance)
	$indiana/TextureProgressBar.max_value = game_length # sets up the progress bar
	countdown.start() # starts the timer
	%boulder.state = PLAYING


func process_playing():
	super()
	if $indiana: # if indiana node exists
		$indiana/TextureProgressBar.value = countdown.time_left # update the progress bar


func _on_boulder_body_entered(body: Node2D) -> void:
	if !has_lost and !has_won: #checks if any signals have been emmited
		has_lost = true # has emited lose signal
		$indiana/animated.play('explode') # start explode animation


func _on_countdown_timeout():
	if !has_won and !has_lost: #checks if any signals have been emmited
		has_won = true # has emitedd win signal
		print("boulder exploded nerd")
		$boulder.explode() # start explode animation
		$boulder/animated.scale = Vector2(7,7) # increase scale so explosion is correct size

func _on_rock_explosion_finished() -> void:
	$boulder.queue_free() # delete boulder
	emit_signal('win_game') # emits the signal


func _on_jones_explosion_finished() -> void:
	$indiana.queue_free() # delete player
	emit_signal('lose_game') # emits the signal
