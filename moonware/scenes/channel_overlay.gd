extends Control
class_name ChannelOverlayClass


## Time to display channel info
@export var display_time: float = 1.0

signal overlay_displayed

func display(microgame: Microgame):
	show()
	%OverlayDisplayTimer.start(display_time)
	pass


func _on_overlay_display_timer_timeout() -> void:
	hide()
	overlay_displayed.emit()
