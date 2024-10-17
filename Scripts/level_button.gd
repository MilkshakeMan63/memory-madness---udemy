extends TextureButton

@onready var label: Label = $Label
@export var level_number = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_level()


func get_level():
	var level_data: LevelData = GameManager.get_level(level_number)
	label.text = "%dx%d" % [level_data.get_cols(), level_data.get_rows()] # %d is used for formatting integers, whereas %s is used for formatting strings. Since level_data.get_cols() and level_data.get_rows() return integer values (number of columns and rows)


func _on_pressed() -> void:
	SignalManager.on_level_selected.emit(level_number)
