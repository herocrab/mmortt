extends NetworkState

class_name Load

func _enter_state() -> void:
    _log_state()

func _log_state():
    Logger.write("INFO", "Client has entered the LOAD state.")