extends Control

const MEMORY_TILE = preload("res://Scenes/memory_tile.tscn")

@onready var tiles_container: GridContainer = $HBoxContainer/MarginContainer/TilesContainer
@onready var scorer: Scorer = $Scorer
@onready var label_moves: Label = $HBoxContainer/MarginContainer2/VBoxContainer/HBoxContainerMoves/LabelMoves
@onready var label_pairs: Label = $HBoxContainer/MarginContainer2/VBoxContainer/HBoxContainerPairs/LabelPairs


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_level_selected.connect(on_level_selected) # waiting for the signal to be emitted when the level button is pressed and connecting it to the function below. 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label_moves.text = scorer.get_moves_made()
	label_pairs.text = scorer.get_pairs_made()


func add_memory_tile(image: ItemImage, frame: Texture2D):
	var new_tile: MemoryTile = MEMORY_TILE.instantiate()
	tiles_container.add_child(new_tile)
	new_tile.setup(image, frame)


func on_level_selected(level_num: int): # when a level button is pressed it will emit a signal with the level number
	var level_data: SelectedLevelData = GameManager.get_level_selection(level_num) # get some new random tiles from the game manager
	var frame: Texture2D = ImageManager.get_random_frame_image() # get a random frame
	
	tiles_container.columns = level_data.get_num_cols() # set the columns on the tile container

	for item_image in level_data.get_selected_level_images():
		add_memory_tile(item_image, frame) # add a memory tile passing in item image and frame

	scorer.clear_new_game(level_data.get_target_pairs())

func _on_exit_button_pressed() -> void:
	for tiles in tiles_container.get_children(): # loop through and get all the children in tiles container
		tiles.queue_free() # delete all the children from the tiles container
	
	SignalManager.on_game_exit_pressed.emit()
	
