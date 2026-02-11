@tool
extends Control
@export var color: Color = Color.GREEN

func entrar():
	modulate = color
	var node: CanvasItem = _highlighted_node()
	var node_rect: Rect2 = node.get_rect()
	$HighlightNode.highlight_node_with_arrow(
		node,
		$Label/OrigenFlecha,
		Vector2(node_rect.size.x, node_rect.get_center().y),
		15.0,
		color
		)

func _highlighted_node() -> Control:
	var scene_tree_editor = EditorInterface.get_base_control().find_children("", "SceneTreeDock", true, false).front()
	return scene_tree_editor.get_parent()
