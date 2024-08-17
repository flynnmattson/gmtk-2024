extends Node


signal player_health_updated(health_percent: float)
signal charge_updated(charge_percent: float)
signal start_game()
signal game_over()


func emit_player_health_updated(health_percent: float) -> void:
	player_health_updated.emit(health_percent)


func emit_charge_updated(charge_percent: float) -> void:
	charge_updated.emit(charge_percent)


func emit_start_game() -> void:
	start_game.emit()


func emit_game_over() -> void:
	game_over.emit()
