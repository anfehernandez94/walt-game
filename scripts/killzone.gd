extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		print("Died1")
		body.start_dead()
		Engine.time_scale=0.2
		print("Died2")
		timer.start()

func _on_timer_timeout() -> void:
	print("Died3")
	
	get_tree().reload_current_scene()
	Engine.time_scale=1
	print("Died4")
	
