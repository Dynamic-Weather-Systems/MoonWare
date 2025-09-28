extends Microgame

var has_won := false
var has_lost := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	%EndMessage.text = ''
	countdown.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_mouse_area_mouse_exited() -> void:
	_mouse_moved()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("any_mouse_action"):
		_mouse_moved()

func _on_countdown_timeout():
	%MouseArea.queue_free()
	%background.stop()
	
	if !has_won and !has_lost:
		has_won = true
		%win.play()
		%EndMessage.text = win_message


func _mouse_moved():
	if !has_won and !has_lost:
		has_lost = true
		%background.stop()
		%lose.play()
		%EndMessage.text = lose_message
		%MouseArea.queue_free()


func _on_background_finished() -> void:
	%background.play()
