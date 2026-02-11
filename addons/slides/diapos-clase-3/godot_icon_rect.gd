@tool
extends TextureRect

var icon_list: PackedStringArray = EditorInterface.get_editor_theme().get_icon_list("EditorIcons")
var icon: String :
	set(new_value):
		icon = new_value
		if not is_node_ready():
			await ready
		if is_inside_tree():
			texture = EditorInterface.get_editor_theme().get_icon(icon, "EditorIcons")

func _get_property_list() -> Array[Dictionary]:
	return [{
		"name": "icon",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(icon_list),
	}
]
