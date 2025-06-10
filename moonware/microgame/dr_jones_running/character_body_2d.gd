extends CharacterBody2D


@export var SPEED = 300.0 # speed of the player running
var direction = 0 # direction of the player
var old_pos # keeps track of how far the player has moved

func _ready() -> void:
	$animated.play("default") # the default running animation
	old_pos = global_position # keeps track of how far the player has moved


func _physics_process(delta: float) -> void:
	direction = move_toward(direction, 0, 0.05) # moves direction toward 0 if no clicking
	
	if $animated.animation == 'explode': # if the player is exploding
		velocity.x = move_toward(velocity.x, 0, SPEED) # stop moving
	elif direction: # if moving
		$animated.play("default") # play running animation
		velocity.x = direction * SPEED # add to the velocity of the player
	elif $animated.animation == 'default': # if not moving and not explodings
		$animated.pause() # stop running animation
		velocity.x = move_toward(velocity.x, 0, SPEED) # stop moving
	
	move_and_slide() # update movements
	
	%cave.global_position += (old_pos - global_position)/2 # add paralx 
	%cave2.global_position += (old_pos - global_position)/2 # add paralx 
	%stalagmite.global_position += old_pos - global_position # add paralx 
	%stalagmite2.global_position += old_pos - global_position # add paralx 
	%stalagmite3.global_position += old_pos - global_position # add paralx 
	%stalagmite4.global_position += old_pos - global_position # add paralx 
	%stalagmite5.global_position += old_pos - global_position # add paralx 
	%stalagmite6.global_position += old_pos - global_position # add paralx 
	$"..".global_position += old_pos - global_position # add paralx 
	if %boulder: # if boulder exists
		%boulder.global_position += old_pos - global_position # add paralx 
	old_pos = global_position # updates the current position


func _input(event: InputEvent) -> void: # if input is called
	if Input.is_action_just_pressed('left_mouse'): # if left mouse is just clicked
		direction = Input.get_action_strength("left_mouse") # set direction to click strength
