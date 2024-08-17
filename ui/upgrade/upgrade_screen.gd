extends CanvasLayer
class_name UpgradeScreen


@onready var shrink_container: PanelContainer = %ShrinkContainer
@onready var grow_container: PanelContainer = %GrowContainer
@onready var next_level_button: Button = %NextLevelButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shrink_container.gui_input.connect(_on_shrink_input)
	grow_container.gui_input.connect(_on_grow_input)
	next_level_button.pressed.connect(_on_next_level_pressed)


func _on_shrink_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		GameEvent.emit_shrink()


func _on_grow_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		GameEvent.emit_grow()


func _on_next_level_pressed() -> void:
	next_level_button.disabled = true
	GameEvent.emit_next_level()


func enable() -> void:
	next_level_button.disabled = false
	visible = true
