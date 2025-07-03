extends Control

const _END_INTRO = preload("res://dialogues/end.dialogue")
const MAIN_MENU = "res://scenes/main_menu.tscn"

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(_END_INTRO, "start")
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(dialogue):
	GameManager.fade_out_music(audio_stream_player_2d)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(MAIN_MENU)
