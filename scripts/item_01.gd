extends Area2D

const DIALOG_BRAIN = preload("res://dialogues/service_brain_power.dialogue")

@export var intro_level_02 := "res://scenes/intro_level_02.tscn"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_dialogue = false

func _on_body_entered(body: Node2D) -> void:
	if is_dialogue:
		return
	is_dialogue = true
	GameManager.end_level()
	animation_player.play("sound")
	
	if body.has_method("set_can_move"):
		body.set_can_move(false)
		
	await get_tree().create_timer(0.5).timeout
	DialogueManager.show_dialogue_balloon(DIALOG_BRAIN, "start")
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(dialogue):
	#GameManager.fade_out_music(audio_stream_player_2d)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	print("level2 from item")
	get_tree().change_scene_to_file(intro_level_02)
 
