extends NetworkState

class_name Join

var _loadout : Dictionary = {}
var _abilities: Dictionary = {}

func _enter_state() -> void:
    _log_state()

func make_selection(loadout : Dictionary, abilities: Dictionary) -> void:
    _loadout = loadout
    _abilities = abilities

func _log_state():
    Logger.write("INFO", "Client has entered the JOIN state.")