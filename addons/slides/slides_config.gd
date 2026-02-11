@tool
class_name SlidesConfig extends Resource

const CONFIG_PATH = "res://addons/slides/slides_config.tres"

@export_file("*.tscn") var presentation_scene: String = "res://addons/slides/diapositivas.tscn"

var _action_configs: Dictionary = {}

enum KeyFlags {
	USE_CTRL = 1,
	USE_ALT = 2
}

const ACTION_MAP := {
	# action: [key, flags, joypad_button]
	"avanzar": 				[KEY_KP_6, KeyFlags.USE_CTRL, JOY_BUTTON_B],
	"retroceder": 				[KEY_KP_4, KeyFlags.USE_CTRL, JOY_BUTTON_X],
	"toggle_diapositivas":		[KEY_KP_5, KeyFlags.USE_CTRL, JOY_BUTTON_START],
	"accion_primaria":			[KEY_KP_7, KeyFlags.USE_CTRL, JOY_BUTTON_A],
	"accion_secundaria":		[KEY_KP_8, KeyFlags.USE_CTRL, JOY_BUTTON_Y],
	"accion_terciaria":		[KEY_KP_9, KeyFlags.USE_CTRL, JOY_BUTTON_LEFT_SHOULDER],
	"toggle_run_scene":		[KEY_KP_1, KeyFlags.USE_CTRL, JOY_BUTTON_RIGHT_SHOULDER],
	"toggle_fullscreen":		[KEY_ENTER, KeyFlags.USE_ALT, JOY_BUTTON_BACK],
}

class ActionConfig:
	var key: Key = KEY_NONE
	var use_ctrl: bool = false
	var use_alt: bool = false

	var joypad_button: JoyButton = JOY_BUTTON_INVALID

	static func create(key: Key, joypad: JoyButton, key_flags: KeyFlags) -> ActionConfig:
		var config = ActionConfig.new()
		config.key = key
		config.joypad_button = joypad
		config.use_ctrl = key_flags & KeyFlags.USE_CTRL > 0
		config.use_alt = key_flags & KeyFlags.USE_ALT > 0
		return config

func _property_can_revert(property: StringName) -> bool:
	for action in ACTION_MAP.keys():
		if property.begins_with(action):
			return true
	return false

func _property_get_revert(property: StringName) -> Variant:
	for action in ACTION_MAP.keys():
		if property.begins_with(action):
			var action_property = property.trim_prefix(action + "_")
			return _get_default_value(action, action_property)
	return null

func _get_default_value(action, property):
	var parameters = ACTION_MAP[action]
	match property:
		"key":
			return parameters[0]
		"use_ctrl":
			return parameters[1] & KeyFlags.USE_CTRL > 0
		"use_alt":
			return parameters[1] & KeyFlags.USE_ALT > 0
		"joypad_button":
			return parameters[2]

func _init():
	for action in ACTION_MAP.keys():
		if not get(action):
			var action_parameters = ACTION_MAP[action]
			_action_configs[action] = ActionConfig.create.callv(action_parameters)

func _get(property: StringName) -> Variant:
	for action in ACTION_MAP.keys():
		if property.begins_with(action):
			var action_property = property.trim_prefix(action + "_")
			if not _action_configs.has(action) or null == _action_configs[action].get(action_property):
				return _get_default_value(action, action_property)
			return _action_configs[action][action_property]
	return null

func _set(property: StringName, value: Variant) -> bool:
	for action in ACTION_MAP.keys():
		if property.begins_with(action):
			var action_property = property.trim_prefix(action + "_")
			_action_configs[action][action_property] = value
			emit_changed()
			return true
	return false

func _get_property_list() -> Array[Dictionary]:
	var property_list: Array[Dictionary] = []
	for action in ACTION_MAP.keys():
		var action_config = _action_configs[action]
		property_list.append({
			"name": action.capitalize(),
			"usage": PROPERTY_USAGE_GROUP,
			"type": TYPE_NIL,
			"hint_string": action
		})

		property_list.append({
			"name": "%s_key" % action,
			"usage": PROPERTY_USAGE_DEFAULT,
			"type": TYPE_INT,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": get_key_enum_string()
		})
		property_list.append({
			"name": "%s_use_ctrl" % action,
			"usage": PROPERTY_USAGE_DEFAULT,
			"type": TYPE_BOOL
		})
		property_list.append({
			"name": "%s_use_alt" % action,
			"usage": PROPERTY_USAGE_DEFAULT,
			"type": TYPE_BOOL
		})
		property_list.append({
			"name": "%s_joypad_button" % action,
			"usage": PROPERTY_USAGE_DEFAULT,
			"type": TYPE_INT,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": get_joypad_enum_string()
		})
	
	return property_list

func get_action_config(action: String) -> ActionConfig:
	return _action_configs.get(action)

func get_all_actions() -> Array:
	return ACTION_MAP.keys()

func _is_action(action: StringName) -> bool:
	return ACTION_MAP.has(action)

static func load_or_create() -> SlidesConfig:
	if ResourceLoader.exists(CONFIG_PATH):
		return load(CONFIG_PATH) as SlidesConfig
	var config = SlidesConfig.new()
	ResourceSaver.save(config, CONFIG_PATH)
	return config

# No se puede obtener programaticamente aun:
# https://github.com/godotengine/godot-proposals/issues/12311
# https://github.com/godotengine/godot/issues/73835
static func get_key_enum_string() -> String:
	return "None:0," + \
		"Space:32,Enter:4194309,Escape:4194305,Tab:4194306,Backspace:4194308," + \
		"Left:4194319,Right:4194321,Up:4194320,Down:4194322," + \
		"KP_0:4194438,KP_1:4194439,KP_2:4194440,KP_3:4194441,KP_4:4194442," + \
		"KP_5:4194443,KP_6:4194444,KP_7:4194445,KP_8:4194446,KP_9:4194447," + \
		"F1:4194332,F2:4194333,F3:4194334,F4:4194335,F5:4194336," + \
		"F6:4194337,F7:4194338,F8:4194339,F9:4194340,F10:4194341,F11:4194342,F12:4194343"
 
static func get_joypad_enum_string() -> String:
	return "A (Bottom):0,B (Right):1,X (Left):2,Y (Top):3," + \
		"Left Shoulder:4,Right Shoulder:5,Left Trigger:6,Right Trigger:7," + \
		"Left Stick:8,Right Stick:9,Back:10,Start:11,Guide:12," + \
		"DPad Up:13,DPad Down:14,DPad Left:15,DPad Right:16"
