# Handles Behaviour of the Main Menu Screen
extends Control


# Signals
## signal emitted when player pressed "Play"
signal start_game()



# startup function
func _ready() -> void:
	%MainMenuPage.show()
	%OptionsPage.hide()
	%GameOverPage.hide()


func game_over(score: int, highScore: int, time_ms: int, channels: int) -> void:
	%MainMenuPage.hide()
	%OptionsPage.hide()
	var rem = time_ms
	var hours = floor(rem/3600000)
	if (hours/10 < 1):
		hours = "0" + str(hours)
	else:
		hours = str(hours)
	
	rem = rem % 3600000
	var mins = rem/60000
	if (mins/10 < 1):
		mins = "0" + str(mins)
	else:
		mins = str(mins)
	
	rem = rem%60000
	var secs = rem/1000
	if (secs/10 < 1):
		secs = "0" + str(secs)
	else:
		secs = str(secs)
	%HighScore.text = "High Score: " + str(highScore)
	%Score.text = "Score: " + str(score)
	%ChannelCountLabel.text = "Channels: " + str(channels)
	%TimeLabel.text = hours + " : " + mins  + " : " + secs
	%GameOverPage.show()


func _on_play_button_pressed() -> void:
	start_game.emit()


func _on_options_button_pressed() -> void:
	print("pressed options")
	%OptionsPage.show()
	%MainMenuPage.hide()



func _on_quit_button_pressed() -> void:
	print("pressed quit")
	get_tree().quit()


func _on_options_back_button_pressed() -> void:
	%MainMenuPage.show()
	%OptionsPage.hide()
	%GameOverPage.hide()
