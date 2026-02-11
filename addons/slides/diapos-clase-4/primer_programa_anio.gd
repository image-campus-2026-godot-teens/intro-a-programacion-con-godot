@tool
extends Container

var viewport_2d: SubViewport

func _ready() -> void:
	set_process(false)

func entrar():
	set_process(true)
	viewport_2d = EditorInterface.get_editor_viewport_2d()
	set_deferred("size", viewport_2d.size)
	global_position = viewport_2d.get_parent().global_position

func salir():
	set_process(false)

func _process(delta: float) -> void:
	size = viewport_2d.size
	global_position = viewport_2d.get_parent().global_position
