extends Node2D

@export var enemy_scene: PackedScene = preload("res://scenes/enemy_02.tscn")
@export var end_spawn_interval: float = 2  # seconds between spawns
@export var start_spawn_interval: float = 0.8  # seconds between spawns
@export var wait_time: float = 0  # seconds between spawns
@export var next_level: String = "res://levels/level_02.tscn"
@onready var area_spawner: CollisionShape2D = $StaticBody2D/AreaSpawner
@onready var player_ship: CharacterBody2D = $"../PlayerShip"

var timer: Timer

func _ready():
	await get_tree().create_timer(0.5).timeout
	timer = Timer.new()
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	randomize_spawn_interval()

func _on_timer_timeout():
	spawn_enemy()
	randomize_spawn_interval()

func randomize_spawn_interval():
	timer.wait_time = randf_range(start_spawn_interval, end_spawn_interval)

func stop_spawner():
	timer.stop()

func spawn_enemy():
	if enemy_scene == null:
		print("No enemy scene assigned!")
		return

	var enemy = enemy_scene.instantiate()
	var shape = area_spawner.shape.extents * area_spawner.scale
	var x = shape.x
	var y

	if(timer.wait_time > 1.5):
		y = player_ship.global_position.y
	else:		
		y = randf_range(-shape.y, shape.y)

	enemy.global_position = area_spawner.global_position + Vector2(x, y)
	enemy.speed = Vector2(-300,0)
	enemy.rotation = deg_to_rad(-90)
	get_tree().current_scene.add_child(enemy)
