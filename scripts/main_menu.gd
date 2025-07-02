extends Control

@export var intro_level_01: = preload("res://scenes/intro_level_01.tscn")
@export var options: = preload("res://scenes/options_menu.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(intro_level_01)

func _on_options_pressed() -> void:
	get_tree().change_scene_to_packed(options)

func _on_quit_pressed() -> void:
	get_tree().quit()
