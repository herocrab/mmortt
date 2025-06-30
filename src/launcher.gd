extends Node

var _server_scene_path = "res://scenes/server.tscn"
var _client_scene_path = "res://scenes/client.tscn"

var _next_scene: PackedScene

var network_context: String = "client"

func _ready():
	_initialize_logger()
	_identify_context()
	call_deferred("_change_scene")

func _initialize_logger():
	Logger.initialize()

func _identify_context():
	var args = OS.get_cmdline_args()
	for arg in args:
		print(arg)
		if arg.contains("--server"):
			network_context = "server"
	Logger.write("Network context is " + network_context + ".")

func _change_scene():
	match network_context:
		"server":
			_next_scene = load(_server_scene_path)
		"client":
			_next_scene = load(_client_scene_path)
	get_tree().change_scene_to_packed(_next_scene)
	Logger.write("Changing to " + _next_scene.resource_path + ".")
