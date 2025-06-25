extends Area2D

var held_body = null
var is_holding:= false
var offset_position: Vector2


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _physics_process(delta: float) -> void:
	global_position = get_global_mouse_position()
	if held_body != null and is_holding:
		held_body.global_position = get_global_mouse_position() - offset_position


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_mouse") and !is_holding:
		var overlapping_areas = get_overlapping_areas()
		if len(overlapping_areas) != 0:
			held_body = overlapping_areas[0]
			offset_position = get_global_mouse_position() - held_body.global_position
			is_holding = true
	if Input.is_action_just_released("left_mouse") and is_holding:
		is_holding = false
		
