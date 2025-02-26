extends Node

@export var minigames: Array[PackedScene]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_scene_instantiate = minigames.pick_random().instantiate()
	add_child(new_scene_instantiate)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
