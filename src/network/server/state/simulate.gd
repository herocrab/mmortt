extends NetworkState

class_name Simulate

func _enter_state() -> void:
    _begin_simulation()

func _begin_simulation() -> void:
    Logger.write("INFO", "Server has started network simulation.")
