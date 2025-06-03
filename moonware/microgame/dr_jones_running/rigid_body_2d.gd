extends Area2D

@export var rotation_speed = 200 # speed of the boulder spinning
@export var running_speed = 10 # speed of the boulder moving right


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$animated.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$animated.rotation_degrees +=rotation_speed # rotates the boulder
	position.x += running_speed # moves the boulder
	
