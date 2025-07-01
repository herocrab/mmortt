extends StateMachineState

class_name ServerCreate

@export var match_name: String = "default"
@export var next_state: StateMachineState

var _socket: NakamaSocket
var _match: NakamaRTAPI.Match

func _enter_state() -> void:
	_cache_host()
	_create_match()

func _cache_host():
	_socket = Host.socket

func _create_match():
	_match = await _socket.create_match_async(match_name)
	if _match.is_exception():
		Logger.write("ERROR", "Nakama server not able to create a match.")
	else:
		Logger.write("INFO", "Nakama server created match id: " + _match.match_id + ".")
