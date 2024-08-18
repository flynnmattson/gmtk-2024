extends Node3D
class_name CharacterRider

@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func run() -> void:
	animation_player.play("run", 0, 2.0)


func rest() -> void:
	animation_player.play("rest", 0, 2.0)
