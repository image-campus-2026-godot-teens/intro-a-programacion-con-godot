@tool
extends Control

func draw_arrow(from: Vector2, to: Vector2, color: Color, width: float):
	var arrow_length: float = from.distance_to(to)
	var angle: float = PI / 6
	draw_multiline(
		[
			from,
			to,
			to,
			to + to.direction_to(from).rotated(angle) * arrow_length / 10.0,
			to,
			to + to.direction_to(from).rotated(-angle) * arrow_length / 10.0
		],
		color,
		width,
		true
	)
	draw_circle(to, width / 2.0, color, true)
