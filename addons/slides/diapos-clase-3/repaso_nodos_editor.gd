@tool
extends MarginContainer

var viewport_2d: SubViewport

func _ready() -> void:
	set_process(false)

func entrar():
	viewport_2d = EditorInterface.get_editor_viewport_2d()
	set_process(true)

	var scene_tree_editor = _scene_tree_editor()
	%RepasoNodosEditorContainer/SceneTree.modulate =\
		$HighlightNodeSceneTree.color
	$HighlightNodeSceneTree.highlight_node_with_arrow(
		scene_tree_editor,
		%RepasoNodosEditorContainer/SceneTree/OrigenFlecha,
		Vector2(scene_tree_editor.get_rect().size.x, scene_tree_editor.get_rect().size.y / 2),
		15.0
		)

	var file_system_dock = _file_system_dock()
	%RepasoNodosEditorContainer/FileSystem.modulate =\
		%RepasoNodosEditorContainer/FileSystem/HighlightNode.color
	%RepasoNodosEditorContainer/FileSystem/HighlightNode.highlight_node_with_arrow(
		file_system_dock,
		%RepasoNodosEditorContainer/FileSystem/OrigenFlecha,
		Vector2(file_system_dock.get_rect().size.x, 200),
		15.0
		)
		
	var inspector = _inspector()
	%RepasoNodosEditorContainer/Inspector.modulate =\
		%RepasoNodosEditorContainer/Inspector/HighlightNode.color
	%RepasoNodosEditorContainer/Inspector/HighlightNode.highlight_node_with_arrow(
		inspector,
		%RepasoNodosEditorContainer/Inspector/OrigenFlecha,
		Vector2(0, inspector.get_rect().size.y / 2),
		15.0
		)

func _file_system_dock() -> Control:
	var scene_tree_editor = EditorInterface.get_file_system_dock().get_parent()
	return scene_tree_editor

func _scene_tree_editor() ->  Control:
	var scene_tree_editor = EditorInterface.get_base_control().find_children("", "SceneTreeDock", true, false).front()
	return scene_tree_editor.get_parent()

func _inspector() -> Control:
	var scene_tree_editor = EditorInterface.get_base_control().find_children("", "InspectorDock", true, false).front().get_parent()
	return scene_tree_editor

func salir():
	set_process(false)

func _process(delta: float) -> void:
	size = viewport_2d.size
	global_position = viewport_2d.get_parent().global_position
