@tool
class_name ControlesDePresentador extends Control

const REPRODUCTOR_DE_DIAPOSITIVAS = preload("res://addons/slides/reproductor-de-diapositivas/reproductor_de_diapositivas.tscn")
@onready var toggle_slides = %ToggleSlides
@onready var previous: Button = %Previous
@onready var next: Button = %Next

var reproductor
var diapositiva_actual: int

func cambiar_a(nueva_diapositiva: int) -> void:
	diapositiva_actual = nueva_diapositiva
	if is_instance_valid(reproductor):
		reproductor.diapositiva_actual = nueva_diapositiva

func _ready():
	toggle_slides.pressed.connect(self.on_toggle_slides)
	previous.pressed.connect(self.on_previous)
	next.pressed.connect(self.on_next)
	update_advance_buttons_visibility()

func update_advance_buttons_visibility():
	for button in [previous, next]:
		button.visible = _is_playing_slides()

func on_toggle_slides():
	if(_is_playing_slides()):
		cerrar()
	else:
		abrir()
	update_advance_buttons_visibility()

func abrir():
	if(not is_instance_valid(reproductor)):
		reproductor = REPRODUCTOR_DE_DIAPOSITIVAS.instantiate()
	EditorInterface.get_base_control().add_child(reproductor)
	reproductor.diapositiva_actual = diapositiva_actual

func cerrar():
	if(_is_playing_slides()):
		EditorInterface.get_base_control().remove_child(reproductor)
		reproductor.queue_free()
		cambiar_a(reproductor.diapositiva_actual)

func on_previous():
	if(_is_playing_slides()):
		reproductor.retroceder()

func on_next():
	if(_is_playing_slides()):
		reproductor.avanzar()

func _process(delta):
	if(_is_playing_slides()):
		toggle_slides.text = "Parar"
	else:
		toggle_slides.text = "Arrancar"
	if Input.is_action_just_pressed("ui_cancel"):
		cerrar()
	if InputMap.has_action("toggle_diapositivas") and Input.is_action_just_pressed("toggle_diapositivas"):
		on_toggle_slides()
	if InputMap.has_action("toggle_fullscreen") and Input.is_action_just_pressed("toggle_fullscreen"):
		if(get_window().mode == Window.MODE_FULLSCREEN):
			get_window().mode = Window.MODE_MAXIMIZED
		else:
			get_window().mode = Window.MODE_FULLSCREEN
		

func _is_playing_slides():
	return is_instance_valid(reproductor) and reproductor.get_parent()
