@tool
extends Control

var from_node: CanvasItem = null
var local_arrow_target: Vector2 = Vector2.INF
var arrow_width: float = 1

@export var color: Color = Color.GREEN
var highlighted_node: CanvasItem = null

func _ready() -> void:
	visibility_changed.connect(on_visibility_changed)
	set_process(is_visible_in_tree())

func on_visibility_changed():
	var can_be_seen: bool = is_visible_in_tree()
	if not can_be_seen:
		reset_colors()
	set_process(can_be_seen)

func _process(delta: float) -> void:
	if from_node and !(get_tree().edited_scene_root and get_tree().edited_scene_root.is_ancestor_of(self)):
		queue_redraw()

func reset_colors():
	if highlighted_node:
		highlighted_node.modulate = Color.WHITE
	if from_node:
		from_node.modulate = Color.WHITE

func _exit_tree() -> void:
	reset_colors()

func highlight_node(node: CanvasItem) -> void:
	highlighted_node = node
	highlighted_node.modulate = color

func highlight_node_with_arrow(
	target_node: CanvasItem,
	origin_node: Node,
	position_local_to_node: Vector2,
	width: float,
	highlight_color: Color = color) -> void:

	color = highlight_color
	arrow_width = width
	from_node = origin_node
	from_node.modulate = Color.WHITE
	highlight_node(target_node)
	local_arrow_target = position_local_to_node

func _draw() -> void:
	if highlighted_node and from_node and local_arrow_target != Vector2.INF:
		var global_arrow_position = highlighted_node.global_position + local_arrow_target - global_position
		draw_arrow(
			from_node.global_position - global_position,
			global_arrow_position,
			color,
			15.0
		)

func draw_arrow(from: Vector2, to: Vector2, color: Color, width: float):
	var arrow_length: float = from.distance_to(to)
	var angle: float = PI / 6
	draw_multiline(
		[
			from,
			to,
			to,
			to + to.direction_to(from).rotated(angle) * max(75, arrow_length / 10.0),
			to,
			to + to.direction_to(from).rotated(-angle) * max(75, arrow_length / 10.0)
		],
		color,
		arrow_width,
		true
	)
	draw_circle(to, arrow_width / 2.0, color, true)
