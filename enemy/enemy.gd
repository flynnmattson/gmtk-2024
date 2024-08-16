extends CharacterBody3D

@export var target:Node

func _physics_process(delta):
	var inVec = global_position - target.global_position.normalized #
