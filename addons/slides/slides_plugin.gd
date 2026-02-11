@tool
extends EditorPlugin

const CONTROLES_DE_PRESENTADOR = preload("res://addons/slides/controles-de-presentador/controles_de_presentador.tscn")
const SlidesConfigClass = preload("res://addons/slides/slides_config.gd")

var controles_de_presentador
var config_panel
var config: SlidesConfig

# solamente para que se mantenga el recurso cargado y sea mas rapido despues:
var diapositivas

func _enter_tree():
	if(get_presentation_scene_path()):
		diapositivas = load(get_presentation_scene_path())
	config = SlidesConfigClass.load_or_create()
	
	controles_de_presentador = CONTROLES_DE_PRESENTADOR.instantiate()
	add_control_to_container(
		EditorPlugin.CONTAINER_TOOLBAR,
		controles_de_presentador
	)
	
	_setup_input_actions()
	config.changed.connect(self._setup_input_actions)

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
		key_event.pressed = true
		InputMap.action_add_event(action, key_event)

		var joypad_event := InputEventJoypadButton.new()
		joypad_event.button_index = action_config.joypad_button
		InputMap.action_add_event(action, joypad_event)

func _exit_tree():
	if is_instance_valid(controles_de_presentador):
		remove_control_from_container(
			EditorPlugin.CONTAINER_TOOLBAR,
			controles_de_presentador
		)
		controles_de_presentador.queue_free()
	
	for action in config.get_all_actions():
		if InputMap.has_action(action):
			InputMap.erase_action(action)

static func get_config() -> SlidesConfig:
	return SlidesConfigClass.load_or_create()

static func get_presentation_scene_path() -> String:
	var cfg = get_config()
	return cfg.presentation_scene
