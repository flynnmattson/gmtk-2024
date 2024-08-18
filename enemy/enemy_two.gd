class_name Enemy
extends RigidBody3D

@onready var collision_shape: CollisionShape3D = $CollisionShape3D

@export var force: int = 100
@export var target: RigidBody3D
@export var currencyScene: PackedScene
@export var explosionScene: PackedScene

var offset = Vector3.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if collision_shape.shape is SphereShape3D:
		offset = Vector3(0, collision_shape.shape.radius / 5, 0)


func _physics_process(delta: float) -> void:
	if target != null:
		var inVec = (target.global_position - global_position).normalized()
		apply_force(inVec * force * delta, offset)


func launch(direction: Vector3) -> void:
	apply_central_impulse(direction)
	Callable(set_destroy).call_deferred()


func set_destroy() -> void:
	body_entered.connect(_destroy)


func _destroy(body: Node) -> void:
	GameStat.gain_kill()
	spawn_currency()
	spawn_explosion()
	Callable(queue_free).call_deferred()


func spawn_explosion() -> void:
	var explosion = explosionScene.instantiate()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	explosion.emit()


func spawn_currency() -> void:
	for n in randi_range(1, 3):
		var currency = currencyScene.instantiate() as Currency
		get_parent().add_child(currency)
		currency.global_position = global_position
		var x = randf_range(-1.0, 1.0)
		var z = randf_range(-1.0, 1.0)
		var y = randf_range(0.5, 1.0)
		currency.apply_central_impulse(Vector3(x, y, z) * 4)
