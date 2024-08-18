extends CanvasLayer
class_name PauseScreen

@onready var resume_button: Button = %ResumeButton
@onready var exit_button: Button = %ExitButton


func _ready() -> void:
	resume_button.pressed.connect(resume)
	exit_button.pressed.connect(exit)


func resume() -> void:
	visible = false
	get_tree().paused = false


func exit() -> void:
	visible = false
	get_tree().paused = false
	GameEvent.emit_reset()
