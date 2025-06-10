extends CharacterBody2D


@export var SPEED = 300.0 # speed of the player running
var direction = 0 # direction of the player
var old_pos

func _ready() -> void:
	$animated.play("default")
	old_pos = global_position


func _physics_process(delta: float) -> void:
	direction = move_toward(direction, 0, 0.05) # moves direction toward 0 if no clicking
	
	if $animated.animation == 'explode':
		velocity.x = move_toward(velocity.x, 0, SPEED) # stop moving
	elif direction: # if moving
		$animated.play("default") # play running animation
		velocity.x = direction * SPEED # add to the velocity of the player
	elif $animated.animation == 'default': # if not moving and not explodings
		$animated.pause() # stop running animation
		velocity.x = move_toward(velocity.x, 0, SPEED) # stop moving
	
	move_and_slide() # update movements
	%cave.global_position += (old_pos - global_position)/2
	%cave2.global_position += (old_pos - global_position)/2
	%stalagmite.global_position += old_pos - global_position
	%stalagmite2.global_position += old_pos - global_position
	%stalagmite3.global_position += old_pos - global_position
	%stalagmite4.global_position += old_pos - global_position
	%stalagmite5.global_position += old_pos - global_position
	%stalagmite6.global_position += old_pos - global_position
	$"..".global_position += old_pos - global_position
	if %boulder:
		%boulder.global_position += old_pos - global_position
	old_pos = global_position


func _input(event: InputEvent) -> void: # if input is called
	if Input.is_action_just_pressed('left_mouse'): # if left mouse is just clicked
		direction = Input.get_action_strength("left_mouse") # set direction to click strength
