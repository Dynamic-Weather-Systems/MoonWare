extends Node2D

var on_rest_position := true
var rest_pic = load("res://Assets/Art/fitness_sprite2.png")
var stretch_pic = load("res://Assets/Art/fitness_sprite1.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Dance.play('bopping')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_audio_stream_player_finished() -> void:
	%AudioStreamPlayer.play()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_mouse") and on_rest_position:
		%dancers.texture = stretch_pic
		%dancers2.texture = stretch_pic
		%dancers3.texture = stretch_pic
		on_rest_position = false
	elif Input.is_action_just_pressed("left_mouse") and !on_rest_position:
		%dancers.texture = rest_pic
		%dancers2.texture = rest_pic
		%dancers3.texture = rest_pic
		
		%dancers.flip_h = !%dancers.flip_h
		%dancers2.flip_h = !%dancers2.flip_h
		%dancers3.flip_h = !%dancers3.flip_h
		on_rest_position = true
