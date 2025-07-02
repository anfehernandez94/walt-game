extends Control

const _03_INTRO = preload("res://dialogues/03_intro.dialogue")
const LEVEL_03 = preload("res://levels/level_03.tscn")

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(_03_INTRO, "start")
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(dialogue):
	GameManager.fade_out_music(audio_stream_player_2d)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_packed(LEVEL_03)
