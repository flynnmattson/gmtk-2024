extends Node
class_name HealthComponent

signal died
signal health_lost
signal health_gained

@export var max_health: float = 10
@export var delay_delete: bool = false


var current_health: float


func _ready() -> void:
	current_health = max_health


func is_dead() -> bool:
	return current_health == 0


func damage(amount: float) -> void:
	current_health = max(current_health - amount, 0)
	health_lost.emit()
	_check_death()


func upgrade(amount: int) -> void:
	max_health += amount
	current_health = max_health


func get_health_percent() -> float:
	if max_health <= 0:
		return 0
	return minf(current_health / max_health, 1)


func heal(amount: float) -> void:
	current_health = min(current_health + amount, max_health)
	health_gained.emit()


func _check_death() -> void:
	if is_dead():
		died.emit()
		if not delay_delete:
			Callable(owner.queue_free).call_deferred()
