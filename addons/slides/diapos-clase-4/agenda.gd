@tool
extends MarginContainer

var viewport_2d: SubViewport
var tween_were_ran: bool = false
@export var animate_screen_color_on_enter: bool = true

func _ready() -> void:
	set_process(false)

func entrar():
	viewport_2d = EditorInterface.get_editor_viewport_2d()
	set_deferred("size", viewport_2d.size)
	global_position = viewport_2d.get_parent().global_position
	set_process(true)
	if not tween_were_ran:
		tween_were_ran = true
		animate()

func animate():
	$RichTextLabel.visible_ratio = 0.0
	if animate_screen_color_on_enter:
		await get_tree().create_tween().tween_property(
			self, "modulate:a", 1.0, 1.0
		).from(0.0).finished
	get_tree().create_tween().tween_property(
		$RichTextLabel,
		"visible_ratio", 1.0, 2.0)

func salir():
	set_process(false)

func _process(delta: float) -> void:
	size = viewport_2d.size
	global_position = viewport_2d.get_parent().global_position
