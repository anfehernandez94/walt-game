extends Node2D

@onready var boss_movement_area: StaticBody2D = $BossMovementArea
@onready var boss_01: CharacterBody2D = $Boss01
@onready var enemy_spawner: Node2D = $EnemySpawner


func _ready() -> void:
	boss_01.movement_area = boss_movement_area 
	boss_01.boss_died.connect(enemy_spawner.stop_spawner)
