extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var speed = Vector2.ZERO
var health = 40
var direction = 1
var cur_speed = SPEED
var is_hit := false

@onready var dead_audio: AudioStreamPlayer2D = $DeadAudio
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $Killzone

func _physics_process(delta: float) -> void:
	velocity = speed

	move_and_slide()

func take_damage(amount : float, from_position := Vector2.ZERO):
	if is_hit:
		return
	health -= amount
	if health <= 0:
		start_dead()

func start_dead():
	dead_audio.play()
	animated_sprite_2d.stop()
	direction = 0
	killzone.monitoring = false
#	todo Animation destroyed
	queue_free()
