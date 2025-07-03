extends Node2D

@onready var boss_movement_area: StaticBody2D = $BossMovementArea
@onready var boss_01: CharacterBody2D = $Boss01
@onready var enemy_spawner: Node2D = $EnemySpawner
@onready var item_03: Area2D = $Item03


func _ready() -> void:
	boss_01.movement_area = boss_movement_area 
	boss_01.boss_died.connect(end_level)
	
func end_level():
	enemy_spawner.stop_spawner()
	await get_tree().create_timer(0.5).timeout
	item_03.monitoring = true
	item_03.visible = true
