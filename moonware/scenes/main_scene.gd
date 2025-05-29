extends Node

@export_group("Microgames")
@export var microgames: LevelResouce

@export_group("Node References")
@export var VHSShaderRect: ColorRect
@export var Screen: Control


var gameStarted = false


func _ready() -> void:
	%PressAnyButtonLabel.show()
	%MainMenuUI.hide()
	set_power_mode("off")
	Screen.show()


func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		set_power_mode("off")
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		set_power_mode("static")


func set_power_mode(mode: String):
	if mode == "off":
		set_VHS_param("static_noise_intensity", 0)
		Screen.hide()
		return
	if mode == "on":
		Screen.show()
		set_VHS_param("static_noise_intensity", 0.06)
		return
	if mode == "static":
		set_VHS_param("static_noise_intensity", 1)
		Screen.hide()
		await get_tree().create_timer(1).timeout
		set_power_mode("on")


func set_VHS_param(param: String, value):
	assert(VHSShaderRect)
	VHSShaderRect.material.set_shader_parameter(param, value)


func _unhandled_input(event: InputEvent) -> void:
	if not gameStarted:
		if Input.is_anything_pressed():
			gameStarted = true
			%PressAnyButtonLabel.queue_free()
			titleSequence()


func titleSequence():
	pass
