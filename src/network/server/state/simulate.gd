extends NetworkState

class_name Simulate

var _server_player : Player

func _enter_state() -> void:
    _log_state()
    _begin_simulation()
    _create_server_player()

func _log_state() -> void:
    Logger.write("INFO", "Server has entered the SIMULATE state.")

func _begin_simulation() -> void:
    Simulation.reset()
    Logger.write("INFO", "Server has started network simulation.")

func _create_server_player() -> void:
    _server_player = Simulation.create_simulation_player()
    #TODO assign control of ai units to the server, needed for live join sync
