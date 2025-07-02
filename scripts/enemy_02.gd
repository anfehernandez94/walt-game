extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var speed = Vector2.ZERO
var health = 40
var direction = 1
var cur_speed = SPEED
var is_hit := false
var is_dead := false

@onready var hit_audio: AudioStreamPlayer2D = $HitAudio
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
	if health <= 0 && !is_dead:
		start_dead()
	start_hit_reaction(from_position)

func start_dead():
	is_dead = true
	dead_audio.play()
	animated_sprite_2d.play("dead")
	direction = 0
	killzone.monitoring = false
#	todo Animation destroyed
	
func start_hit_reaction(from_position: Vector2):
	is_hit = true
	hit_audio.play()
	#await get_tree().create_timer(0.1).timeout
	is_hit = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "dead":
		queue_free()
