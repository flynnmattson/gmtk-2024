class_name Enemy
extends RigidBody3D

@onready var collision_shape: CollisionShape3D = $CollisionShape3D

@export var force: int = 100
@export var target: RigidBody3D

var offset = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if collision_shape.shape is SphereShape3D:
		offset = Vector3(0, collision_shape.shape.radius / 5, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var inVec = (target.global_position - global_position).normalized() #
	inVec.y = 0

	apply_force(inVec * force * delta, offset)
