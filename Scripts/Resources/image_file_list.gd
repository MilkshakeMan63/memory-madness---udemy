extends Resource


class_name  ImageFilesList


@export var file_name: Array[String]


func add_file_name(fn: String):
	if not '.import' in fn: # checks if the current item fn does not contain the string .import.
		file_name.append(fn) # add to the array what is fed into this function that is a string.


func get_file_names():
	return file_name
