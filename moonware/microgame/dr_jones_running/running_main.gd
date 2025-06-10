extends Microgame

@export var boulder_speed = 100 # speed of the boulder
var has_won = false # checks if the signals have been emited
var has_lost = false # checks if the signals have been emited

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super() # calls the _ready function of microgame main
	$indiana/TextureProgressBar.max_value = game_length
	countdown.start() # starts the timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $indiana:
		$indiana/TextureProgressBar.value = countdown.time_left


func _on_boulder_body_entered(body: Node2D) -> void:
	if !has_lost and !has_won: #checks if any signals have been emmited
		has_lost = true # has emited lose signal
		$indiana/animated.play('explode')


func _on_countdown_timeout():
	if !has_won and !has_lost: #checks if any signals have been emmited
		print('jjj')
		has_won = true # has emitedd win signal
		$boulder/animated.play("explode")
		$boulder/animated.scale = Vector2(7,7)

func _on_rock_explosion_finished() -> void:
	$boulder.queue_free()
	emit_signal('win_game') # emits the signal


func _on_jones_explosion_finished() -> void:
	$indiana.queue_free()
	emit_signal('lose_game') # emits the signal
