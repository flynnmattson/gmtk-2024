extends CanvasLayer
class_name TutorialScreen


@onready var video_stream_player: VideoStreamPlayer = %VideoStreamPlayer


func enable() -> void:
	visible = true
	video_stream_player.play()
