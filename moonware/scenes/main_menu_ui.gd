# Handles Behaviour of the Main Menu Screen
extends Control


# Signals
## signal emitted when player pressed "Play"
signal start_game()



# startup function
func _ready() -> void:
	%MainVBoxContainer.show()
	%OptionsVBoxContainer.hide()


func _on_play_button_pressed() -> void:
	print("pressed play")
	start_game.emit()



func _on_options_button_pressed() -> void:
	print("pressed options")
	%OptionsVBoxContainer.show()
	%MainVBoxContainer.hide()



func _on_quit_button_pressed() -> void:
	print("pressed quit")
	get_tree().quit()


func _on_options_back_button_pressed() -> void:
	%MainVBoxContainer.show()
	%OptionsVBoxContainer.hide()
