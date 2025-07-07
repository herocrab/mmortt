extends Node2D

class_name Map

@export_group("Debug Navigation Settings")
@export var start_pos : Vector2i = Vector2i(1,1)
@export var end_pos : Vector2i = Vector2i(14,10)
@export var debug_path : bool = true
@export var debug_box_size: Vector2 = Vector2(40, 40)
@export var debug_box_offset: Vector2 = Vector2(5, 5)
@export var debug_box_border_color: Color = Color(0, 1, 0)
@export var debug_box_border_thickness: float = 10.0

@export_group("Map Database")
@export var maps : Dictionary = {}

var navigation: Navigation

var _map_instance : Node
var _tile_map_layer : TileMapLayer
var _debug_world_path : PackedVector2Array

func _ready() -> void:
	_load_map()
	_cache_tile_map_layer()
	_load_navigation()
	_debug_navigation()

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

func _debug_navigation():
	if debug_path:
		_debug_world_path = navigation.get_world_path(start_pos, end_pos)

func _load_map():
	var map_name = Launcher.parameters["map"]
	var map_scene = maps[map_name] as PackedScene
	_map_instance = map_scene.instantiate()
	add_child(_map_instance)
	Logger.write("INFO", "Map instance has been added to the scene.")

func _exit_tree() -> void:
	if _map_instance != null and _map_instance.get_parent() != null:
		remove_child(_map_instance)

func _draw():
	for pos in _debug_world_path:
		var rect = Rect2(pos + debug_box_offset, debug_box_size)
		draw_rect(rect, debug_box_border_color, false, debug_box_border_thickness)
