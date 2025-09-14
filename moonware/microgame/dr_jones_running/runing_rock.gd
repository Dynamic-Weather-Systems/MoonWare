extends Area2D

@export var rotation_speed = 200 # speed of the boulder spinning
@export var running_speed = 10 # speed of the boulder moving right

signal explosion_finished

var state: int
enum {PAUSED, IDLE, PLAYING}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$animated.play("default") # no animation in default


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$animated.rotation_degrees +=rotation_speed * int(state==PLAYING)# rotates the boulder
	position.x += running_speed * int(state==PLAYING) # moves the boulder

func explode():
	print("explode func")
	$animated.play("explode")

func _on_animated_animation_finished() -> void:
	if $animated.animation == 'explode':
		explosion_finished.emit()
