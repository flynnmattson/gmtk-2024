extends Node3D
class_name Level

@onready var level_manager: LevelManager = $LevelManager
@onready var enemy_spawner: Node3D = $EnemySpawner
@onready var enemy_spawner_2: Node3D = $EnemySpawner2
@onready var hit_audio: RandomAudioStreamPlayerComponent = $HitAudio
@onready var explode_audio: RandomAudioStreamPlayerComponent = $ExplodeAudio


@export var camOffset = Vector3(0, 3.5, 5)
@export var start_point = Vector3(0, 0.5, 0)


var player: Player
var currScore = 0
var spawners: Array[EnemySpawner] = []


func _ready() -> void:
	GameEvent.enemy_hit.connect(_on_enemy_hit)
	GameEvent.kills_updated.connect(_on_kill)
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


func _on_enemy_hit() -> void:
	hit_audio.play_random()


func _on_kill() -> void:
	explode_audio.play_random()
