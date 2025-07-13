extends Microgame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super() # calls the _ready function of microgame main
	$EndMessage.text = ''
	
	var labels = $texts.get_children()
	var sprites = $sprites.get_children()
	labels.shuffle()
	sprites.shuffle()
	for i in range(len(labels)):
		labels[i].position.x = ((90 * (i+1)) - 50) + (i-2) * 15
		sprites[i].position.x = (90 * (i+1))
		var rand_temp = Vector2(randi_range(15,30), randi_range(15,30))
		labels[i].text = str(labels[i].name) + '\nHi    Lo\n' + str(max(rand_temp.x,rand_temp.y)) + '   ' + str(min(rand_temp.x,rand_temp.y))
	
	countdown.start() # starts the timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_countdown_timeout():
	$BackgroundSetup.hide()
	$texts.hide()
	$sprites.hide()
	
	$sounds/background.stop()
	var labels = $texts.get_children()
	var sprites = $sprites.get_children()
	var won = true
	
	for i in range(len(labels)):
		if labels[i].get_child(0).get_overlapping_areas() == [] or labels[i].get_child(0).get_overlapping_areas()[0] != sprites[i]:
			won = false
			break
	
	if won:
		$sounds/win.play()
		$EndMessage.text = win_message
	else:
		$sounds/lose.play()
		$EndMessage.text = lose_message


func _on_background_finished() -> void:
	$sounds/background.play()


func _on_win_finished() -> void:
	emit_signal('win_game')


func _on_lose_finished() -> void:
	emit_signal('lose_game')
