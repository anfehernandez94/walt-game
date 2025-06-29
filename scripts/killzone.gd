extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		print("Died1")
		body.start_dead()
		#body.get_node("PlayerCollision").queue_free()
		#print('1 ' + body.get_node("AnimatedSprite2D").animation)
		#body.get_node("AnimatedSprite2D").play("dead")
		#print('2 ' + body.get_node("AnimatedSprite2D").animation)
		#print('3 ' + str(body.is_dead))
		#body.is_dead = true
		#print('3 ' + str(body.is_dead))
		#body.get_node("AnimatedSprite2D").stop()
		Engine.time_scale=0.2
		print("Died2")
		timer.start()

func _on_timer_timeout() -> void:
	print("Died3")
	
	get_tree().reload_current_scene()
	Engine.time_scale=1
	print("Died4")
	
