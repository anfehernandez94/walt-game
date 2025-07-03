extends CharacterBody2D


const SPEED = 40.0
const JUMP_VELOCITY = -400.0
const HURT_COOLDOWN = 0.2

var speed = Vector2.ZERO
var health = 25
var direction = 1
var cur_speed = SPEED
var is_hit := false
var target_position = Vector2.INF
var is_active = false	#If the enemy is in camera

@onready var target: CharacterBody2D 
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $Killzone
@onready var hit_audio: AudioStreamPlayer2D = $HitAudio
@onready var dead_audio: AudioStreamPlayer2D = $DeadAudio
@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	target = get_tree().get_nodes_in_group("player")[0]
	visible_on_screen_notifier.screen_entered.connect(_on_screen_entered)

func _on_screen_entered():
	await get_tree().create_timer(0.2).timeout
	pick_new_target()	
	is_active = true

func _physics_process(delta: float) -> void:
	if !is_active:
		return
	if target && target_position != Vector2.INF:
#		Point to the player feet
		if position.distance_to(target_position) < 5:
			pick_new_target()
		var direction := (target_position - position).normalized()
		velocity = direction * SPEED
		move_and_slide()
		
func pick_new_target():
	target_position = target.position + Vector2(0, 15)
	look_at(target_position)
	if target_position.x > position.x:
		animated_sprite_2d.flip_v = false
	else:
		animated_sprite_2d.flip_v = true

		
func take_damage(amount : float, from_position := Vector2.ZERO):
	if is_hit:
		return
	health -= amount
	print(health)
	if health <= 0:
		start_dead()
	start_hit_reaction(from_position)

func start_hit_reaction(from_position: Vector2):
	is_hit = true
	print('hit')
	
	hit_audio.play()
	await get_tree().create_timer(0.1).timeout
	is_hit = false

func start_dead():
	print('dead')
	dead_audio.play()
	animated_sprite_2d.stop()
	direction = 0
	killzone.monitoring = false
	await get_tree().create_timer(HURT_COOLDOWN).timeout
	queue_free()
