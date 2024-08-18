extends CanvasLayer
class_name EndScreen

@onready var exit_button: Button = %ExitButton
@onready var kill_label: Label = %KillLabel
@onready var level_label: Label = %LevelLabel


func _ready() -> void:
	exit_button.pressed.connect(exit)


func enable() -> void:
	visible = true
	kill_label.text = "Kill Count: " + str(GameStat.kills)
	level_label.text = "Level Reached: " + str(GameStat.level)
	get_tree().paused = true


func exit() -> void:
	visible = false
	get_tree().paused = false
	GameEvent.emit_reset()
