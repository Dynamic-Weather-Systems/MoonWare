extends Microgame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	countdown.start()
	%EndMessage.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_countdown_timeout():
	%EndMessage.show()
	%sprites.queue_free()
	%MusicNotes.queue_free()
	%BackgroundMusic.stop()
	
	if %MusicNotes.score > 9:
		%WinSound.play()
		%EndMessage.text = win_message
	else:
		%LoseSound.play()
		%EndMessage.text = lose_message


func _on_lose_sound_finished() -> void:
	emit_signal('lose_game')


func _on_win_sound_finished() -> void:
	emit_signal('win_game')
