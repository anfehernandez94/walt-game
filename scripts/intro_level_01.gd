extends Control

const _01_INTRO = preload("res://dialogues/01_intro.dialogue")
@export var leve_01:= preload("res://levels/level_01.tscn")

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(_01_INTRO, "start")
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(dialogue):
	GameManager.fade_out_music(audio_stream_player_2d)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_packed(leve_01)
