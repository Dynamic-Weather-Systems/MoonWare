extends Area2D

@export var rotation_speed = 200
@export var running_speed = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation_degrees +=rotation_speed
	position.x += running_speed
	
