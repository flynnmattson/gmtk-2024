extends Node3D

@export var levelScene:PackedScene
var highScore = 0

var currLevel:Node = null

func _on_start_pressed():
	$Menu.visible = false
	
	currLevel = levelScene.instantiate()
	currLevel.position = Vector3(0, 0, 0)
	add_child(currLevel)
	
	currLevel.death.connect(_on_death)

func _on_death(newScore):
	currLevel.queue_free()
	
	if newScore > highScore:
		highScore = newScore
		$Menu/Label.text = str(newScore)
	
	$Menu.visible = true
