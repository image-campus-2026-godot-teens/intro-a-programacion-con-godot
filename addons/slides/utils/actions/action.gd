class_name Action
extends RefCounted

var _do_action: Callable
var _undo_action: Callable
var _process: Callable

func _init(callbacks: Dictionary):
	_do_action = callbacks.get("do", func(): pass)
	_undo_action = callbacks.get("undo", func(): pass)
	_process = callbacks.get("process", func(delta: float): pass)

func do():
	_do_action.call()

func undo():
	_undo_action.call()

func process(delta: float):
	_process.call(delta)

func opposite():
	return Action.new({
		"do": self._undo_action,
		"undo": self._do_action,
	})

func and_then(other_action):
	return Action.new({
		"do": func():
			self._do_action.call()
			other_action._do_action.call(),
		"undo":
			func():
				other_action._undo_action.call()
				self._undo_action.call()
	})

static func hacer_visible(control):
	return Action.new({
		"do": func(): control.visible = true,
		"undo": func(): control.visible = false
	})

static func play_animation(animation_player, animation):
	return Action.new({
		"do": func(): animation_player.play(animation),
		"undo": func(): animation_player.play_backwards(animation)
	})
