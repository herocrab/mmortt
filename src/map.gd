extends Node2D

class_name Map

@export_group("Debug Navigation Settings")
@export var start_pos : Vector2i = Vector2i(1,1)
@export var end_pos : Vector2i = Vector2i(14,10)
@export var debug_path : bool = true
@export var debug_color: Color = Color(0, 1, 0)
@export var debug_border_thickness: float = 2.0

@export_group("Map Settings")
@export var navigation_layer_name = "Navigation"

@export_group("Map Database")
@export var maps : Dictionary = {}

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
		#print(child.name)
		if child is TileMapLayer and child.name == navigation_layer_name:
			_tile_map_layer = child
			Logger.write("INFO", "TileMapLayer has been cached by map scene.")
	if _tile_map_layer == null:
		Logger.write("ERROR", "Map cannot locate TileMapLayer.")
		push_error("Map cannot locate TileMapLayer")

func _load_navigation():
	Navigation.load_tile_map_layer(_tile_map_layer)

func _debug_navigation():
	if debug_path:
		_debug_world_path = Navigation.get_presentation_world_path_from_fixed_grid_start_stop(start_pos, end_pos)

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
	var cell_size = Navigation.get_cell_size()
	for pos in _debug_world_path:
		var rect = Rect2(pos, cell_size)
		draw_rect(rect, debug_color, false, debug_border_thickness)
