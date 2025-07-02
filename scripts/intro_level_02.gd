extends Control

const _02_INTRO = preload("res://dialogues/02_intro.dialogue")
const LEVEL_02 = preload("res://levels/level_02.tscn")

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(_02_INTRO, "start")
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(dialogue):
	GameManager.fade_out_music(audio_stream_player_2d)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_packed(LEVEL_02)
