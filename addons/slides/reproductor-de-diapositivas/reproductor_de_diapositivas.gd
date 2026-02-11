@tool
class_name ReproductorDeDiapositivas extends Control

const SlidesPlugin = preload("res://addons/slides/slides_plugin.gd")

var diapositivas
var diapositiva_actual: int :
	set(nueva_diapositiva_actual):
		diapositiva_actual = nueva_diapositiva_actual
		if(diapositivas):
			diapositivas.diapositiva_actual = nueva_diapositiva_actual
	get():
		if(diapositivas):
			return diapositivas.diapositiva_actual
		else:
			return 0

func _ready():
	var scene_path = SlidesPlugin.get_presentation_scene_path()
	var diapositivas_scene = load(scene_path)
	diapositivas = diapositivas_scene.instantiate()
	diapositivas.diapositiva_actual = diapositiva_actual
	var diapositivas_size = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height")
	)
	diapositivas.z_index = 150
	add_child(diapositivas)

func is_action_pressed(action):
	return InputMap.has_action(action) and Input.is_action_just_pressed(action)

func is_action_continuously_pressed(action):
	return InputMap.has_action(action) and Input.is_action_pressed(action)

func avanzar():
	diapositivas.avanzar()

func retroceder():
	diapositivas.retroceder()

func _process(delta):
	if Engine.is_editor_hint() and get_tree().edited_scene_root and get_tree().edited_scene_root.scene_file_path == diapositivas.scene_file_path:
		if is_action_pressed("avanzar") or is_action_pressed("retroceder"): 
			return

	if is_action_pressed("avanzar"):
		avanzar()
	if is_action_pressed("retroceder"):
		retroceder()
	if is_action_pressed("accion_primaria"):
		diapositivas.accion_primaria()
	if is_action_pressed("accion_secundaria"):
		diapositivas.accion_secundaria()
	if is_action_pressed("accion_terciaria"):
		diapositivas.accion_terciaria()
	if is_action_continuously_pressed("accion_secundaria"):
		diapositivas.accion_secundaria_continua(delta)
	if is_action_continuously_pressed("accion_terciaria"):
		diapositivas.accion_terciaria_continua(delta)
