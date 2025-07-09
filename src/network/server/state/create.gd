extends NetworkState

class_name Create

@export var match_name: String = "default"

var _socket: NakamaSocket
var _match: NakamaRTAPI.Match

func _enter_state() -> void:
	_log_state()
	_cache_host()
	_create_match()

func _log_state() -> void:
	Logger.write("INFO", "Server has entered the CREATE state.")

func _cache_host():
	_socket = Host.socket

func _create_match():
	_match = await _socket.create_match_async(match_name)
	if _match.is_exception():
		Logger.write("ERROR", "Nakama server not able to create a match.")
	else:
		Logger.write("INFO", "Nakama server created match id: " + _match.match_id + ".")
	_to_next_state()
