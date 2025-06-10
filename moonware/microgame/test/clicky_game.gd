extends Microgame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super() # calls ready func of Microgame.gd
	countdown.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_win_pressed() -> void:
	print("win")
	emit_signal("win_game")

func _on_lose_pressed() -> void:
	print("lose")
	emit_signal("lose_game")

func _on_countdown_timeout():
	print("press_timer")
	emit_signal("lose_game")
