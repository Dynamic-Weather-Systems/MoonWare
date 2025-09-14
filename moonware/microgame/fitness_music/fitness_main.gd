extends Microgame


@export var win_message: String
@export var lose_message: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called when the state of the minigame is first set to paused
func set_state_paused():
	super()
	%MusicNotes.state = PAUSED


# Called when the state of the minigame is first set to paused
func set_state_idle():
	super()
	print("loadertgofd")
	%MusicNotes.state = IDLE
	%BackgroundMusic.autoplay = true
	%BackgroundMusic.play(0)


# Called when the state of the minigame is first set to paused
func set_state_playing():
	super()
	%MusicNotes.state = PLAYING
	%BackgroundMusic.autoplay = true
	%BackgroundMusic.play(0)
	countdown.start()


func _on_countdown_timeout():
	print("game over")
	
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
