# Built for Animation Player that will play one animation from startup.
# This code should not have any other functions.
# Add script on an Animation Player with a single animation called "DEFAULT."
extends AnimationPlayer


# Play "DEFAULT" Animation
func _ready() -> void:
	play("DEFAULT")
