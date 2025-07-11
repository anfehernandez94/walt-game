extends Node2D

const SPEED = 40
const HURT_COOLDOWN = 0.5

var health = 50
var direction = 1
var cur_speed = SPEED
var is_hit := false

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $Killzone
@onready var hit_audio: AudioStreamPlayer2D = $HitAudio
@onready var dead_audio: AudioStreamPlayer2D = $DeadAudio

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
		
	position.x += cur_speed * delta * direction

func take_damage(amount : float, from_position := Vector2.ZERO):
	if is_hit:
		return
	health -= amount
	if health <= 0:
		start_dead()
	start_hit_reaction(from_position)

# Change the direction
func start_hit_reaction(from_position: Vector2):
	is_hit = true
	animated_sprite_2d.play("hit")
	hit_audio.play()
	cur_speed = 40 * 0.1
	direction = direction * (-1)
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	await get_tree().create_timer(0.1).timeout
	cur_speed = SPEED
	is_hit = false
	animated_sprite_2d.play("default")

func start_dead():
	dead_audio.play()
	animated_sprite_2d.stop()
	direction = 0
	killzone.monitoring = false
#	todo Animation destroyed
	await get_tree().create_timer(HURT_COOLDOWN).timeout
	queue_free()
