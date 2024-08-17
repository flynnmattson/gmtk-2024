extends Node3D

@onready var timer: Timer = $Timer

@export var enemyScene: PackedScene
@export var target: RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timeout() -> void:
	var enemy = enemyScene.instantiate() as Enemy
	get_parent().add_child(enemy)
	enemy.global_position = global_position
	enemy.target = target
