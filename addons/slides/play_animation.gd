@tool
extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var animation_name: String = "new_animation"

func entrar():
	animation_player.play("RESET")

func accion_primaria():
	animation_player.play(animation_name)

func accion_secundaria():
	animation_player.play_backwards(animation_name)
	
