extends CanvasLayer
class_name UpgradeScreen


@onready var shrink_button: Button = %ShrinkButton
@onready var grow_button: Button = %GrowButton
@onready var next_level_button: Button = %NextLevelButton
@onready var shrink_cost: Label = %ShrinkCost
@onready var grow_cost: Label = %GrowCost

@export var cost: int = 2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shrink_button.pressed.connect(_on_shrink_pressed)
	grow_button.pressed.connect(_on_grow_pressed)
	next_level_button.pressed.connect(_on_next_level_pressed)
	shrink_cost.text = str(cost)
	grow_cost.text = str(cost)


func _on_shrink_pressed() -> void:
	if GameStat.spend_currency(cost):
		GameEvent.emit_shrink()
		_refresh()


func _on_grow_pressed() -> void:
	if GameStat.spend_currency(cost):
		GameEvent.emit_grow()
		_refresh()


func _on_next_level_pressed() -> void:
	next_level_button.disabled = true
	GameEvent.emit_next_level()


func _refresh() -> void:
	if GameStat.currency < cost:
		shrink_button.disabled = true
		shrink_cost.modulate = Color.RED
		grow_button.disabled = true
		grow_cost.modulate = Color.RED
	else:
		shrink_button.disabled = false
		shrink_cost.modulate = Color.WHITE
		grow_button.disabled = false
		grow_cost.modulate = Color.WHITE


func enable() -> void:
	_refresh()
	next_level_button.disabled = false
	visible = true
