extends CanvasLayer
class_name MainMenu

@onready var start: Button = %Start
@onready var quit: Button = %Quit
@onready var about: Button = %About
@onready var video_stream_player: VideoStreamPlayer = $AspectRatioContainer/VideoStreamPlayer
@onready var about_info: TextureRect = %AboutInfo
@onready var about_container: MarginContainer = %AboutContainer


func _ready() -> void:
	start.pressed.connect(GameEvent.emit_start_game)
	quit.pressed.connect(_quit)
	about.pressed.connect(_about)
	about_info.gui_input.connect(_on_about_info_input)
	video_stream_player.expand = true
	#if event is InputEventMouseButton:
		#$MarginContainer/InfoWindow.visible = false


func _quit() -> void:
	get_tree().quit()


func _about() -> void:
	about_container.visible = true


func _on_about_info_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		about_container.visible = false
