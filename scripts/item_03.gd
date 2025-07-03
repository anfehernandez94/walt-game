extends Area2D

const DIALOG_TIME = preload("res://dialogues/service_time_off.dialogue")

@export var intro_end := preload("res://scenes/intro_end.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	GameManager.end_level()
	animation_player.play("sound")
	
	if body.has_method("set_can_move"):
		body.set_can_move(false)
	#Engine.time_scale=0.2
	#timer.start()
	await get_tree().create_timer(0.5).timeout
	#get_tree().change_scene_to_file(next_level)
	#Engine.time_scale=1
	
	DialogueManager.show_dialogue_balloon(DIALOG_TIME, "start")
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(dialogue):
	#GameManager.fade_out_music(audio_stream_player_2d)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	print("end level")
	get_tree().change_scene_to_packed(intro_end)
 
