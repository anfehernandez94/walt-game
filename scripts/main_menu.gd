extends Control

@export var level_01: String = "res://levels/level_01.tscn"
@export var options: String = "res://scenes/options_menu.tscn"

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(level_01)

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file(options)

func _on_quit_pressed() -> void:
	get_tree().quit()
