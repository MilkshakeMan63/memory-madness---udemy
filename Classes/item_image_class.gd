class_name ItemImage


var _item_name: String
var _item_texture: Texture2D


func _init(item_name: String, item_texture: Texture2D) -> void: # setting up new instances with these parameters
	_item_name = item_name 
	_item_texture = item_texture


func get_texture():
	return _item_texture


func get_item_name():
	return _item_name
