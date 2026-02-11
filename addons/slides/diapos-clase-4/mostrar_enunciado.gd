@tool
extends Control

const ENUNCIADO_PEPITA = preload("uid://cyp18ha2k7sf3")

func _ready():
	visibility_changed.connect(func():
		if is_visible_in_tree():
			update_enunciado()
	)

func update_enunciado() -> void:
	var dock_enunciado = get_tree().get_first_node_in_group("enunciado")
	if dock_enunciado:
		for child in dock_enunciado.get_children():
			child.queue_free()
	else:
		dock_enunciado = EditorDock.new()
		dock_enunciado.default_slot = EditorDock.DOCK_SLOT_RIGHT_BL
		dock_enunciado.name = "Enunciado"
		dock_enunciado.available_layouts = EditorDock.DOCK_LAYOUT_ALL
		dock_enunciado.add_to_group("enunciado")
		EditorPlugin.new().add_dock(dock_enunciado)
	var enunciado_instancia = ENUNCIADO_PEPITA.instantiate()
	dock_enunciado.add_child(enunciado_instancia)
