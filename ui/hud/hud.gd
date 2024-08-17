class_name HUD
extends CanvasLayer


@onready var player_health_bar: ProgressBar = %PlayerHealthBar
@onready var charge_bar: ProgressBar = %ChargeBar
@onready var currency: Label = %Currency
@onready var kills: Label = %Kills
@onready var timer: Label = %Timer


@export var level_manager: LevelManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvent.start_game.connect(_reset_health)
	GameEvent.player_health_updated.connect(_on_player_health_updated)
	GameEvent.charge_updated.connect(_on_charge_updated)
	GameEvent.currency_updated.connect(_on_currency_updated)
	GameEvent.kills_updated.connect(_on_kills_updated)


func _process(delta: float) -> void:
	if level_manager == null:
		return
	
	var time_elapsed = level_manager.get_time_left()
	timer.text = _format_seconds_to_string(time_elapsed)


func _format_seconds_to_string(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))


func _on_player_health_updated(health_percent: float) -> void:
	player_health_bar.value = health_percent


func _on_charge_updated(charge_percent: float) -> void:
	charge_bar.value = charge_percent


func _on_currency_updated() -> void:
	currency.text = str(GameStat.currency)


func _on_kills_updated() -> void:
	kills.text = str(GameStat.kills)


func _reset_health() -> void:
	player_health_bar.value = 1.0
