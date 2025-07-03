extends Area2D  # or CharacterBody2D if using physics

@export var speed: float = 400.0
@export var direction: Vector2 = Vector2.RIGHT
const DAMAGE = 5

func _process(delta):
	position += direction.normalized() * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(DAMAGE + GameManager.score, global_position)
		queue_free()
