extends CharacterBody3D

@export var speed:int
@export var target:Node

func _physics_process(delta):
	var inVec = (target.global_position - global_position).normalized() #
	inVec.y = 0
	
	velocity = inVec * speed * delta
	move_and_slide()

func die():
	pass #Called by the level when the player hits them hard enough. 
