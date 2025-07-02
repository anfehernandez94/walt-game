extends Node2D

#@onready var music: AudioStreamPlayer2D = $Music
@onready var music: AudioStreamPlayer2D = $Player/Music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.init_level()
	var label = get_node("CanvasLayer/PanelScore/MarginContainer/HBoxContainer/LabelScore")
	GameManager.label_score = label
	GameManager.label_score.text = str(GameManager.score).pad_zeros(2)
	GameManager.fade_in_music(music)
