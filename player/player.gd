extends RigidBody3D

@export var force:int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var inVec = Vector2(0, 0) #Input vector. The direction (x, z) the player wants to go.
	
	inVec.x += Input.get_action_strength("move_right")
	inVec.y += Input.get_action_strength("move_down")
	inVec.x -= Input.get_action_strength("move_left")
	inVec.y -= Input.get_action_strength("move_up")
	
	var moveVec = Vector3(inVec.x, 0, inVec.y)
	
	apply_central_impulse(moveVec * force * delta)
