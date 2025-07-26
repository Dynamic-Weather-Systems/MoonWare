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
## Health UI
@export var HealthUI: Control
## Main Menu UI
@export var MainMenu: Control
## Static Timer
@export var StaticTimer: Timer
## Channel Overlay
@export var ChannelOverlay: ChannelOverlayClass
@export_subgroup("Audio Node References")
## Static Noise sfx
@export var StaticNoiseFX: AudioStreamPlayer
##Main Menu theme
@export var MainMenuTheme: AudioStreamPlayer
@export_subgroup("Expernal Node References")
@export var TitleSequence: PackedScene
@export_group("Game Constants")
## How long to play the Static Effect (seconds)
@export var static_time: float = 1.0
#endregion

#region Scene functionality Variables
# Check if game has started, used to start Title Sequence
var gameStarted: bool = false
# instance of the currently loaded minigame
var currentMinigame: Microgame = null
# Boolean player minigame status
var inMinigame: bool = false
#endregion

#region Player Stats
# Score
var highScore: int = 0
var score: int = 0
# watch time
var startTime: int = 0
var endTime: int = 0
# Channel count
var channelCount: int = 0
#endregion


# Startup function
func _ready() -> void:
	#Set Random Seed
	randomize()
	
	# Setup Screen
	MainMenu.hide()
	set_power_mode("off")
	Screen.show()
	%PressAnyButtonLabel.show()


func _unhandled_input(event: InputEvent) -> void:
	# Run title sequence if game not started and key is pressed
	if not gameStarted:
		if Input.is_anything_pressed():
			get_viewport().set_input_as_handled()
			gameStarted = true
			%PressAnyButtonLabel.queue_free()
			#await run_title_sequence()
			
			# Display Main Menu
			set_power_mode("static")
			MainMenu.show()
			await finish_static()
			MainMenuTheme.play()


func run_title_sequence():
	set_power_mode("static")
	var title_sequence = TitleSequence.instantiate()
	await finish_static()
	Screen.add_child(title_sequence)
	await title_sequence.finished
	title_sequence.queue_free()


func _on_main_menu_ui_start_game() -> void:
	start_new_game()

func start_new_game() -> void:
	startTime = Time.get_ticks_msec()
	endTime = 0
	channelCount = 0
	score = 0
	HealthUI.hearts = HealthUI.max_hearts
	MainMenu.hide()
	MainMenuTheme.stop()
	transition_minigames()


func transition_minigames() -> void:
	set_power_mode('static')
	load_next_minigame()
	currentMinigame.set_minigame_state(currentMinigame.PAUSED)
	currentMinigame.show()
	await finish_static()    
	
	ChannelOverlay.display(currentMinigame)
	await ChannelOverlay.overlay_displayed
	currentMinigame.set_minigame_state(currentMinigame.PLAYING)


func load_next_minigame() -> void:
	if currentMinigame != null:
		currentMinigame.queue_free()
		currentMinigame = null
	var instance = microgames.minigamePackedScenes.pick_random().instantiate()
	currentMinigame = instance
	Screen.add_child(instance)
	currentMinigame.win_game.connect(minigame_won)
	currentMinigame.lose_game.connect(minigame_lost)
	instance.show()


func minigame_won() -> void:
	print('Minigame_won')
	transition_minigames()

func minigame_lost() -> void:
	print('Minigame_lost')
	transition_minigames()


#region Controls VHS shader
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
	if mode == "static":
		set_VHS_param("static_noise_intensity", 1)
		set_VHS_param("roll", true)
		set_VHS_param("roll_size", 15)
		if not StaticNoiseFX.playing:
			StaticNoiseFX.play()
		Screen.hide()
		%BlankScreenRect.hide()
		static_timer_finished = false
		static_scene_loaded = false
		StaticTimer.start(static_time)

# Shorthand for changing VHS shader parameters
func set_VHS_param(param: String, value):
	assert(VHSShaderRect)
	VHSShaderRect.material.set_shader_parameter(param, value)
#endregion

#region Handling Static transitions
signal static_transition_finished
var static_timer_finished:bool = false:
	set(value):
		static_timer_finished = value
		if (value==true):
			on_static_scene_handler()
var static_scene_loaded:bool = false:
	set(value):
		static_scene_loaded = value
		if (value==true):
			on_static_scene_handler()


func on_static_scene_handler() -> void:
	if static_timer_finished and static_scene_loaded:
		static_transition_finished.emit()


func _on_static_timer_timeout() -> void:
	if static_timer_finished==false:
		static_timer_finished=true

func finish_static() -> void:
	static_scene_loaded = true
	await static_transition_finished
	set_power_mode('on')

#endregion
