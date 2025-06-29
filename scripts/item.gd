extends Area2D

@export var next_level: String = "res://levels/level_02.tscn"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	GameManager.end_level()
	print("next")
	animation_player.play("sound")
	Engine.time_scale=0.2
	#timer.start()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(next_level)
	Engine.time_scale=1
	
 
