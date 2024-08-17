class_name Player
extends RigidBody3D

@onready var collision_shape: CollisionShape3D = $CollisionShape3D

@export var force:int
var offset = Vector3(0, 0, 0)

func _ready() -> void:
	if collision_shape.shape is SphereShape3D:
		offset = Vector3(0, collision_shape.shape.radius / 5, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var inVec = Vector2(0, 0) #Input vector. The direction (x, z) the player wants to go.
	
	inVec.x += Input.get_action_strength("move_right")
	inVec.y += Input.get_action_strength("move_down")
	inVec.x -= Input.get_action_strength("move_left")
	inVec.y -= Input.get_action_strength("move_up")
	
	var moveVec = Vector3(inVec.x, 0, inVec.y)
	
	apply_force(moveVec * force * delta, offset)
