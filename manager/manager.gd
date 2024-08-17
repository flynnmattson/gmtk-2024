extends Node

@onready var hud: HUD = $HUD
@onready var main_menu: CanvasLayer = $MainMenu
@onready var upgrade_screen: UpgradeScreen = $UpgradeScreen

@export var levelScene: PackedScene
@export var playerScene: PackedScene

var currLevel: Level
var highScore: int


func _ready() -> void:
	hud.visible = false
	upgrade_screen.visible = false
	GameEvent.start_game.connect(_start_game)
	GameEvent.game_over.connect(_game_over)
	GameEvent.next_level.connect(_next_level)
	GameEvent.level_ended.connect(_level_ended)


func _start_game() -> void:
	GameStat.reset()
	main_menu.visible = false
	hud.visible = true
	var player = playerScene.instantiate() as Player
	currLevel = levelScene.instantiate() as Level
	currLevel.position = Vector3(0, 0, 0)
	add_child(currLevel)
	hud.level_manager = currLevel.level_manager
	currLevel.set_player(player)


func _game_over() -> void:
	currLevel.queue_free()
	hud.visible = false
	upgrade_screen.visible = false
	main_menu.visible = true


func _level_ended() -> void:
	upgrade_screen.enable()
	get_tree().paused = true


func _next_level() -> void:
	get_tree().paused = false
	var player = currLevel.remove_player()
	currLevel.queue_free()
	currLevel = levelScene.instantiate() as Level
	currLevel.position = Vector3(0, 0, 0)
	add_child(currLevel)
	hud.level_manager = currLevel.level_manager
	currLevel.set_player(player)
	upgrade_screen.visible = false
