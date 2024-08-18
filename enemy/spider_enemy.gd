extends RigidBody3D

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var animation_player: AnimationPlayer = %AnimationPlayer

@export var force: int
@export var target: RigidBody3D
@export var currencyScene: PackedScene
@export var explosionScene: PackedScene


func _ready() -> void:
	animation_player.play("goodrun", -1, 2.0)


func _physics_process(delta: float) -> void:
	if target != null:
		var inVec = (target.global_position - global_position).normalized()
		apply_central_force(inVec * force * delta)


func launch(direction: Vector3) -> void:
	animation_player.stop()
	animation_player.play("jump", -1, 2.0)
	axis_lock_angular_x = false
	axis_lock_angular_y = false
	axis_lock_angular_z = false
	apply_impulse(direction, Vector3(0, 0.1, 0))
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
