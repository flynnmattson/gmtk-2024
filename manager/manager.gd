extends Node

@onready var hud: HUD = $HUD
@onready var main_menu: CanvasLayer = $MainMenu
@onready var upgrade_screen: UpgradeScreen = $UpgradeScreen
@onready var pause_screen: PauseScreen = $PauseScreen
@onready var end_screen: EndScreen = $EndScreen
@onready var tutorial_screen: TutorialScreen = $TutorialScreen

@export var levelScene: PackedScene
@export var playerScene: PackedScene

var currLevel: Level
var highScore: int
var hasPlayed: bool = false


func _ready() -> void:
	hud.visible = false
	upgrade_screen.visible = false
	GameEvent.start_game.connect(_start_game)
	GameEvent.game_over.connect(_game_over)
	GameEvent.next_level.connect(_next_level)
	GameEvent.level_ended.connect(_level_ended)
	GameEvent.reset.connect(_reset)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") and currLevel != null and not upgrade_screen.visible and not end_screen.visible:
		if not pause_screen.visible:
			pause_screen.visible = true
			get_tree().paused = true
	
	if Input.is_action_just_pressed("left_click") and tutorial_screen.visible:
		tutorial_screen.visible = false
		GameEvent.emit_start_game()


func _start_game() -> void:
	main_menu.visible = false

	if not hasPlayed:
		hasPlayed = true
		tutorial_screen.enable()
		return
	
	GameStat.reset()
	hud.visible = true
	var player = playerScene.instantiate() as Player
	currLevel = levelScene.instantiate() as Level
	currLevel.position = Vector3(0, 0, 0)
	add_child(currLevel)
	hud.level_manager = currLevel.level_manager
	currLevel.set_player(player)


func _game_over() -> void:
	end_screen.enable()


func _reset() -> void:
	get_tree().paused = false
	currLevel.queue_free()
	hud.visible = false
	upgrade_screen.visible = false
	main_menu.enable()
	


func _level_ended() -> void:
	upgrade_screen.enable()
	get_tree().paused = true


func _next_level() -> void:
	GameStat.level += 1
	get_tree().paused = false
	var player = currLevel.remove_player()
	player.reset()
	currLevel.queue_free()
	currLevel = levelScene.instantiate() as Level
	currLevel.position = Vector3(0, 0, 0)
	add_child(currLevel)
	hud.level_manager = currLevel.level_manager
	currLevel.set_player(player)
	upgrade_screen.visible = false
