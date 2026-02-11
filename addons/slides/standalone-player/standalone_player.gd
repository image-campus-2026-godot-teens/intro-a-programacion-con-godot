extends Control

const SlidesConfigClass = preload("res://addons/slides/slides_config.gd")

var diapositivas
var config: SlidesConfig

func _ready():
	config = SlidesConfigClass.load_or_create()
	_setup_input_actions()
	
	var scene_path = config.presentation_scene
	var diapositivas_scene = load(scene_path)
	diapositivas = diapositivas_scene.instantiate()
	add_child(diapositivas)

func _setup_input_actions():
	for action in config.get_all_actions():
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		InputMap.action_erase_events(action)

		var action_config := config.get_action_config(action)
		if not action_config:
			continue

		var key_event := InputEventKey.new()
		key_event.echo = false
		key_event.ctrl_pressed = action_config.use_ctrl
		key_event.alt_pressed = action_config.use_alt
		key_event.keycode = action_config.key
		InputMap.action_add_event(action, key_event)

		var joypad_event := InputEventJoypadButton.new()
		joypad_event.button_index = action_config.joypad_button
		InputMap.action_add_event(action, joypad_event)

func _process(_delta):
	if Input.is_action_just_pressed("avanzar"):
		diapositivas.avanzar()
	if Input.is_action_just_pressed("retroceder"):
		diapositivas.retroceder()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("toggle_fullscreen"):
		_toggle_fullscreen()

func _toggle_fullscreen():
	if get_window().mode == Window.MODE_FULLSCREEN:
		get_window().mode = Window.MODE_WINDOWED
	else:
		get_window().mode = Window.MODE_FULLSCREEN
