extends Microgame

@export var boulder_speed = 100 # speed of the boulder
var has_won = false # checks if the signals have been emited
var has_lost = false # checks if the signals have been emited

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super() # calls the _ready function of microgame main
	countdown.start() # starts the timer


func _on_boulder_body_entered(body: Node2D) -> void:
	if !has_lost and !has_won: #checks if any signals have been emmited
		has_lost = true # has emited lose signal
		$indiana/animated.play('explode') # start explode animation


func _on_countdown_timeout():
	if !has_won and !has_lost: #checks if any signals have been emmited
		has_won = true # has emitedd win signal
		$boulder/animated.play("explode") # start explode animation
		$boulder/animated.scale = Vector2(7,7) # increase scale so explosion is correct size


func _on_audio_stream_player_finished() -> void:
	if has_lost:
		$indiana.queue_free() # delete player
		emit_signal('lose_game') # emits the signal
		print('lose')
	elif has_won:
		$indiana.queue_free() # delete player
		emit_signal('lose_game') # emits the signal
		print('win')
