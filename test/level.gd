extends Node3D


@export var camOffset = Vector3(0, 3.5, 5)
var currScore = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$Camera.position = camOffset + $Player.position
	$Camera.position.y = camOffset.y #This is why the camera is not a child of the player.
