extends RigidBody3D
class_name Currency

@onready var area_3d: Area3D = $Area3D


func _ready() -> void:
	area_3d.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		GameStat.gain_currency()
		Callable(queue_free).call_deferred()
