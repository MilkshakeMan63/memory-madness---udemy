extends Node


const PATH: String = "res://assets/glitch/"


func _ready() -> void:
	var dir: DirAccess = DirAccess.open(PATH)

	if dir:
		var files: PackedStringArray = dir.get_files()
		
		for fn in files:
			if not '.import' in fn:
				print(fn)
