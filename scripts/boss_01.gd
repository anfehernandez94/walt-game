extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var speed = 50
var health = 400
var direction = 1
var cur_speed = SPEED
var is_hit := false
var is_dead := false
var target_position := Vector2.INF
var area_rect: Rect2

signal boss_died

@onready var hit_audio: AudioStreamPlayer2D = $HitAudio
@onready var dead_audio: AudioStreamPlayer2D = $DeadAudio
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $Killzone
@export var movement_area: Node2D

func _ready():
	if movement_area:
		var shape = movement_area.get_node("CollisionShape2D").shape
		var center = movement_area.global_position
		area_rect = Rect2(center - shape.extents, shape.extents * 2)
		pick_new_target()
		
func get_movement_area():
		if movement_area:
			var shape = movement_area.get_node("CollisionShape2D").shape
			var center = movement_area.global_position
			area_rect = Rect2(center - shape.extents, shape.extents * 2)
			pick_new_target()
		
func _physics_process(delta: float) -> void:
	if is_dead:
		return
	if target_position == Vector2.INF:
		get_movement_area()
		return

	var direction := (target_position - position).normalized()
	velocity = direction * speed

	if position.distance_to(target_position) < 5:
		pick_new_target()
	else:
		move_and_slide()

func pick_new_target():
	var rand_x = randf_range(area_rect.position.x, area_rect.position.x + area_rect.size.x)
	var rand_y = randf_range(area_rect.position.y, area_rect.position.y + area_rect.size.y)
	target_position = Vector2(rand_x, rand_y)

func take_damage(amount : float, from_position := Vector2.ZERO):
	if is_hit:
		return
	health -= amount
	if health <= 0 && !is_dead:
		start_dead()
	if !is_dead:
		start_hit_reaction(from_position)
	
func start_hit_reaction(from_position: Vector2):
	is_hit = true
	animated_sprite_2d.play("hit")
	hit_audio.play()
	await get_tree().create_timer(0.2).timeout
	is_hit = false
	animated_sprite_2d.play("idle")
	

func start_dead():
	is_dead = true
	dead_audio.play()
	animated_sprite_2d.play("hit")
	animated_sprite_2d.stop()
	direction = 0
	killzone.monitoring = false
	await get_tree().create_timer(0.5).timeout
	emit_signal("boss_died")
#	todo Animation destroyed
	queue_free()
