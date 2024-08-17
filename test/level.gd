extends Node3D

signal death

@export var camOffset = Vector3(0, 3.5, 5)
var currScore = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$Camera.position = camOffset + $Player.position
	$Camera.position.y = camOffset.y #This is why the camera is not a child of the player.


func _on_player_collision(body):
	pass
	#if body.is_in_group("enemy"):
		#if $Player.linear_velocity.length() > 2:
			#body.die()
			#currScore += 1
			#$Player.grow()
		#else:
			#death.emit(currScore)
		#Check the velocity of the player and see if they have just been hit.
