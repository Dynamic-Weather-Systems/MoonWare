extends Node2D

var minigame_click = preload("res://microgame/clicky_game/clicky_game.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var minigame_instance = minigame_click.instantiate()
	add_child(minigame_instance)
	minigame_instance.connect('lose_game', loser)
	minigame_instance.connect('win_game', win)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func loser():
	print("lose")

func win():
	print("win")
