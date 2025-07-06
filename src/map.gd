extends Node

class_name Map

@export var maps : Dictionary = {}

var navigation: Navigation

var _map_instance : Node
var _tile_map_layer : TileMapLayer


func _ready() -> void:
	_load_map()
	_cache_tile_map_layer()
	_load_navigation()

func _cache_tile_map_layer():
	for child in _map_instance.get_children():
		if child is TileMapLayer:
			_tile_map_layer = child
			Logger.write("INFO", "TileMapLayer has been cached by map scene.")
		else:
			Logger.write("ERROR", "Map cannot locate TileMapLayer.")
			push_error("Map cannot locate TileMapLayer")

func _load_navigation():
	navigation = Navigation.new()
	navigation.load_tile_map_layer(_tile_map_layer)

func _load_map():
	var map_name = Launcher.parameters["map"]
	var map_scene = maps[map_name] as PackedScene
	_map_instance = map_scene.instantiate()
	add_child(_map_instance)
	Logger.write("INFO", "Map instance has been added to the scene.")

func _exit_tree() -> void:
	if _map_instance != null and _map_instance.get_parent() != null:
		remove_child(_map_instance)
