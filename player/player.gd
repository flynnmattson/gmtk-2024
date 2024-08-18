class_name Player
extends RigidBody3D

@onready var collision_shape: CollisionShape3D = $Shape
@onready var health_component: HealthComponent = $HealthComponent
@onready var scale_node_3d: Node3D = $ScaleNode3D


@export var scaleFactor:float
@export var superThreshold:float
@export var normalColor:Color = Color("5f7c4f78")
@export var superColor:Color = Color("a6527578")
@export var force: int


var offset = Vector3(0, 0, 0)
var isSuper:bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	health_component.health_gained.connect(_update_health)
	health_component.health_lost.connect(_update_health)
	health_component.died.connect(_on_death)
	GameEvent.grow.connect(grow)
	GameEvent.shrink.connect(shrink)
	
	if collision_shape.shape is SphereShape3D:
		offset = Vector3(0, collision_shape.shape.radius / 5, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var inVec = Vector2(0, 0) #Input vector. The direction (x, z) the player wants to go.
	
	inVec.x += Input.get_action_strength("move_right")
	inVec.y += Input.get_action_strength("move_down")
	inVec.x -= Input.get_action_strength("move_left")
	inVec.y -= Input.get_action_strength("move_up")
	
	var moveVec = Vector3(inVec.x, 0, inVec.y)
	
	apply_force(moveVec * force * delta, offset)
	
	var magnitude = linear_velocity.length()
	if magnitude == 0.0:
		GameEvent.emit_charge_updated(0.0)
	else:
		GameEvent.emit_charge_updated(clamp(magnitude / superThreshold, 0.0, 1.0))

	if linear_velocity.length() > superThreshold and not isSuper:
		isSuper = true
		#$Sphere.mesh.material.albedo_color = superColor
		
	elif linear_velocity.length() < superThreshold and isSuper:
		isSuper = false
		#$Sphere.mesh.material.albedo_color = normalColor


func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("enemy") or body is not Enemy:
		return
	
	if not isSuper:
		health_component.damage(1)
		$sparks.emitting = true
	else:
		var enemy = body as Enemy
		var direction = global_position.direction_to(enemy.global_position)
		direction.y += randf_range(0.5, 1.0)
		enemy.apply_central_impulse(direction * 4)
		enemy.launch()


func _update_health() -> void:
	GameEvent.emit_player_health_updated(health_component.get_health_percent())


func _on_death() -> void:
	GameEvent.emit_game_over()


func grow() -> void:
	scale_node_3d.scale *= scaleFactor
	collision_shape.scale *= scaleFactor


func shrink() -> void:
	scale_node_3d.scale *= -scaleFactor
	collision_shape.scale *= -scaleFactor
