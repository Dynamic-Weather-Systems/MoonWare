extends Node


#region Export Variables
@export_group("Microgames")
## Level Resource, contains packed scene of microgames
@export var microgames: LevelResouce

@export_group("Node References")
## Rect that has the VSH Shader
@export var VHSShaderRect: ColorRect
## Screen whose children will be displayed on the "TV" 
@export var Screen: Control


@export_subgroup("Audio Node References")
## Static Noise sfx
@export var StaticNoiseFX: AudioStreamPlayer
##Main Menu theme
@export var MainMenuTheme: AudioStreamPlayer
#endregion


# Check if game has started, used to start Title Sequence
var gameStarted = false

## How long to play static (seconds)
@export var static_timer: float = 1.0


# Startup function
func _ready() -> void:
	# Display the "Press Anny Button" label on a blank screen.
	%PressAnyButtonLabel.show()
	%MainMenuUI.hide()
	set_power_mode("off")
	Screen.show()
	
	# Pick Random Seed
	randomize()


# Runs for any input event that hasn't been terminated
func _unhandled_input(event: InputEvent) -> void:
	# Run title sequence if game not started and key is pressed
	if not gameStarted:
		if Input.is_anything_pressed():
			get_viewport().set_input_as_handled()
			gameStarted = true
			%PressAnyButtonLabel.queue_free()
			titleSequence()


# Behaviour of the title sequence
func titleSequence():
	await set_power_mode('static')
	set_power_mode("on")
	
	#TODO - Create a title sequence here
	
	#Main Menu
	%MainMenuUI.show()
	MainMenuTheme.play()

# Changes the Power mode of the TV Screen
func set_power_mode(mode: String):
	if mode == "off":
		Screen.hide()
		%BlankScreenRect.show()
		StaticNoiseFX.stop()
		set_VHS_param("static_noise_intensity", 0)
		set_VHS_param("roll", false)
		set_VHS_param("roll_size", 0)
		return
	if mode == "on":
		Screen.show()
		%BlankScreenRect.show()
		StaticNoiseFX.stop()
		set_VHS_param("static_noise_intensity", 0.1)
		set_VHS_param("roll", true)
		set_VHS_param("roll_size", 15)
		return
		
	# if static mode must be used, use await so the timer is allowed to fully finish 
	if mode == "static":
		set_VHS_param("static_noise_intensity", 1)
		set_VHS_param("roll", true)
		set_VHS_param("roll_size", 15)
		if not StaticNoiseFX.playing:
			StaticNoiseFX.play()
		Screen.hide()
		%BlankScreenRect.hide()
		await get_tree().create_timer(static_timer).timeout


# Easy syntax to change vhs shader parameters
func set_VHS_param(param: String, value):
	assert(VHSShaderRect)
	VHSShaderRect.material.set_shader_parameter(param, value)


# Starts the game
func _on_main_menu_ui_start_game() -> void:
	%MainMenuUI.queue_free()
	MainMenuTheme.queue_free()
	await set_power_mode('static')
	set_power_mode('on')
	
	var minigameIdx = randi() % len(microgames.minigamePackedScenes)
	print(minigameIdx)
	var minigameInstance = microgames.minigamePackedScenes[minigameIdx].instantiate()
	minigameInstance.scale = Vector2(2,2)
	Screen.add_child(minigameInstance)
	
