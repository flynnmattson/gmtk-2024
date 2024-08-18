extends CanvasLayer
class_name MainMenu

@onready var start: Button = %Start
@onready var quit: Button = %Quit
@onready var about: Button = %About

func _ready() -> void:
	start.pressed.connect(GameEvent.emit_start_game)
	quit.pressed.connect(_quit)
	about.pressed.connect(_about)
	#if event is InputEventMouseButton:
		#$MarginContainer/InfoWindow.visible = false
	
func _quit() -> void:
	get_tree().quit()
	
func _about() -> void:
	$MarginContainer/InfoWindow.visible = true
