extends Node


const FRAME_IMAGES: Array[Texture2D] = [
	preload("res://assets/frames/green_frame.png"),
	preload("res://assets/frames/red_frame.png"),
	preload("res://assets/frames/yellow_frame.png"),
]


var _item_images: Array[ItemImage] = []


func _ready() -> void:
	var image_resource: ImageFilesList = load("res://Scripts/Resources/image_files_list.tres") # load the resource with all the image files
	for file_path in image_resource.get_file_names(): # loop through each file and get the file name
		add_file_to_list(file_path) # use the file_path var to load into the add_file_to_list function.


func add_file_to_list(file_path: String): # takes in the file_path as an argument
	var new_item_image: ItemImage = ItemImage.new(file_path.get_file(), load(file_path)) # Creates a new ItemImage object. It initializes it with two arguments: file_path.get_file() (presumably getting the filename from the path) and load(file_path) (loading the file at that path).
	_item_images.append(new_item_image) #Adds the newly created ItemImage object to the _item_images list.


func get_random_frame_image() -> Texture2D:
	return FRAME_IMAGES.pick_random()


func get_random_item_image() -> ItemImage:
	return _item_images.pick_random()


func get_image(index: int) -> ItemImage:
	return _item_images[index]


func shuffle_images():
	_item_images.shuffle()
