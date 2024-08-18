extends Node3D
class_name EnemySpawner

@onready var timer: Timer = $Timer

@export var enemyScene: PackedScene
@export var target: RigidBody3D
@export var wait_time: float = 2.5
@export var level_modifier: float = 0.05


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var reduction = 0
	if GameStat.level > 1:
		reduction = clampf(GameStat.level * level_modifier, 0.0, wait_time - level_modifier)
	timer.wait_time = wait_time - reduction
	timer.timeout.connect(_on_timeout)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timeout() -> void:
	var enemy = enemyScene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = global_position
	enemy.target = target
