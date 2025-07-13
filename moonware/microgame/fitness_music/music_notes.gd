extends Node2D

var score : int = 0
var juice_message = load('res://microgame/fitness_music/juice_message.tscn')


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%beats.play('beat order')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#print()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		var beat := []
		beat = %OnBeatChecker.get_overlapping_areas()
		if beat == []:
			click_juice('Early')
			score -= 1
			return
		
		var distance : float = beat[0].position.x - %OnBeatChecker.position.x
		if abs(distance) < 10:
			click_juice('Perfect')
			score += 3
		elif abs(distance) < 20:
			click_juice('Good')
			score += 2
		else:
			click_juice('Okay')
			score += 1
		
		beat[0].queue_free()


func _on_off_beat_checker_area_entered(area: Area2D) -> void:
	click_juice('Miss')
	score -= 2
	area.queue_free()


func click_juice(message: String):
	var juice_message_instance = juice_message.instantiate()
	juice_message_instance.text = message
	add_child(juice_message_instance)
