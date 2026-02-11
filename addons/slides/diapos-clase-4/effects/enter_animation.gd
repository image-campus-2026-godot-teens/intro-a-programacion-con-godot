@tool
extends Control

@export_range(0.01, 2.0, 0.01) var duration: float = 0.5

func _ready() -> void:
	visibility_changed.connect(on_visibility_changed)

func on_visibility_changed():
	var parent_control: Control = get_parent()
	if is_visible_in_tree():
		parent_control.pivot_offset = parent_control.size / 2
		create_tween().tween_property(parent_control, "scale", Vector2.ONE, duration)\
			.from(Vector2.ONE * 0.8).set_trans(Tween.TRANS_QUAD)
