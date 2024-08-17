extends Node

@onready var hud: HUD = $HUD
@onready var main_menu: CanvasLayer = $MainMenu

@export var levelScene:PackedScene


var currLevel: Node
var highScore: int


func _ready() -> void:
	hud.visible = false
	GameEvent.start_game.connect(_start_game)
	GameEvent.game_over.connect(_game_over)


func _start_game() -> void:
	GameStat.reset()
	main_menu.visible = false
	hud.visible = true
	currLevel = levelScene.instantiate()
	currLevel.position = Vector3(0, 0, 0)
	add_child(currLevel)


func _game_over():
	currLevel.queue_free()
	#if newScore > highScore:
		#highScore = newScore
		#$Menu/Label.text = str(newScore)
	hud.visible = false
	main_menu.visible = true
