extends NetworkState

class_name Result

func _enter_state() -> void:
    _log_state()

func _log_state():
    Logger.write("INFO", "Client has entered the RESULT state.")