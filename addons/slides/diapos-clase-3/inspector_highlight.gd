@tool
extends "res://addons/slides/diapos-clase-3/scripts/filmina.gd"

@export var color: Color = Color.GREEN

func _highlighted_node() -> Control:
	var scene_tree_editor = EditorInterface.get_base_control().find_children("", "InspectorDock", true, false).front().get_parent()
	return scene_tree_editor

func entrar():
	modulate = color
	var node: CanvasItem = _highlighted_node()
	var node_rect: Rect2 = node.get_rect()
	$HighlightNode.highlight_node_with_arrow(
		node,
		$Label/OrigenFlecha,
		Vector2(node_rect.position.x, node_rect.get_center().y),
		15.0,
		color
		)
