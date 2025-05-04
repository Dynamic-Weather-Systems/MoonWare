extends CharacterBody2D


@export var SPEED = 300.0 # speed of the player running
var direction = 0 # direction of the player


func _physics_process(delta: float) -> void:
	direction = move_toward(direction, 0, 0.05) # moves direction toward 0 if no clicking
	
	if direction: # if moving
		$animated.play("default") # play running animation
		velocity.x = direction * SPEED # add to the velocity of the player
	else: # if not moving
		$animated.pause() # stop running animation
		velocity.x = move_toward(velocity.x, 0, SPEED) # stop moving
	
	move_and_slide() # update movements


func _input(event: InputEvent) -> void: # if input is called
	if Input.is_action_just_pressed('left_mouse'): # if left mouse is just clicked
		direction = Input.get_action_strength("left_mouse") # set direction to click strength
