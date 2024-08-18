extends Node3D
class_name Level

@onready var level_manager: LevelManager = $LevelManager
@onready var enemy_spawner: Node3D = $EnemySpawner
@onready var enemy_spawner_2: Node3D = $EnemySpawner2
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


@export var camOffset = Vector3(0, 3.5, 5)
@export var start_point = Vector3(0, 0.5, 0)


var player: Player
var currScore = 0
var spawners: Array[EnemySpawner] = []


func _ready() -> void:
	GameEvent.enemy_hit.connect(on_enemy_hit)
	for node in get_children():
		if node is EnemySpawner:
			spawners.append(node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player != null:
		$Camera.position = camOffset + player.position
		$Camera.position.y = camOffset.y #This is why the camera is not a child of the player.


func set_player(p: Player) -> void:
	player = p
	add_child(player)
	player.global_position = start_point
	for spawner: EnemySpawner in spawners:
		spawner.target = player


func remove_player() -> Player:
	remove_child(player)
	return player
	
func on_enemy_hit() -> void:
	audio_stream_player.stream.streams
	
