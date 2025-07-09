extends NetworkState

class_name Join

@export_group("Player Defaults")
@export var loadout : Dictionary = {}
@export var abilities: Dictionary = {}
@export var use_defaults: bool = true

func _enter_state() -> void:
    _log_state()

func _log_state():
    Logger.write("INFO", "Client has entered the JOIN state.")