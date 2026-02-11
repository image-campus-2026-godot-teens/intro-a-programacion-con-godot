@tool
extends "res://addons/slides/with_action_list.gd"

func _ready() -> void:
	var nodos_a_hacer_visibles_en_orden = [
		$Label/NodosFisica,
		$Label/NodosFisica/RigidBody2D,
		$Label/NodosFisica/CharacterBody2D,
		$Label/NodosFisica/StaticBody2D,
		$Label/CollisionShape2D,
		$Label/NodosImagenes,
		$Label/NodosImagenes/Sprite2D,
		$Label/NodosImagenes/AnimatedSprite2D,
		$Label/Camera2D
	]
	for nodo in nodos_a_hacer_visibles_en_orden:
		nodo.visible = false
	action_list.actions = nodos_a_hacer_visibles_en_orden.map(Action.hacer_visible)
