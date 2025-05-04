extends Microgame

@export var boulder_speed = 100 # speed of the boulder
var has_won = false # checks if the signals have been emited
var has_lost = false # checks if the signals have been emited

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super() # calls the _ready function of microgame main
	countdown.start() # starts the timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$'ParallaxBackground'.scroll_base_offset.x += -boulder_speed*delta # adds movement to the game without camera


func _on_boulder_body_entered(body: Node2D) -> void:
	if !has_lost and !has_won: #checks if any signals have been emmited
		has_lost = true # has emitedd lose signal
		emit_signal('lose_game') # emits the signal


func _on_countdown_timeout():
	if !has_won and !has_lost: #checks if any signals have been emmited
		has_won = true # has emitedd win signal
		emit_signal('win_game') # emits the signal
