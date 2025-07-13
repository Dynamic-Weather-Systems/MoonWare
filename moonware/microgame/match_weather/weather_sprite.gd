extends Area2D


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func drop():
	var overlap = get_overlapping_areas()
	if len(overlap) != 0:
		var held_body = overlap[0]
		global_position = held_body.global_position + Vector2(50,-50)
