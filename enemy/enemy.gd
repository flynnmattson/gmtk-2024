extends CharacterBody3D

@export var speed:int
@export var target:Node

func _physics_process(delta):
	var inVec = (target.global_position - global_position).normalized() #
	
	velocity = inVec * speed * delta
	velocity.y = 0
	move_and_slide()
