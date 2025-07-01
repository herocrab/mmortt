extends Host

@export var match_name: String = "default"

var _match: NakamaRTAPI.Match

func _on_socket_ready():
	_match = await _socket.create_match_async(match_name)
	if _match.is_exception():
		Logger.write("ERROR", "Nakama server not able to create a match.")
	else:
		Logger.write("INFO", "Nakama server created match id: " + _match.match_id + ".")
