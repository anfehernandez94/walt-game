extends CharacterBody2D

@onready var dead_audio: AudioStreamPlayer2D = $DeadAudio
@onready var attack_audio: AudioStreamPlayer2D = $AttackAudio

@export var bullet_scene: PackedScene = preload("res://scenes/bullet_01.tscn")
@export var bullet_speed: float = 400.0
@export var fire_offset: Vector2 = Vector2(16, 0)  # Offset from player position
@onready var fire_timer := Timer.new()
@onready var shoot_point: Marker2D = $ShootPoint
@onready var player_collision: CollisionShape2D = $PlayerCollision

const FIRE_TIMER = 0.4
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_just_pressed("attack") and fire_timer.is_stopped():
		shoot()
		fire_timer.start(FIRE_TIMER) 
	

	if direction.length() > 0:
		direction = direction.normalized()

	velocity = direction * SPEED
	move_and_slide()

func start_dead():
	dead_audio.play()
	player_collision.queue_free()
	#is_dead = true
	#animated_sprite_2d.play("dead") 
	
func shoot():
	var bullet = bullet_scene.instantiate()
	var bullet_direction = Vector2.RIGHT
	#bullet.global_position = global_position + fire_offset * bullet_direction
	bullet.global_position = shoot_point.global_position
	bullet.direction = bullet_direction
	bullet.speed = bullet_speed
	get_tree().current_scene.add_child(bullet)
