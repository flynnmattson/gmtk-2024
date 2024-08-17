extends Node

var currency: int = 0
var kills: int = 0


func gain_currency() -> void:
	currency += 1
	GameEvent.emit_currency_updated()


func spend_currency(amount: int) -> bool:
	if currency >= amount:
		currency -= amount
		GameEvent.emit_currency_updated()
		return true
	return false


func gain_kill() -> void:
	kills += 1
	GameEvent.emit_kills_updated()


func reset() -> void:
	currency = 0
	GameEvent.emit_currency_updated()
	kills = 0
	GameEvent.emit_kills_updated()
