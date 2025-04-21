extends Microgame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	print("ready_clickygame")
	countdown.start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_win_pressed() -> void:
	emit_signal("win_game")

func _on_lose_pressed() -> void:
	emit_signal("lose_game")

func _on_countdown_timeout():
	pass
