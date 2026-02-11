@tool
extends MarginContainer

enum Herramienta {
	Seleccion,
	Mover,
	Bloquear,
	Paneo
}

@export var color: Color = Color.GREEN
@export var herramienta: Herramienta

func entrar():
	modulate = color
	var node: CanvasItem = _highlighted_node()
	var node_rect: Rect2 = node.get_rect()
	$HighlightNode.highlight_node_with_arrow(
		node,
		$Label/OrigenFlecha,
		node_rect.size - Vector2(node_rect.size.x / 2.0, 0),
		5.0,
		color
		)

func _highlighted_node():
	var canvas_item_editor = EditorInterface.get_base_control().find_children("", "CanvasItemEditor", true, false).front()
	var tool_bar: HBoxContainer = canvas_item_editor.find_children("", "HBoxContainer", true, false).front()
	match herramienta:
		Herramienta.Seleccion:
			return tool_bar.get_child(0)
		Herramienta.Mover:
			return tool_bar.get_child(2)
		Herramienta.Paneo:
			return tool_bar.get_child(8)
		Herramienta.Bloquear:
			return tool_bar.get_child(16)
