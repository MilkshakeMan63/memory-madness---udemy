extends Node

class_name Scorer


@onready var reveal_timer: Timer = $RevealTimer
@onready var sound: AudioStreamPlayer = $Sound


var _selections: Array[MemoryTile] = []
var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_tile_selected.connect(on_tile_selected)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)
	
	
func get_moves_made() -> String:
	return str(_moves_made)
	
	
func get_pairs_made() -> String:
	return "%d/%d" % [ _pairs_made, _target_pairs]
	
	
func clear_new_game(target_pairs: int):
	_selections.clear()
	_target_pairs = target_pairs
	_moves_made = 0
	_pairs_made = 0
	
	
func kill_tiles():
	for tiles in _selections: # looping _selections in var tile
		tiles.kill_on_success() # running the kill_on_sucess function from the memory script which is what _selections is a var of.
	_pairs_made += 1
	SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)
	pass

func selections_are_pair() -> bool:
	return _selections[0].matches_other_tile(_selections[1])
	
	
func check_pair_made():
	if _selections.size() != 2: # if not equal to 2, return 
		return
	reveal_timer.start()
	SignalManager.on_selection_disabled.emit() # can't make any more inputs
	_moves_made +=1
	
	if selections_are_pair() == true: # if selection 1 and 2 are the same tile continue down.
		kill_tiles()


func check_game_over():
	if _target_pairs == _pairs_made:
		SignalManager.on_game_over.emit(_moves_made)


func on_tile_selected(tile: MemoryTile):
	tile.reveal(true) # show tile that is selected
	_selections.append(tile) # add the shown tile to the _selections array
	check_pair_made() # check if two selections have been made, if so continue running the check_pair_made fucntion above.
	SoundManager.play_tile_click(sound)


func on_game_exit_pressed():
	reveal_timer.stop()


func _on_reveal_timer_timeout() -> void:
	if selections_are_pair() == false:
		for s in _selections: # loop through both selected tiles
			s.reveal(false) # if the selected tiles are not pairs hide the tiles after the timer runs out.
	_selections.clear() # clear _selections array
	check_game_over()
	SignalManager.on_selection_enabled.emit() # emit to allow for inputs to happen again.
