extends Control
class_name ChannelOverlayClass


## Time to display channel info
@export var display_time: float = 4

signal overlay_displayed

func display(microgame: Microgame):
	%ChannelNumber.text = microgame.channel_num
	%ChannelLogo.texture = microgame.channel_logo
	%ShowName.text = microgame.program_name
	%Description.text = microgame.program_message
	show()
	%OverlayDisplayTimer.start(display_time)
	await %OverlayDisplayTimer.timeout
	hide()
	print('awaited')
