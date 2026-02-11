@tool
extends "res://addons/slides/diapos-clase-3/scripts/filmina.gd"

@export var color: Color = Color.GREEN

func entrar():
	modulate = color
	var node: CanvasItem = _highlighted_node()
	var node_rect: Rect2 = node.get_rect()
	$HighlightNode.highlight_node_with_arrow(
		node,
		$Label/OrigenFlecha,
		Vector2(node_rect.size.x, 150),
		15.0,
		color
		)

func _highlighted_node() -> Control:
	var scene_tree_editor = EditorInterface.get_file_system_dock().get_parent()
	return scene_tree_editor
