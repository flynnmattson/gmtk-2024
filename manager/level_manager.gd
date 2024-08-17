extends Node
class_name LevelManager

@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_time_left():
	return timer.time_left


func _on_timer_timeout() -> void:
	GameEvent.emit_level_ended()
