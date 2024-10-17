extends CanvasLayer


@onready var main: Control = $Main
@onready var game: Control = $Game


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)
	SignalManager.on_level_selected.connect(on_level_selected)
	show_game(false)


func show_game(s: bool):
	game.visible = s
	main.visible = not s


func on_game_exit_pressed():
	show_game(false)


func on_level_selected(level_num: int):
	show_game(true)
