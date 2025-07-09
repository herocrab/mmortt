extends NetworkState

class_name Conclude

func _enter_state() -> void:
    _log_state()

func _log_state():
    Logger.write("INFO", "Server has entered the CONCLUDE state.")