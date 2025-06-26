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
	
	%HighScore.text = "High Score: " + str(highScore)
	%Score.text = "Score: " + str(score)
	%ChannelCountLabel.text = "Channels: " + str(channels)
	
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
