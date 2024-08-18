extends Node


signal player_health_updated(health_component: HealthComponent)
signal charge_updated(charge_percent: float)
signal start_game()
signal game_over()
signal currency_updated()
signal kills_updated()
signal grow()
signal shrink()
signal next_level()
signal level_ended()
signal enemy_hit()
signal reset()


func emit_player_health_updated(health_component: HealthComponent) -> void:
	player_health_updated.emit(health_component)


func emit_charge_updated(charge_percent: float) -> void:
	charge_updated.emit(charge_percent)


func emit_start_game() -> void:
	start_game.emit()


func emit_game_over() -> void:
	game_over.emit()


func emit_currency_updated() -> void:
	currency_updated.emit()


func emit_enemy_hit() -> void:
	enemy_hit.emit()


func emit_kills_updated() -> void:
	kills_updated.emit()


func emit_grow() -> void:
	grow.emit()


func emit_shrink() -> void:
	shrink.emit()


func emit_next_level() -> void:
	GameStat.level += 1
	next_level.emit()


func emit_level_ended() -> void:
	level_ended.emit()


func emit_reset() -> void:
	reset.emit()
