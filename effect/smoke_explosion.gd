extends CPUParticles3D

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(queue_free)


func emit() -> void:
	emitting = true
