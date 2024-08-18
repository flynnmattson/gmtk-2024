class_name Player
extends RigidBody3D


@onready var collision_shape: CollisionShape3D = $Shape
@onready var health_component: HealthComponent = $HealthComponent
@onready var scale_node_3d: Node3D = $ScaleNode3D
@onready var character_rider: CharacterRider = %CharacterRider
@onready var speed_sound: AudioStreamPlayer = $SpeedSound
@onready var hit_sparks: CPUParticles3D = $HitSparks


@export var growFactor: float
@export var health_gain: int
@export var shrinkFactor: float
@export var speedGain: int
@export var superThreshold: float
@export var normalColor:Color = Color("5f7c4f78")
@export var superColor:Color = Color("a6527578")
@export var force: int
@export var pitch_floor: float


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


func reset() -> void:
	health_component.heal(health_component.max_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var inVec = Vector2(0, 0) #Input vector. The direction (x, z) the player wants to go.
	
	inVec.x += Input.get_action_strength("move_right")
	inVec.y += Input.get_action_strength("move_down")
	inVec.x -= Input.get_action_strength("move_left")
	inVec.y -= Input.get_action_strength("move_up")

	var moveVec = Vector3(inVec.x, 0, inVec.y)

	if moveVec != Vector3.ZERO:
		character_rider.run()
	else:
		character_rider.rest()
	apply_force(moveVec * force * delta, offset)
	
	var magnitude = linear_velocity.length()
	if magnitude == 0.0:
		GameEvent.emit_charge_updated(0.0)
		if speed_sound.playing:
			speed_sound.stop()
	else:
		if not speed_sound.playing:
			speed_sound.play()
		speed_sound.pitch_scale = clamp(magnitude * 0.1, 0.0, 1)
		GameEvent.emit_charge_updated(clamp(magnitude / superThreshold, 0.0, 1.0))

	if linear_velocity.length() > superThreshold and not isSuper:
		isSuper = true
		#$Sphere.mesh.material.albedo_color = superColor
		
	elif linear_velocity.length() < superThreshold and isSuper:
		isSuper = false
		#$Sphere.mesh.material.albedo_color = normalColor


func _on_body_entered(body: Node) -> void:
	GameEvent.emit_enemy_hit()

	if not body.is_in_group("enemy"):
		return
	
	if not isSuper:
		health_component.damage(1)
		hit_sparks.emitting = true
	else:
		var enemy = body as RigidBody3D
		var direction = global_position.direction_to(enemy.global_position)
		direction.y += randf_range(0.75, 1.25)
		direction *= 4
		enemy.launch(direction)


func _update_health() -> void:
	GameEvent.emit_player_health_updated(health_component.get_health_percent())


func _on_death() -> void:
	GameEvent.emit_game_over()


func grow() -> void:
	scale_node_3d.scale *= growFactor
	collision_shape.scale *= growFactor
	health_component.max_health += health_gain
	mass += 0.05


func shrink() -> void:
	scale_node_3d.scale *= shrinkFactor
	collision_shape.scale *= shrinkFactor
	force += speedGain
	mass = clampf(mass - 0.01, 0.01, INF)
	physics_material_override.bounce += 0.01
