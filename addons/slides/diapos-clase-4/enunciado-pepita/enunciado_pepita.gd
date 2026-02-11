@tool
extends MarginContainer
@onready var v_box_container: VBoxContainer = $ScrollContainer/VBoxContainer
@onready var scroll_container: ScrollContainer = $ScrollContainer

func _ready() -> void:
	var buttons = v_box_container.find_children("", "Button", false, true)
	for button: Button in buttons:
		var next_node = button_dependent_node(button)
		next_node.visible = false
		button.pressed.connect(func():
			next_node.visible = !next_node.visible
			if next_node.visible:
				await get_tree().process_frame
				await get_tree().process_frame
				scroll_container.ensure_control_visible(next_node)
				next_node.grab_focus.call_deferred()
		)

func button_dependent_node(button):
	var node_idx = button.get_index()
	return v_box_container.get_child(node_idx + 1)
