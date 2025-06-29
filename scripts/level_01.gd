extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.init_level()
	var label = get_node("CanvasLayer/PanelScore/MarginContainer/HBoxContainer/LabelScore")
	GameManager.label_score = label
	GameManager.label_score.text = str(GameManager.score).pad_zeros(2)
