extends Control


@export var main_menu: String = "res://scenes/main_menu.tscn"

func _on_sound_pressed() -> void:
	pass # Replace with function body.


func _on_controls_pressed() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
		get_tree().change_scene_to_file(main_menu)
