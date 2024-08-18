extends CanvasLayer
class_name TutorialScreen


@onready var video_stream_player: VideoStreamPlayer = %VideoStreamPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func enable() -> void:
	visible = true
	video_stream_player.play()
	audio_stream_player.play()
