extends Node

var _server_scene_path = "res://scenes/server.tscn"
var _client_scene_path = "res://scenes/client.tscn"

var parameters: Dictionary = {}

var defaults = {
		"server": false,
		"map": "default",
		"players_per_team": 5,
		"number_of_teams": 4
	}

func _ready():
	_parse_args()
	_initialize_logger()
	_log_parameters()
	call_deferred("_change_scene")

func _initialize_logger():
	Logger.initialize()

func _log_parameters():
	Logger.write("INFO", "Server: " + str(parameters["server"]) + ".")
	Logger.write("INFO", "Map: " + parameters["map"] + ".")
	Logger.write("INFO", "Players per team: " + str(parameters["players_per_team"]) + ".")
	Logger.write("INFO", "Number of teams: " + str(parameters["number_of_teams"]) + ".")

func _parse_args():
	var args = OS.get_cmdline_args()
	for arg in args:
		if arg.begins_with("--"):
			var key_val = arg.substr(2).split("=", false, 2)
			if key_val.size() == 2:
				parameters[key_val[0]] = _cast_arg(key_val[1])
			else:
				parameters[key_val[0]] = true

	for key in defaults:
		if not parameters.has(key):
			parameters[key] = defaults[key]
	return parameters

func _change_scene():
	var _next_scene: PackedScene
	if parameters["server"]:
		_next_scene = load(_server_scene_path)
	else:
		_next_scene = load(_client_scene_path)
	get_tree().change_scene_to_packed(_next_scene)
	Logger.write("INFO", "Changing to " + _next_scene.resource_path + ".")

func _cast_arg(value: String) -> Variant:
	if value == "true":
		return true
	if value == "false":
		return false
	if value.is_valid_int():
		return int(value)
	if value.is_valid_float():
		return float(value)
	return value
