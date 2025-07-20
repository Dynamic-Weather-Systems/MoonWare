extends Control


signal finished

func _ready() -> void:
	var Logos = %"Image Nodes".get_children()
	# Hide all logos
	for logo in Logos:
		logo.hide()
		logo.modulate = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),0)
	
	await get_tree().create_timer(1).timeout
	
	# Add transition for all logos
	for logo in Logos:
		logo.show()
		await play_animation(logo)
	
	finished.emit()


func	 play_animation(node: Node):
	var tween1 = get_tree().create_tween()
	tween1.tween_property(node, "modulate:a", 1, 1)
	await tween1.finished
	
	await get_tree().create_timer(1).timeout
	
	var tween2 = get_tree().create_tween()
	tween2.tween_property(node, "modulate:a", 0, 1)
	await tween2.finished
	await get_tree().create_timer(1).timeout
	node.queue_free()
