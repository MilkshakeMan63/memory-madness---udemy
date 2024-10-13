extends Node


const PATH: String = "res://assets/glitch/"


func _ready() -> void:
	var dir: DirAccess = DirAccess.open(PATH) # open the assets glitch folder

	var image_file_list: ImageFilesList = ImageFilesList.new() 

	if dir: # if true continue
		var files: PackedStringArray = dir.get_files() # get the glitch assets as a string array
		
		for fn in files: # loops through each item in the file collection
			print(fn) # prints the current item if it does not contain .import.
			image_file_list.add_file_name(PATH + fn) #adding the path and file name to the string array
	ResourceSaver.save(image_file_list, "res://Scripts/Resources/image_files_list.tres") # saving the files paths to the resource script
