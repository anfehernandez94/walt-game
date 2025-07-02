extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: Area2D = $AttackArea
@onready var attack_collision: CollisionShape2D = $AttackArea/AttackCollision
@onready var player_collision: CollisionShape2D = $PlayerCollision
@onready var dead_audio: AudioStreamPlayer2D = $DeadAudio
@onready var attack_audio: AudioStreamPlayer2D = $AttackAudio

var is_attacking = false
var is_jumping = false
var is_dead = false
var attack_cooldown = 1
var can_attack = true
var can_move = true

#const SPEED = 100.0
#const JUMP_VELOCITY = -300.0
const SPEED = 150.0
const JUMP_VELOCITY = -500.0

func _physics_process(delta: float) -> void:
	if is_dead:
		velocity.y += get_gravity().y * delta
		move_and_slide()
		return

	if !can_move:
		animated_sprite_2d.play("idle")
		return

	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	if Input.is_action_just_pressed("attack") && is_on_floor() && can_attack:
		start_attack()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		direction_right()
	elif direction < 0:
		direction_left()		

	#if is_attacking:
		#return
	if is_on_floor() && !is_attacking:
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		if !is_attacking:
			velocity += get_gravity() * delta
			animated_sprite_2d.play("jump")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()

func start_attack():	
	attack_audio.play()
	is_attacking = true
	can_attack = false
	attack_area.monitoring = true
	animated_sprite_2d.play("attack")  # Play the attack animation
	
func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation == "attack" and animated_sprite_2d.frame == 3:
		attack_collision.disabled = false
	if animated_sprite_2d.animation == "attack" and animated_sprite_2d.frame == 4:
		attack_collision.disabled = true

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "attack":
		attack_area.monitoring = false
		is_attacking = false
		can_attack = true
		attack_collision.disabled = true
	elif  animated_sprite_2d.animation == "jump":
		is_jumping = false
		print('end jumping')    
		

func direction_right():
	animated_sprite_2d.flip_h = false
	attack_area.set_scale(Vector2(1, 1))
	
func direction_left():
	animated_sprite_2d.flip_h = true
	attack_area.set_scale(Vector2(-1, 1))

func start_dead():
	dead_audio.play()
	player_collision.queue_free()
	is_dead = true
	animated_sprite_2d.play("dead") 

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(25, global_position)
		
func set_can_move(value):
	can_move = value
