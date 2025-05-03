extends CharacterBody2D


@export var SPEED = 300.0


func _physics_process(delta: float) -> void:	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction < 0:
		$animated.flip_h = true
	elif direction > 0:
		$animated.flip_h = false
	
	if direction:
		$animated.play("default")
		velocity.x = direction * SPEED
	else:
		$animated.pause()
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
