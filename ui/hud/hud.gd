class_name HUD
extends CanvasLayer


@onready var player_health_bar: ProgressBar = %PlayerHealthBar
@onready var charge_bar: ProgressBar = %ChargeBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvent.start_game.connect(_reset_health)
	GameEvent.player_health_updated.connect(_on_player_health_updated)
	GameEvent.charge_updated.connect(_on_charge_updated)


func _on_player_health_updated(health_percent: float) -> void:
	player_health_bar.value = health_percent


func _on_charge_updated(charge_percent: float) -> void:
	charge_bar.value = charge_percent


func _reset_health() -> void:
	player_health_bar.value = 1.0
