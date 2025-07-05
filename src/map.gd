extends Node

class_name Map

@export var maps : Dictionary = {}

var _map_instance : Node

func _ready() -> void:
	var map_name = Launcher.parameters["map"]
	var map_scene = maps[map_name] as PackedScene
	_map_instance = map_scene.instantiate()
	add_child(_map_instance)

func _exit_tree() -> void:
	remove_child(_map_instance)
