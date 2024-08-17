extends CanvasLayer
class_name MainMenu

@onready var start: Button = %Start


func _ready() -> void:
	start.pressed.connect(GameEvent.emit_start_game)
